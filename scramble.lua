-- STEP 1
-- seed the rng
-- i previously made a huge deal out of this
-- in summary:
-- - read 106 bits from /dev/urandom
-- - use it to generate a random float64
--   (taking care not to generate infinity or nan)
--   (extra bits are used to minimize bias)
-- - seed the lua rng with this
-- unfortunately, lua randomseed does stupid things:
-- - casts the seed to int64, over/underflow becomes 0
-- - casts again to uint32, over/underflow wraps
-- - somehow seeds 0 and 1 behave the same
-- so we really need a seed between 1 and 2^32-1
-- in summary:
-- - read 53 bits from /dev/urandom
-- - use it to generate a random uint32
--   (taking care not to generate zero)
--   (extra bits are used to minimize bias)
-- - seed the lua rng with this

local urandom = io.open("/dev/urandom")
local random_string = urandom:read(7) -- 56 bits
urandom:close()
local random_seq = {random_string:byte(1, 7)}
-- TODO: how to work around float64 and really use all 56 bits
-- or, ideally, 32+64 = 96 bits
local sample = 0
for i = 1, 7 do
    sample = (sample + random_seq[i]) / 256
end
local upper = 2 ^ 32 - 1
local seed = math.floor(sample * upper + 1) -- 1 to 2^32-1
math.randomseed(seed)

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
function modes.weak(inp, out)
    for l in inp:lines() do
        local lnew = l:gsub("%a", scramble_alpha)
        out:write(lnew, "\n")
    end
end

local function scramble_all(_m)
    local r = math.random(32, 126)
    return string.char(r)
end
function modes.medium(inp, out)
    for l in inp:lines() do
        local lnew = l:gsub(".", scramble_all)
        out:write(lnew, "\n")
    end
end

local function scramble_gen_inner(i, ...)
    if i == 0 then
        return ...
    end
    return scramble_gen_inner(i - 1, scramble_all(), ...)
end
local function scramble_gen(min, max)
    local r = math.random(min, max)
    return scramble_gen_inner(r)
end
function modes.secure(inp, out)
    local n = 0
    local lines = {}
    local min, max = 0, 0
    for l in inp:lines() do
        local len = #l
        n = n + 1
        lines[n] = len
        if len > 0 and (min == 0 or len < min) then
            min = len
        end
        if len > 0 and (max == 0 or len > max) then
            max = len
        end
    end
    for i = 1, n do
        if lines[i] > 0 then
            out:write(scramble_gen(min, max))
        end
        out:write("\n")
    end
end

function modes.help(_inp, out)
    out:write(
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

local inp, out = io.input(), io.output()

local mode = modes[arg[1]]
if mode then
    mode(inp, out)
else
    modes.help(inp, out)
end
