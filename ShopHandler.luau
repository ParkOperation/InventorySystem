local shopclient = {}

local prompt = game:GetService("Workspace"):WaitForChild("Shop"):WaitForChild("ShopPrompt")
local shopgui = game:GetService("ReplicatedStorage"):WaitForChild("GUIs"):WaitForChild("ShopGUI")
local buyItem = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("BuyItem")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local opened = false

prompt.Triggered:Connect(function()
	local gui = player.PlayerGui:FindFirstChild("ShopGUI")
	
	if not gui then
		gui = shopgui:Clone()
		gui.Parent = player.PlayerGui
		
		for _, button in gui:GetDescendants() do
			if button:IsA("TextButton") then
				button.Activated:Connect(function(player)
					buyItem:FireServer(button.Name)
				end)

			end
		end
		
	end
	
	opened = not opened
	gui.Enabled = opened
	
	if not opened then return end
	
	
end)



return shopclient
