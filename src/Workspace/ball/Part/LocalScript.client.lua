local parent = script.Parent

local function onPlayerTouch(part)
	if part:IsDecendentOf(parent) then return end
	print(parent:GetFullName() .. " was touched by " .. part:GetFullName())
end
