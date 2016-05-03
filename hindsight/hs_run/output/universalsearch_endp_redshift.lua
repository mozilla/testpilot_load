-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

local ds = require "derived_stream"

local function get_uuid()
    return string.format("%X%X%X%X-%X%X-%X%X-%X%X-%X%X%X%X%X",
                         string.byte(read_message("Uuid"), 1, 16))
end

local function get_classifiers()
    return string.char(string.byte(table.concat(read_message("Fields[classifiers]"), ","), 0, 1000))
end

local name = read_config("table_prefix") or "universalsearch_server"
local schema = {
--   column name                   field type   length  attributes   field name
    {"timestamp",                  "TIMESTAMP", nil,    "SORTKEY",   "Timestamp"},
    {"uuid",                       "VARCHAR",   36,      nil,         get_uuid},
    {"Hostname",                   "VARCHAR",   255,     nil,         "Hostname"},
    {"logger",                     "VARCHAR",   255,     nil,         "logger"},
    {"Severity",                   "INTEGER",   nil,     nil,         "Severity"},
    {"type",                       "VARCHAR",   255,     nil,         "type"},
    {"agent",                      "VARCHAR",   255,     nil,         "Fields[agent]"},
    {"errno",                      "VARCHAR",   255,     nil,         "Fields[errno]"},
    {"lang",                       "VARCHAR",   255,     nil,         "Fields[lang]"},
    {"method",                     "VARCHAR",   255,     nil,         "Fields[method]"},
    {"path",                       "VARCHAR",   255,     nil,         "Fields[path]"},
    {"status_code",                "INTEGER",   nil,     nil,         "Fields[status_code]"},
    {"t",                          "VARCHAR",   36,      nil,         "Fields[t]"},
    {"classifiers",                "VARCHAR",   1000,    nil,         get_classifiers},
    {"predicate.is_protocol",      "BOOLEAN",   nil,     nil,         "Fields[predicate.is_protocol]"},
    {"predicate.query_length",     "BOOLEAN",   nil,     nil,         "Fields[predicate.query_length]"},
    {"predicate.is_hostname",      "BOOLEAN",   nil,     nil,         "Fields[predicate.is_hostname]"},
}

process_message, timer_event = ds.load_schema(name, schema)
