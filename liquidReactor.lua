local os = require("os")
local computer = require("computer")
local component = require("component")
local reactor = component.reactor_chamber
local gpu = component.gpu

local function drawGUI(heat, maxHeat, status, output)
  gpu.setResolution(40, 20)
  gpu.fill(1, 1, 40, 20, " ")  -- Clear the screen

  -- Draw the grid
  gpu.fill(1, 1, 20, 10, " ") -- charge box
  gpu.fill(21, 1, 20, 10, " ") -- max charge box
  gpu.fill(1, 11, 20, 8, " ") -- change status box
  gpu.fill(21, 11, 20, 8, " ") -- battery status box

  -- Display charge and max charge
  gpu.set(2, 2, "Heat:")
  gpu.set(2, 3, heat .. " EU")
  gpu.set(22, 2, "Max Heat:")
  gpu.set(22, 3, maxHeat .. " EU")

  -- Display whether charge is increasing, decreasing, or stable
  gpu.set(2, 12, "Energy:")
  gpu.set(2, 13, output)

  -- Display battery status
  gpu.set(22, 12, "Status:")
  gpu.set(22, 13, status)
end

local function checkStatus(heat, maxHeat, producesEnergy)
  local status = "Online"
  if (heat / maxheat) >= 0.75 then 
    status = "SCRAM"
  elseif (producesEnergy == false) then
    status = "Offline"
  return status
    
while true do
  local heat = reactor.getHeat()
  local maxHeat = reactor.getMaxHeat()
  local output = reactor.getReactorEnergyOutput()
  local producesEnergy = reactor.producesEnergy()
  local status = checkStatus(heat, maxHeat, producesEnergy)
  drawGUI(heat, maxHeat, status, output)
  os.sleep(2)
end
