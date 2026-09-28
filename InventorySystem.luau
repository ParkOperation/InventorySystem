local inventory = {}

export type Item = {
	Name:string,
	Type:string,
	ImageID:string
}

local equipped = require(game:GetService("ServerScriptService").InventorySystem:WaitForChild("Equipped"))
local playerInventory = require(game:GetService("ServerScriptService").InventorySystem:WaitForChild("Inventory"))
local Players = game:GetService("Players")

function inventory.getInventory(player)
	return playerInventory[player]
end

function inventory.getEquipped(player)
	return equipped[player]
end

function inventory.equip(player, item:{[string]: Item})
	if not playerInventory[player][item.Name] then return end
	if equipped[player][item.Type] then
		inventory.unequip(player, item)
	end
	
	equipped[player][item.Type] = item
	print(player.Name.." equipped a " .. item.Type)
	return true
end

function inventory.unequip(player, item:{[string]: Item})
	if not playerInventory[player][item.Name] then return end
	if not equipped[player][item.Type] then return end
	
	equipped[player][item.Type] = nil
	print(player.Name.." unequipped a "..item.Type)
	return true
	
	
end

function inventory.addItem(player, item:{[string]: Item})
	if not item then return end
	if not item.Type then return end
	if not item.Name then return end
	
	playerInventory[player][item.Name] = item
	print(player.Name.. " added item ".. item.Name)
	
end

return inventory
