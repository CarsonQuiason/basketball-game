
local db = false

script.Parent.Touched:connect(function(hit)
	if db == false then
db = true
        
    script.Parent.Sound1:play()
	
	wait(1)
	db = false
end
end)
     
               
