--Client Variables
local inputService = game:GetService("UserInputService")
local mouse = game.Players.LocalPlayer:GetMouse()
local camera = workspace.CurrentCamera
local shotMeter = script.Parent:WaitForChild("shotMeter")
local tool = script.Parent

local Player = game:GetService("Players").LocalPlayer
local pName = Player.Name
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local animatior = Humanoid:WaitForChild("Animator")
local shotAnimation = Instance.new("Animation")
shotAnimation.AnimationId = "rbxassetid://6490807887"
local shotAnimationTrack = animatior:LoadAnimation(shotAnimation)
shotAnimationTrack.Priority = "Action"

--Ball calculation
local t = .73;
local hrp = Character:WaitForChild("HumanoidRootPart");
local g = 0
local x0 = 0
local midhoop = game.Workspace.hoop1.Hoop.MainRim.midhoop.CFrame.Position;
local midhoopOBJ = game.Workspace.hoop1.Hoop.MainRim:WaitForChild("midhoop")
local v0 = 0

--Server variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local shootBall = ReplicatedStorage:WaitForChild("shoot")
local incScore = ReplicatedStorage:WaitForChild("scored")

--Testing Variables
local test = false

Humanoid:EquipTool(script.Parent)
local equipped = true
local ball = script.Parent:WaitForChild("Part")
local weldBall = Instance.new("Weld",ball)	
weldBall.Part0 = ball
weldBall.Part1 = Character["RightHand"]
weldBall.C0 = CFrame.new(0,0,0) + Vector3.new(0,Character["RightHand"].Size.Y/2,0)




local BodyGyro = Instance.new("BodyGyro")
local function forceTurn()
	BodyGyro.D = 100
	BodyGyro.MaxTorque = Vector3.new(0, math.huge, 0)
	local forwardVector = (Player.Character.HumanoidRootPart.Position - midhoop).Unit
	local rightVector = forwardVector:Cross(Vector3.new(0,1,0))
	local upVector = rightVector:Cross(forwardVector)
	local cframe = CFrame.fromMatrix(Player.Character.HumanoidRootPart.Position, -rightVector, upVector)
	BodyGyro.CFrame = cframe
	BodyGyro.Parent = Player.Character.HumanoidRootPart
end

local currentMeter = shotMeter:WaitForChild("shotBar"):WaitForChild("currentMeter")
local TS = game:GetService("TweenService")
local meterTween = nil
local goal = {}
goal.Size = UDim2.new(1,0,0,-200)
local timeStarted = 0
local greenTimer = 0
local coolDown = false
local shooting = false

inputService.InputBegan:Connect(function(Key)
	if Key.KeyCode == Enum.KeyCode.F and equipped and not coolDown then
		shooting = true
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		Humanoid.WalkSpeed = 5
		shotMeter.Enabled = true
		shotMeter.Adornee = hrp
		shotAnimationTrack:Play()
		greenTimer = (math.random(1,2) / 10) + .15
		timeStarted = time()
		meterTween = TS:Create(currentMeter,TweenInfo.new(greenTimer, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true) ,goal)
		meterTween:Play()
		forceTurn()
		
		--Client-Sided Ball
		--local ball = bball:Clone();
		--ball.Velocity = v0;
		--ball.CFrame = CFrame.new(x0);
		--ball.CanCollide = true;
		--ball.Parent = game.Workspace;
		
		--Meme camera stuff
		--local subject = workspace.cameraAngle
		--camera.CameraType = "Scriptable"
		--camera.CameraSubject = subject
		--game:GetService('RunService').Stepped:Connect(function() -- On 
		--	camera.CFrame = subject.CFrame
		--end)	
	end
	if Key.KeyCode == Enum.KeyCode.LeftShift then
		Humanoid.WalkSpeed = 20
	end
end)

local timeHeld = 0
inputService.InputEnded:Connect(function(Key)
	if Key.KeyCode == Enum.KeyCode.F and not coolDown and shooting then
		coolDown = true
		shooting = false
		meterTween:Pause()
		Humanoid.WalkSpeed = 15
		timeHeld = time() - timeStarted
		local g = Vector3.new(0, -game.Workspace.Gravity, 0);
		local x0 = hrp.CFrame * Vector3.new(0, 2, -2);
		local perfect = (midhoop - x0 - 0.5*g*t*t)/t;
		local isPerfect = false
		local vOffset = math.abs(1 + (timeHeld - greenTimer) * .15)
		
		if(timeHeld > greenTimer - 0.01 and timeHeld < greenTimer + 0.01) then
			v0 = perfect
			t = .8
			currentMeter.BackgroundColor3 = Color3.fromRGB(0,170,0)
			isPerfect = true
		else
			print(vOffset)
			v0 = (midhoop - x0 - ((0.5)*vOffset)*g*t*t)/t;
		end
		
		if test then
			v0 = perfect
			isPerfect = true
		end
		local ball = shootBall:InvokeServer(x0, v0, isPerfect)
		local propBall = ball:WaitForChild("Part")
		
		print("Held for "..timeHeld)
		print("Green Timer "..greenTimer)
		BodyGyro.Parent = nil
		local touchedOnce = false
		propBall.Touched:Connect(function(collision)
			if(collision.name == "midhoop") and not touchedOnce then
				touchedOnce = true
				incScore:InvokeServer()
			end
		end)
		
		script.Parent:Destroy()
		wait(2)
		meterTween:Play()
		currentMeter.BackgroundColor3 = Color3.fromRGB(170,0,2)
		shotMeter.Adornee = nil
		shotMeter.Enabled = false
		meterTween.Completed:Wait()
		coolDown = false
	end
	
	if Key.KeyCode == Enum.KeyCode.LeftShift then
		Humanoid.WalkSpeed = 15
	end
	
end)



