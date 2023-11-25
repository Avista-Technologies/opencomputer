local internet = require("internet")
local filesystem = require("filesystem")

-- Function to download a file from GitHub
local function downloadFile(appName)
  local url = "https://raw.githubusercontent.com/Avista-Technologies/opencomputer/main/" .. appName .. ".lua"
  local response, responseCode = internet.request(url)

  if responseCode == 200 then
    local content = ""
    for chunk in response do
      content = content .. chunk
    end

    local filePath = "/" .. appName .. ".lua"
    local file = io.open(filePath, "w")
    file:write(content)
    file:close()

    print("File downloaded successfully: " .. filePath)
  else
    print("Failed to download file. HTTP response code: " .. tostring(responseCode))
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
