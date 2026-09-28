local module = {}

local template = require(game:GetService("ServerStorage"):WaitForChild("Template"))
local DataService = require(game:GetService("ReplicatedStorage"):WaitForChild("DataService")).server
local Players = game:GetService("Players")
local LootTable = require(game:GetService("ServerStorage"):WaitForChild("LootTable"))
local equipped = require(game:GetService("ServerScriptService").InventorySystem:WaitForChild("Equipped"))
local playerInventory = require(game:GetService("ServerScriptService").InventorySystem:WaitForChild("Inventory"))
local inventory = require(game:GetService("ServerScriptService"):WaitForChild("InventorySystem"):WaitForChild("InventorySystem"))
local buyItem = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("BuyItem")
local AddItem = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("AddItem")

DataService:init(
	{template = template}
)

Players.PlayerAdded:Connect(function(player)
	DataService:waitForData(player)
	 --use to reset data rq
	--DataService:resetData(player) 
	playerInventory[player] = DataService:get(player, "inventory") or {}
	equipped[player] = DataService:get(player, "equipped") or {}
	print("Loaded")
end)

Players.PlayerRemoving:Connect(function(player)
	DataService:set(player, "inventory", inventory.getInventory(player))
	DataService:set(player, "equipped", inventory.getEquipped(player))
	print("Saved")
end)

buyItem.OnServerEvent:Connect(function(player, name)
	local item = LootTable[name]
	if not item then return end
	
	inventory.addItem(player, item)
	AddItem:FireClient(player, item)
end)


return module
