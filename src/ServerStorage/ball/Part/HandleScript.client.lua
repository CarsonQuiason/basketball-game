local model = script.Parent

print(model.Name)

local function onTouched(Part)
	print(Part.Name)
end

model.Touched:Connect(onTouched)