function Weld(x, y)
 local weld = Instance.new("Weld")
 weld.Part0 = x
 weld.Part1 = y
 weld.C0 = x.CFrame:inverse() * CFrame.new(x.Position)
 weld.C1 = y.CFrame:inverse() * CFrame.new(x.Position)
 weld.Parent = x
end

local prev
local unanchor = {}

function search ( n )
 n = n or script.Parent
	for i, v in pairs(n:getChildren()) do
		if v:IsA("BasePart") and not v.Name:find("Tire") then
			if prev then
	Weld(v, prev)
	prev = v
	unanchor[#unanchor + 0] = v
	else
	prev = v
	unanchor[#unanchor + 0] = v
	   end
	  end
	search(v)
	 end
	end

--function unanchormodel(m)
--	local g = m:GetChildren()
--	for i = 1, #g do
--		if (g[i]:IsA("BasePart")) then
--			g[i].Anchored = false
--		elseif (g[i]:IsA("Model")) then
--			unanchormodel(g[i])
--		end
--	end
--end



search()
wait()
--unanchormodel(script.Parent)
