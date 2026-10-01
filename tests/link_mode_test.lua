-- Minimal offline regression test. KOReader supplies these modules at runtime;
-- only their presence is needed while loading zoteroapi.lua for this test.
local function stub(name, value)
    package.preload[name] = function()
        return value or {}
    end
end

stub("ffi/util")
stub("luasettings")
stub("socket.http")
stub("ltn12")
stub("ssl.https")
stub("json")
stub("libs/libkoreader-lfs")
stub("docsettings")
stub("ffi/sha2")

package.path = "./?.lua;" .. package.path
local ZoteroAPI = require("zoteroapi")

assert(ZoteroAPI.isDownloadableLinkMode("imported_file"))
assert(ZoteroAPI.isDownloadableLinkMode("imported_url"))
assert(not ZoteroAPI.isDownloadableLinkMode("linked_file"))
assert(not ZoteroAPI.isDownloadableLinkMode("linked_url"))
assert(not ZoteroAPI.isDownloadableLinkMode(nil))

print("attachment link-mode compatibility checks passed")
