local component = require("component")
local term = require("term")

-- Check if the tape drive is available
if not component.isAvailable("tape_drive") then
  print("Tape drive not detected.")
  return
end

local tape = component.tape_drive
local fileList = {}  -- List to store file names on the tape

-- Function to write data to the tape
local function writeToFile(filename)
  local file = io.open(filename, "r")
  if not file then
    print("File not found.")
    return
  end

  local data = file:read("*a")
  file:close()

  tape.write(data)
  table.insert(fileList, filename)  -- Add the filename to the list
  print("File '" .. filename .. "' written to tape.")
end

-- Function to read data from the tape
local function readFromFile()
  if #fileList == 0 then
    print("No files on the tape.")
    return
  end

  print("Files on the tape:")
  for i, filename in ipairs(fileList) do
    print(i .. ". " .. filename)
  end

  io.write("Enter the number of the file to read: ")
  local fileNumber = tonumber(io.read())

  if fileNumber and fileList[fileNumber] then
    local filename = fileList[fileNumber]
    local data = tape.read(tape.getSize())

    if data then
      local file = io.open(filename, "w")
      file:write(data)
      file:close()
      print("File '" .. filename .. "' read from tape.")
    else
      print("Failed to read file from tape.")
    end
  else
    print("Invalid file number.")
  end
end

-- Main program
while true do
  term.clear()
  print("1. Write to tape")
  print("2. Read from tape")
  print("3. Exit")

  io.write("Select an option (1-3): ")
  local option = tonumber(io.read())

  if option == 1 then
    io.write("Enter the filename to write to tape: ")
    local filename = io.read()
    writeToFile(filename)
  elseif option == 2 then
    readFromFile()
  elseif option == 3 then
    print("Exiting program.")
    break
  else
    print("Invalid option. Please enter a number between 1 and 3.")
  end

  io.write("Press Enter to continue...")
  io.read()
end
