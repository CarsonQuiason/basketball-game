local camera = workspace.CurrentCamera
local subject = workspace.cameraAngle

camera.CameraType = "Scriptable"
camera.CameraSubject = subject

game:GetService('RunService').Stepped:Connect(function() -- On 
	camera.CFrame = subject.CFrame
end)