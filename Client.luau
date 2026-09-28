local DataService = require(game:GetService("ReplicatedStorage"):WaitForChild("DataServiceClient"))
local shop = require(game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts"):WaitForChild("ShopHandler"))
local backpackHandler = require(game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts"):WaitForChild("BackpackHandler"))
local player = game.Players.LocalPlayer 

print(DataService.get())
