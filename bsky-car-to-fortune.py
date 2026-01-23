# useful commands:
# curl --config vex.curlrc
# fold --spaces
# fmt --split-only

# references:
# https://docs.bsky.app/blog/repo-export
# https://atproto.com/specs/repository
# https://ipld.io/specs/transport/car/carv1/
# other references scattered in the code

import base64, codecs, sys

def decode_block(data):
    # block lengths are LEB128 (variable-length, little-endian)
    off = 0
    want = 0
    mul = 1
    while True:
        b = data[off]
        off += 1
        if b < 0x80:
            want += b * mul
            break
        want += (b - 0x80) * mul
        mul *= 0x80
    return off+want, data[off:off+want]

# https://www.rfc-editor.org/rfc/rfc8949.html
def decode_cbor_int(data, off, want):
    return off, want

def decode_cbor_neg(data, off, want):
    return off, -1-want

def decode_cbor_bytestring(data, off, want):
    return off+want, data[off:off+want]

def decode_cbor_utf8string(data, off, want):
    return off+want, data[off:off+want].decode("utf-8")

def decode_cbor_array(data, off, want):
    array = []
    for i in range(want):
        n, val = decode_cbor(data[off:])
        off += n
        array.append(val)
    return off, array

def decode_cbor_map(data, off, want):
    mapp = {}
    for i in range(want):
        n, key = decode_cbor(data[off:])
        off += n
        n, val = decode_cbor(data[off:])
        off += n
        mapp[key] = val
    return off, mapp

def decode_cbor_tagged(data, off, want):
    # https://ipld.io/specs/codecs/dag-cbor/spec/
    if want == 0x2A:
        n, val = decode_cbor(data[off:])
        off += n
        assert type(val) is bytes
        # semantically, the multibase code cares about the character, not the
        # specific byte (sequence) used to store it. DAG-CBOR requires it to be
        # NUL, standing for identity, so we don't fuss about decoding it.
        assert val[0] == 0x00
        cid = Cid(val[1:], "\x00")
        assert len(cid.extra) == 0
        return off, cid

    raise NotImplementedError(f"CBOR tagged {want:#x}")

def decode_cbor_value(data, off, want):
    if want == 0x14:
        return off, False
    if want == 0x15:
        return off, True
    if want == 0x16:
        return off, None

    raise NotImplementedError(f"CBOR value {want:#x}")

decode_cbor_table = [
        decode_cbor_int,
        decode_cbor_neg,
        decode_cbor_bytestring,
        decode_cbor_utf8string,
        decode_cbor_array,
        decode_cbor_map,
        decode_cbor_tagged,
        decode_cbor_value,
]

def decode_cbor(data):
    major = data[0] >> 5
    minor = data[0] & 0x1F

    off = 0
    want = 0
    if minor < 0x18:
        off = 1
        want = minor
    elif minor < 0x1C:
        # CBOR sizes are big-endian
        n = 2 ** (minor - 0x18)
        off = n + 1
        want = 0
        for i in range(n):
            want *= 0x100
            want += data[i+1]
    else:
        raise NotImplementedError(f"CBOR minor {minor:#x}")

    return decode_cbor_table[major](data, off, want)

# https://github.com/multiformats/cid
class Cid:
    def __init__(self, data, multibase):
        # https://github.com/multiformats/multibase
        if multibase == "\x00": # Multibase coding: identity
            self.multibase = "none"
        else:
            raise NotImplementedError(f"CID multibase coding {multibase:#x}")

        # https://github.com/multiformats/multicodec
        if data[0] == 0x01: # CID version: CIDv1
            self.version = "cidv1"
        else:
            raise NotImplementedError(f"CID version {data[0]:#x}")

        if data[1] == 0x55: # Content type: raw binary
            self.content_type = "raw"
        elif data[1] == 0x71: # Content type: DAG-CBOR
            self.content_type = "dag-cbor"
        else:
            raise NotImplementedError(f"CID content type {data[1]:#x}")

        # https://github.com/multiformats/multihash
        if data[2] == 0x12: # Hash algorithm: SHA2-256
            self.alg = "sha2-256"
        else:
            raise NotImplementedError(f"CID hash algorithm {data[2]:#x}")

        want = data[3]
        off = 4

        self.bits = want * 8
        self.hash = data[off:off+want]

        self.data = data[:off+want]
        self.extra = data[off+want:]

    def __str__(self):
        return f"Cid({self.multibase} - {self.version} - {self.content_type} - {self.alg}-{self.bits}-{self.hash.hex()})"

    def __repr__(self):
        # "b" is the Multibase prefix for base32 lowercase
        return "b" + base64.b32encode(self.data).decode("utf-8").strip("=").lower()

def flatten_tree(section_map, entries, data_cid):
    if data_cid is None:
        return
    data = section_map[repr(data_cid)]
    left = data["l"]
    flatten_tree(section_map, entries, left)
    prev_key = bytes()
    for entry in data["e"]:
        prefixlen = entry["p"]
        keysuffix = entry["k"]
        key = prev_key[:prefixlen] + keysuffix
        prev_key = key
        [collection, rkey] = key.decode("utf-8").split("/")

        value = section_map[repr(entry["v"])]

        if not collection in entries:
            entries[collection] = []
        entries[collection].append((rkey, value))

        tree = entry["t"]
        flatten_tree(section_map, entries, tree)

def main():
    car_data = sys.stdin.buffer.read()
    car_length = len(car_data)

    off = 0
    blocks = []
    while off < car_length:
        n, data = decode_block(car_data[off:])
        off += n
        blocks.append(data)

    header_data = blocks[0]
    sections_data = blocks[1:]

    header_len, header = decode_cbor(header_data)
    assert len(header_data[header_len:]) == 0
    assert header["version"] == 1

    section_map = {}
    for section_data in sections_data:
        section_cid = Cid(section_data, "\x00")
        section_rest = section_cid.extra
        section_len, section_val = decode_cbor(section_rest)
        assert len(section_rest[section_len:]) == 0
        section_map[repr(section_cid)] = section_val

    all_entries = []
    for root_cid in header["roots"]:
        root = section_map[repr(root_cid)]
        assert root["version"] == 3
        entries = {}
        flatten_tree(section_map, entries, root["data"])
        all_entries.append(entries)

    # print posts in fortune cookie format
    # rot13 for fun
    for entries in all_entries:
        for post in entries["app.bsky.feed.post"]:
            if not "reply" in post[1]:
                print(codecs.encode(post[1]["text"], encoding="rot13"))
                print("%")

if __name__ == "__main__":
    main()
