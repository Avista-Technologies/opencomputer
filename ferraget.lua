local internet = require("internet")
local filesystem = require("filesystem")

-- Function to download a file from GitHub
local function downloadFile(appName)
  local url = "https://raw.githubusercontent.com/Avista-Technologies/opencomputer/main/" .. appName .. ".lua"
  local response = internet.request(url)

  local content = ""
  for chunk in response do
    content = content .. chunk
  end

  if content and content ~= "" then
    local filePath = "/" .. appName .. ".lua"
    local file = io.open(filePath, "w")
    file:write(content)
    file:close()

    print("File downloaded successfully: " .. filePath)
  else
    print("Failed to download file.")
  end
end

-- Main program
io.write("Enter the name of the application to download: ")
local appName = io.read()

if appName then
  downloadFile(appName)
else
  print("Invalid application name.")
end
