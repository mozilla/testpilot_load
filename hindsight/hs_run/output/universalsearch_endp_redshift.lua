-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

local ds = require "derived_stream"

local function get_uuid()
    return string.format("%X%X%X%X-%X%X-%X%X-%X%X-%X%X%X%X%X",
                         string.byte(read_message("Uuid"), 1, 16))
end

local function get_classifiers()
    local message = decode_message(read_message("raw"))
    local classifiers = ""

    for index, field in ipairs(message.Fields) do
        if field.name == "classifiers" then
            classifiers = string.char(string.byte(table.concat(field.value, ","), 0, 1000))
            break
        end
    end

    return classifiers
end

local name = read_config("table_prefix") or "universalsearch_server"
local schema = {
--   column name                   field type   length  attributes   field name
    {"timestamp",                  "TIMESTAMP", nil,    "SORTKEY",   "Timestamp"},
    {"uuid",                       "VARCHAR",   36,      nil,         get_uuid},
    {"hostname",                   "VARCHAR",   255,     nil,         "Hostname"},
    {"logger",                     "VARCHAR",   255,     nil,         "Logger"},
    {"severity",                   "INTEGER",   nil,     nil,         "Severity"},
    {"type",                       "VARCHAR",   255,     nil,         "Type"},
    {"classifiers",                "VARCHAR",   1000,    nil,         get_classifiers},
    {"errno",                      "VARCHAR",   255,     nil,         "Fields[errno]"},
    {"lang",                       "VARCHAR",   255,     nil,         "Fields[lang]"},
    {"method",                     "VARCHAR",   255,     nil,         "Fields[method]"},
    {"path",                       "VARCHAR",   255,     nil,         "Fields[path]"},
    {'"predicates.is_hostname"',   "BOOLEAN",   nil,     nil,         "Fields[predicates.is_hostname]"},
    {'"predicates.is_protocol"',   "BOOLEAN",   nil,     nil,         "Fields[predicates.is_protocol]"},
    {'"predicates.query_length"',  "BOOLEAN",   nil,     nil,         "Fields[predicates.query_length]"},
    {"query",                      "VARCHAR",   255,     nil,         "Fields[query]"},
    {"status_code",                "INTEGER",   nil,     nil,         "Fields[status_code]"},
    {"t",                          "VARCHAR",   36,      nil,         "Fields[t]"},
    {"user_agent_browser",         "VARCHAR",   255,     nil,         "Fields[user_agent_browser]"},
    {"user_agent_os",              "VARCHAR",   255,     nil,         "Fields[user_agent_os]"},
    {"user_agent_version",         "VARCHAR",   255,     nil,         "Fields[user_agent_version]"},
}

process_message, timer_event = ds.load_schema(name, schema)
