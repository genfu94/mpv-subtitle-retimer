-- Copyright 2015 Douglas Bellon Rocha
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

require 'regex'
require 'file'
require 'time'

-- Creates regex patterns to determine which are the
-- range sentence of srt segments
TIMESTAMP_PATTERN = '%d+:%d+:%d+,%d+'
REGEX_PATTERN = TIMESTAMP_PATTERN .. ' [-][-][>] ' .. TIMESTAMP_PATTERN

function is_line_time_range(line)
-------------------------------------------------
-- Checks whether the line passed by parameter
-- has a valid SRT time range pattern
-- Parameters:
-- line : Any line from the srt file
-------------------------------------------------
  return is_match(line, REGEX_PATTERN)
end

function add_miliseconds_to_file(file, ms, file_out, from, to)
-------------------------------------------------
-- Main method from the lua-subtitles script. It
-- receives all the parameters, iterates line
-- by line in the srt file adding miliseconds to
-- every timstamp
-- Parameters:
-- file : The file path of the input file
-- ms : The amount of miliseconds you wish to add
-- file_out : The file path of the output file
-- from : The timestamp you wish to start to
--        consider adding miliseconds
-- to : The timestamp you wish to stop to 
--      consider adding miliseconds
-------------------------------------------------
  local is_from_nil = from == nil
  local is_to_nil = to == nil

  local file_lines = get_all_lines(file) 
  local new_lines = {} 

  for index, line in pairs(file_lines) do
    if is_line_time_range(line)
      and((is_from_nil or (not is_from_nil and compare_timestamps(line, from) <= 1))
      and (is_to_nil or (not is_to_nil and compare_timestamps(to, line) <= 1)))
    then
      local temp = {}
    
      for ts in line:gmatch(TIMESTAMP_PATTERN) do
        temp[#temp + 1] = ts
      end

      for i,ts in pairs(temp) do temp[i] = add_time(ts, ms) end
  
      new_lines[#new_lines + 1] = temp[1] .. " --> " .. temp[2] .. '\n'
    else
      new_lines[#new_lines + 1] = line .. '\n'
    end
  end

  write_file(file_out, new_lines)
end
