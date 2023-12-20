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

function file_exists(file)
-------------------------------------------------
--   Checks whether the file exists or not and 
-- returns a boolean
-- Parameters:
-- File : File path string
--------------------------------------------
  local f = io.open(file, "r");
  if f then f:close() end
  return f ~= nil
end

function get_all_lines(file)
-------------------------------------------------
--   Get all the lines from a file. Returns an
-- empty table if the file does not exist
-- Parameters:
-- File : File path string
--------------------------------------------
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

function write_file(file, lines)
-------------------------------------------------
-- Writes a file with the lines passed by 
-- parameter
-- Parameters:
-- File : File path string
-- Lines : An array of lines to be written
--------------------------------------------
  local f = io.open(file, "w")
  for i = 1, #lines do
    f:write(lines[i])
  end
  f:close()
end
