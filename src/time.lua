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

function timestamp_to_miliseconds(timestamp)
-------------------------------------------------
-- Converts timestamp to miliseconds string
-- Parameters:
-- timestamp : The timestamp to be converted
-------------------------------------------------
  local values = {}

  for value in timestamp:gmatch('%d+') do
    values[#values + 1] = tonumber(value)
  end

  local timestamp_msec = values[1] * 60 * 60 *1000
                       + values[2] * 60 * 1000
                       + values[3] * 1000
                       + values[4]
  
  return timestamp_msec
end

function miliseconds_to_timestamp(miliseconds)
-------------------------------------------------
-- Converts miliseconds to timestamp string
-- Parameters:
-- miliseconds : The miliseconds to be converted
-------------------------------------------------
  local unit = {3600000, 60000, 1000, 1}
  local str_out = ''
  local remainder = miliseconds

  for i=1,3 do
    local amount = math.floor(remainder / unit[i])
    local amount_str = ''

    if amount < 10 then amount_str = '0' .. amount
    else amount_str = amount
    end

    str_out = str_out .. amount_str

    if i == 3 then str_out = str_out .. ','
    else str_out = str_out .. ':'
    end

    remainder = remainder % unit[i]
  end

  if remainder < 10 then return str_out .. '00' .. math.floor(remainder)
  elseif remainder < 100 then return str_out .. '0' .. math.floor(remainder)
  end

  return str_out .. math.floor(remainder)   
end

function add_time(timestamp, miliseconds)
-------------------------------------------------
-- Adds miliseconds to a timestamp
-- Parameters:
-- timestamp : The timestamp
-- miliseconds : The miliseconds
-------------------------------------------------
  local timestamp_msec = timestamp_to_miliseconds(timestamp)
  timestamp_msec = timestamp_msec + miliseconds
  return miliseconds_to_timestamp(timestamp_msec)
end

function compare_timestamps(timestamp1, timestamp2)
-------------------------------------------------
-- Given two timestamps, returns 1 if the first
-- one is bigger, 2 if the second one is bigger
-- or 0 if they are equal
-- Parameters:
-- timestamp1 : First timestamp
-- timestamp2 : Second timestamp
-------------------------------------------------
  local t1msec = timestamp_to_miliseconds(timestamp1)
  local t2msec = timestamp_to_miliseconds(timestamp2)

  if t1msec > t2msec then return 1
  elseif t2msec > t1msec then return 2
  end

  return 0
end
