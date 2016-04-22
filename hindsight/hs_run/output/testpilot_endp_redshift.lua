-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

local ds = require "derived_stream"

local function get_uuid()
    return string.format("%X%X%X%X-%X%X-%X%X-%X%X-%X%X%X%X%X",
                         string.byte(read_message("Uuid"), 1, 16))
end

local name = read_config("table_prefix") or "testpilot_server"
local schema = {
--   column name                   field type   length  attributes   field name
    {"timestamp",                  "TIMESTAMP", nil,    "SORTKEY",   "Timestamp"},
    {"uuid",                       "VARCHAR",   36,      nil,         get_uuid},
    {"type",                       "VARCHAR",   255,     nil,         "type"},
    {"logger",                     "VARCHAR",   255,     nil,         "logger"},
    {"Hostname",                   "VARCHAR",   255,     nil,         "Hostname"},
    {"Severity",                   "INTEGER",   nil,     nil,         "Severity"},
    {"agent",                      "VARCHAR",   45,      nil,         "Fields[agent]"},
    {"path",                       "VARCHAR",   56,      nil,         "Fields[path]"},
    {"method",                     "VARCHAR",   200,     nil,         "Fields[method]"},
    {"code",                       "VARCHAR",   255,     nil,         "Fields[code]"},
    {"errno",                      "VARCHAR",   255,     nil,         "Fields[errno]"},
    {"lang",                       "VARCHAR",   36,      nil,         "Fields[lang]"},
--    {"uid",                        "INTEGER",   nil,     nil,         "Fields[uid]"},
    {"service",                    "VARCHAR",   255,     nil,         "Fields[service]"},
    {"context",                    "VARCHAR",   255,     nil,         "Fields[context]"},
    {"msg",                        "VARCHAR",   1000,    nil,         "Fields[msg]"},
--    {"remoteAddressChain",         "VARCHAR",   255,     nil,         "Fields[remoteAddressChain]"},
    {"rid",                        "VARCHAR",   255,     nil,         "Fields[rid]"},
    {"t",                          "VARCHAR",   36,      nil,         "Fields[t]"},
    {"feature_switches",           "VARCHAR",   255,     nil,         "Fields[feature_switches]"},
    {"campaign",                   "VARCHAR",   255,     nil,         "Fields[campaign]"}
}

process_message, timer_event = ds.load_schema(name, schema)
