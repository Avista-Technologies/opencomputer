local os = require("os")
local computer = require("computer")
local component = require("component")
local mfe = component.ic2_mfe
local gpu = component.gpu

if not component.isAvailable("ic2_mfe") then 
  print("Failed to detect MFE")
  os.exit()
end

local function drawGUI(charge, maxCharge, status)
  gpu.setResolution(40, 20)
  gpu.fill(1, 1, 40, 20, " ")  -- Clear the screen

  -- Draw the grid
  gpu.fill(1, 1, 20, 10, " ") -- charge box
  gpu.fill(21, 1, 20, 10, " ") -- max charge box
  gpu.fill(1, 11, 20, 8, " ") -- change status box
  gpu.fill(21, 11, 20, 8, " ") -- battery status box

  -- Display charge and max charge
  gpu.set(2, 2, "Charge:")
  gpu.set(2, 3, charge .. " EU")
  gpu.set(22, 2, "Max Charge:")
  gpu.set(22, 3, maxCharge .. " EU")

  -- Display whether charge is increasing, decreasing, or stable
  gpu.set(2, 12, "Charge Status:")
  gpu.set(2, 13, status)

  -- Determine color for the battery status
  local statusColor = 0xFFFFFF -- Default color for normal status
  if status == "POWER LEVEL LOW" then
    statusColor = 0xFFA500 -- Orange for low power
  elseif status == "POWER LEVEL CRITICAL" then
    statusColor = 0xFF0000 -- Red for critical power
  end

  -- Display battery status
  gpu.setForeground(statusColor)
  gpu.set(22, 12, "Battery Status:")
  gpu.set(22, 13, status)
end

local function checkStatus(charge, maxCharge)
  local status = "normal"
  if charge < 2500000 then
    status = "POWER LEVEL LOW"
    computer.beep(550, 1)
    if charge < 1500000 then
      status = "POWER LEVEL CRITICAL"
      computer.beep(1000, 0.15)
      computer.beep(600, 0.15)
      computer.beep(1000, 0.15)
      computer.beep(600, 0.15)
    end
  end
  return status
end

while true do
  local charge = math.floor(mfe.getEnergy()+0.5)
  local maxCharge = mfe.getCapacity()
  local status = checkStatus(charge, maxCharge)
  drawGUI(charge, maxCharge, status)
  os.sleep(2)
end
