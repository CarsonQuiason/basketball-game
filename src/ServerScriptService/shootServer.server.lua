local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local shootFunction = ReplicatedStorage:WaitForChild("shoot")
local scoreFunction = ReplicatedStorage:WaitForChild("scored")
local midhoop = game.workspace:WaitForChild("hoop1"):WaitForChild("Hoop"):WaitForChild("MainRim"):WaitForChild("midhoop")
local ball = ServerStorage:WaitForChild("ball")
local propBall = ball:WaitForChild("Part")
local cScore = game.Workspace:WaitForChild("scoreObj"):WaitForChild("currentScore"):WaitForChild("cScore")
local totalScored = 0
local debris = game:GetService("Debris")

local function shootBall(player, x0, v0, isPerfect)
	local tempBall = ball:clone()
	local tempProp = tempBall:WaitForChild("Part")
	tempBall.Parent = game.Workspace
	tempProp:SetNetworkOwner(nil)
	tempProp.Velocity = v0
	tempProp.CFrame = CFrame.new(x0)
	if isPerfect then
		local emitter = Instance.new("ParticleEmitter")
		local green = Color3.new(0,1,0)
		local cs = ColorSequence.new(green)
		tempProp:WaitForChild("Mesh").VertexColor = Vector3.new(0,1,0)
		emitter.Rate = 10
		emitter.Lifetime = NumberRange.new(1,1)
		emitter.Enabled = true 
		emitter.LightEmission = 1
		emitter.Color = cs
		emitter.Parent = tempProp
	end
	--debris:AddItem(tempBall,10)
	return tempBall
end




local function onBallScored()
	totalScored = totalScored + 1
	print("RojoTest2Scored"..totalScored)
	cScore.Text = totalScored
	return totalScored
end

shootFunction.OnServerInvoke = shootBall
scoreFunction.OnServerInvoke = onBallScored