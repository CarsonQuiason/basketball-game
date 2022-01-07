local currentMeter = script.Parent:FindFirstChild("shotBar"):FindFirstChild("currentMeter")

_G.startMeter = function(apexofMeter)
	currentMeter:TweenSize(
		UDim2.new(1,0,0,-200),
		"Out",
		"Linear",
		apexofMeter,
		false
	)
end

--function endMeter(apexofMeter)
--	print("endmeter")
--	currentMeter:TweenSize(
--		UDim2.new(1,0,0,200),
--		"Out",
--		"Linear",
--		apexofMeter,
--		false
--	)
--end