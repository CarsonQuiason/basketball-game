local Players = game:GetService("Players")
local ball = game:GetService("ServerStorage"):WaitForChild("ball")

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		local tempBall = ball:Clone()
		tempBall.Parent = game.Players[player.Name].Backpack
	end)
end)