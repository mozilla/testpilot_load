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
    {"timestamp",                  "TIMESTAMP", nil,    "SORTKEY",    "Timestamp"},
    {"uuid",                       "VARCHAR",   36,      nil,         get_uuid},
    {"hostname",                   "VARCHAR",   255,     nil,         "Hostname"},
    {"logger",                     "VARCHAR",   255,     nil,         "Logger"},
    {"severity",                   "INTEGER",   nil,     nil,         "Severity"},
    {"type",                       "VARCHAR",   255,     nil,         "Type"},
    {"campaign",                   "VARCHAR",   255,     nil,         "Fields[campaign]"}
    {"code",                       "VARCHAR",   255,     nil,         "Fields[code]"},
    {"context",                    "VARCHAR",   255,     nil,         "Fields[context]"},
    {"errno",                      "VARCHAR",   255,     nil,         "Fields[errno]"},
    {"feature_switches",           "VARCHAR",   255,     nil,         "Fields[feature_switches]"},
    {"lang",                       "VARCHAR",   36,      nil,         "Fields[lang]"},
    {"method",                     "VARCHAR",   200,     nil,         "Fields[method]"},
    {"msg",                        "VARCHAR",   1000,    nil,         "Fields[msg]"},
    {"path",                       "VARCHAR",   56,      nil,         "Fields[path]"},
--  {"remoteAddressChain",         "VARCHAR",   255,     nil,         "Fields[remoteAddressChain]"},
    {"rid",                        "VARCHAR",   255,     nil,         "Fields[rid]"},
    {"service",                    "VARCHAR",   255,     nil,         "Fields[service]"},
    {"t",                          "VARCHAR",   36,      nil,         "Fields[t]"},
--  {"uid",                        "INTEGER",   nil,     nil,         "Fields[uid]"},
    {"user_agent_browser",         "VARCHAR",   255,     nil,         "Fields[user_agent_browser]"},
    {"user_agent_os",              "VARCHAR",   255,     nil,         "Fields[user_agent_os]"},
    {"user_agent_version",         "VARCHAR",   255,     nil,         "Fields[user_agent_version]"},
}

process_message, timer_event = ds.load_schema(name, schema)
