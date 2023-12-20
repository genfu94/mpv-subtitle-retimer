-- Copyright 2015 Giuseppe Gelfusa
-- 
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
--     http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

local mp = require('mp')
local utils = require('mp.utils')
local msg = require('mp.msg')
local mpopt = require('mp.options')
require('subtitle')

local hex_to_char = function(x)
  return string.char(tonumber(x, 16))
end

local unescape = function(url)
  return url:gsub("%%(%x%x)", hex_to_char)
end


function seconds_to_timestamp(seconds)
	local remainder = seconds
	local hour = math.floor(seconds / 3600)
	remainder = remainder - hour * 3600
	local minutes = math.floor(remainder / 60)
	remainder = remainder - minutes * 60
	local seconds = math.floor(remainder)
	local milliseconds = math.floor((remainder - seconds)*1000)
	
	return hour..':'..minutes..':'..seconds..','..milliseconds
	
end


function retime()
	selected_sub_track = nil
	for _, track in ipairs(mp.get_property_native('track-list')) do
		if track['type'] == 'sub' and track['selected'] == true then
		    selected_sub_track = track
		end
        end
        
        if selected_sub_track == nil then
        	mp.osd_message("No sub selected")
        	return
        end
        
        selected_sub_path = unescape(selected_sub_track['external-filename'])
        selected_sub_path = string.gsub(selected_sub_path, "file://", "")
        current_timestamp = seconds_to_timestamp(mp.get_property_number("time-pos"))
        current_delay = mp.get_property_native("sub-delay")
        current_delay = math.floor(current_delay*1000)
        mp.set_property("sub-delay", 0)
        add_miliseconds_to_file(selected_sub_path, current_delay, selected_sub_path, current_timestamp, nil)
        mp.commandv('sub-reload')
        mp.osd_message("Subtitle file correctly retimed")
end

mp.add_key_binding("Ctrl+r", "subretimer-apply", retime)
