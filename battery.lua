local os = require("os")
local computer = require("computer")
local component = require("component")
local mfe = component.ic2_mfe
local gpu = component.gpu

if not component.isAvailable("ic2_mfe") then 
  print("Failed to detect MFE")
  os.exit()
end

local function drawGUI()
  local fill = mfe.getEnergy()
  gpu.setResolution(40, 4)
  gpu.fill(1, 1, 40, 4, " ")
  
  -- Draw the border
  gpu.setBackground(0x333333)
  gpu.fill(1, 1, 40, 1, " ")
  gpu.fill(1, 4, 40, 1, " ")
  gpu.fill(1, 2, 1, 2, " ")
  gpu.fill(40, 2, 1, 2, " ")

  -- Calculate the energy level bar length
  local barLength = math.floor(fill / 50000)
  
  -- Draw the energy level bar
  gpu.setBackground(0x00FF00)
  gpu.fill(2, 2, barLength, 2, " ")

  -- Display energy level information
  gpu.setBackground(0x333333)
  gpu.setForeground(0xFFFFFF)
  gpu.set(18, 2, "Energy Level: " .. fill .. " EU ")
end

while true do
  drawGUI()
  os.sleep(2)
  local fill = mfe.getEnergy()
  
  if fill < 2500000 then
    print("POWER LEVEL LOW")
    computer.beep(550, 1)
    if fill < 1500000 then
      print("POWER LEVEL CRITICAL")
      computer.beep(1000, 0.15)
      computer.beep(600, 0.15)
      computer.beep(1000, 0.15)
      computer.beep(600, 0.15)
    end
  end
end
