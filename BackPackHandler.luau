local backpack = {}

local UIS = game:GetService("UserInputService")
local backpackGUI = game:GetService("ReplicatedStorage"):WaitForChild("GUIs"):WaitForChild("backpackGUI")
local container = backpackGUI:WaitForChild("Frame"):WaitForChild("Container")
local template = container:WaitForChild("Template")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local DataService = require(game:GetService("ReplicatedStorage"):WaitForChild("DataServiceClient"))
local AddItem = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("AddItem")

local opened = false :: boolean

UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	
	if input.KeyCode == Enum.KeyCode.Q then
		local gui = player.PlayerGui:FindFirstChild("backpackGUI")

		if not gui then
			gui = backpackGUI:Clone()
			gui.Parent = player.PlayerGui

			local container = gui.Frame.Container :: ScrollingFrame
			local template = container.Template

			for _, item in DataService.get() do
				local newItem = template:Clone()
				newItem.Parent = container
				newItem.ImageLabel.Image = item.ImageID
				newItem.Visible = true
			end
			
			AddItem.OnClientEvent:Connect(function(item)
				print("fire event")
				local newItem = template:Clone()
				newItem.Parent = container
				newItem.ImageLabel.Image = item.ImageID
				newItem.Visible = true
			end)
		end

		opened = not opened
		gui.Enabled = opened

		if not opened then return end
	
	end


end)


return backpack
