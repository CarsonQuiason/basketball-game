l = game:service("Lighting")
light0 = script.Parent.PointLight
light1 = script.Parent.SpotLight
light2 = script.Parent.BillboardGui.ImageLabel

function toMinutes(hour) --turns something like 7.5 hours into 450 minutes.
hour = hour * 60
return hour
end


local time1 = 18
local time2 = 6

function event1() --Event when the time is within your designated time.
	light0.Enabled = true
	light1.Enabled = true
	light2.ImageTransparency = 0.5
end

function event2() --Event when the time is outside your designated time.
	light0.Enabled = false
	light1.Enabled = false
	light2.ImageTransparency = 1
end

function onChanged()
	if time2 <= time1 then
		if l:GetMinutesAfterMidnight() >= toMinutes(time1) or l:GetMinutesAfterMidnight() <= toMinutes(time2) then
		event1()
		else
		event2()
		end
	elseif time2 >= time1 then
		if l:GetMinutesAfterMidnight() >= toMinutes(time1) and l:GetMinutesAfterMidnight() <= toMinutes(time2) then
		event1()
		else
		event2()
		end
	end
end

l.Changed:connect(onChanged)
