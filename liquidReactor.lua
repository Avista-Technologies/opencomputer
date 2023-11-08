local os = require("os")
local component = require("component")
local reactor = component.br_reactor
local gpu = component.gpu

local function drawGUI(heat, maxHeat, energyProduced, status)
  gpu.setResolution(40, 20)
  gpu.fill(1, 1, 40, 20, " ")  -- Clear the screen

  gpu.fill(1, 1, 20, 10, " ") -- heat box
  gpu.fill(21, 1, 20, 10, " ") -- max heat box
  gpu.fill(1, 11, 20, 8, " ") -- energy produced box
  gpu.fill(21, 11, 20, 8, " ") -- status box

  gpu.set(2, 2, "Heat:")
  gpu.set(2, 3, heat)

  gpu.set(22, 2, "Max Heat:")
  gpu.set(22, 3, maxHeat)

  gpu.set(2, 12, "Energy Produced:")
  gpu.set(2, 13, energyProduced)

  local statusColor = 0xFFFFFF -- Default color for online status

  if status == "SCRAM" then
    statusColor = 0xFF0000 -- Red for SCRAM status
  elseif status == "offline" then
    statusColor = 0x888888 -- Gray for offline status
  end

  gpu.setForeground(statusColor)
  gpu.set(22, 12, "Status:")
  gpu.set(22, 13, status)
end

local function checkReactorStatus(heat, maxHeat, energyProduced)
  local status = "online"

  if (heat / maxHeat) >= 0.75 then
    status = "SCRAM"
  elseif heat == 0 then
    status = "offline"
  end

  return status
end

while true do
  local heat = reactor.getHeat()
  local maxHeat = reactor.getMaxHeat()
  local energyProduced = reactor.getReactorEnergyOutput()
  local status = checkReactorStatus(heat, maxHeat, energyProduced)
  drawGUI(heat, maxHeat, energyProduced, status)
  os.sleep(2)
end
