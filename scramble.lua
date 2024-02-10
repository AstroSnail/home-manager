-- STEP 1
-- seed the rng
-- wtf why am i making a huge deal out of this
-- in summary:
-- - read 128 bits from /dev/urandom
-- - use it to generate a random float64
--   (taking care not to generate infinity or nan)
--   (extra bits are used to minimize bias)
-- - seed the lua rng with this

local function mask_upper(x, n)
    local b = 2 ^ n
    local shifted = math.floor(x / b)
    return shifted, shifted * b
end
local function mask_lower(x, n)
    local _, upper = mask_upper(x, n + 1)
    return x - upper
end

-- little-endian
-- this means i interpret a bytes_seq like { 0x12, 0x34, 0x56, 0x78 } as:
-- 0100_1000_0010_1100_0110_1010_0001_1110
-- ( 2    1    4    3    6    5    8    7 )
-- and get_bits i=12 to j=24 returns:
-- ----_----_---0_1100_0110_1010_----_----
-- 0110_0011_0101_0
-- ( 6   12   10   0 )
-- 0x0AC6
local function get_bits(bytes_seq, i, j)
    local ibyte, jbyte = math.floor((i - 1) / 8) + 1, math.floor((j - 1) / 8) + 1
    local ibit, jbit = (i - 1) % 8, (j - 1) % 8
    if ibyte == jbyte then
        -- the order matters!
        -- parens to adjust the return to a single value
        return (mask_upper(mask_lower(bytes_seq[ibyte], jbit), ibit))
    end
    local smallest_bits = mask_upper(bytes_seq[ibyte], ibit)
    local biggest_bits = mask_lower(bytes_seq[jbyte], jbit)
    local bits = biggest_bits
    for k = jbyte - 1, ibyte + 1, -1 do
        bits = bits * 256 + bytes_seq[k]
    end
    bits = bits * 2 ^ (8 - ibit) + smallest_bits
    return bits
end

local function bits_to_f64(s, e, f)
    if e > 0 then
        f = f + 2 ^ 52
    else
        -- subnormals
        e = 1
    end
    -- offset by 52 bits to account for f
    return (-1) ^ s * f * 2 ^ (e - 1023 - 52)
end

local urandom = io.open("/dev/urandom")
local random_string = urandom:read(16) -- 128 bits
urandom:close()
local random_seq = {random_string:byte(1, 16)}
local fraction = get_bits(random_seq, 1, 52) -- 0 to 2^52 - 1
local sign = get_bits(random_seq, 53, 53) -- 0 or 1
-- TODO: how to work around float64 and sample all 75 remaining bits
local exponent_sample = get_bits(random_seq, 54, 106) * 2 ^ (-53)
local exponent = math.floor(exponent_sample * 2047) -- 0 to 2046
local random_f64 = bits_to_f64(sign, exponent, fraction)
-- finally!
math.randomseed(random_f64)

-- STEP 2
-- set up modes
-- in summary:
-- - weak replaces alphabetic characters
--   keeps case, punctuation, etc the same
-- - medium replaces all characters
--   but keeps the line length the same
-- - secure randomizes the line length too
--   up to the length of the longest line

local modes = {}

local function scramble_alpha(m)
    local r = math.random(26)
    if m:match("%u") then
        return string.char(r + 64)
    elseif m:match("%l") then
        return string.char(r + 96)
    end
end
function modes.weak(i, o)
    for l in i:lines("L") do
        local lnew = l:gsub("%a", scramble_alpha)
        o:write(lnew)
    end
end

local function scramble_all(_m)
    local r = math.random(32, 126)
    return string.char(r)
end
function modes.medium(i, o)
    for l in i:lines("L") do
        local lnew = l:gsub("%C", scramble_all)
        o:write(lnew)
    end
end

function modes.secure(_i, _o)
    error("nyi")
end

function modes.help(_i, o)
    o:write(
        ("%s\n  %-6s - %s\n  %-6s - %s\n  %-6s - %s\n"):format(
            "Usage:",
            "weak",
            "replaces alphabetic, keeps case",
            "medium",
            "replaces all, keeps line length",
            "secure",
            "replaces all, randomizes line length"
        )
    )
end

-- STEP 3
-- run

local i, o = io.input(), io.output()

local mode = modes[arg[1]]
if mode then
    mode(i, o)
else
    modes.help(i, o)
end
