local loco = game.Players.LocalPlayer.Name

local Player = game.Players.LocalPlayer

game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

local Players = game:GetService("Players")

local Friends = script.Parent
Friends.Loading.Visible = true

local USERNAME = game.Players.LocalPlayer.Name










local function iterPageItems(pages)
	
	return coroutine.wrap(function()

		local pagenum = 1
		while true do
			for _, item in ipairs(pages:GetCurrentPage()) do
					
				coroutine.yield(item, pagenum)
			end
			if pages.IsFinished then
					
				break
			end
			pages:AdvanceToNextPageAsync()
		
			pagenum = pagenum + 1
		end
	end)
end

local userId = Players:GetUserIdFromNameAsync(USERNAME)

local friendPages = Players:GetFriendsAsync(userId)

local usernames = {}

for item, pageNo in iterPageItems(friendPages) do
	
	usernames[item.Username] = item.Id
	
end










local ButtonClone = game.ReplicatedStorage.TextButton

for v,i in pairs(usernames) do
	
	local b = ButtonClone:Clone()
	b.Parent = Friends.TextButtons
	b.Name = v
	
	b.Text = v
	
	local added = Instance.new("BoolValue", b)
	added.Name = v
	
	added.Value = false
	
	b.MouseButton1Click:Connect(function()
			
		added.Value = not added.Value
		
		if added.Value == true then
				
			b.BackgroundColor3 = Color3.new(0, 0.666667, 0)
		else
			b.BackgroundColor3 = Color3.new(255, 255, 255)
		end
	end)
	
	wait()
end

Friends.Loading.Visible = false










local loco = game.Players.LocalPlayer.Name

local userids = ""
local hi = "Start"

local remove = Friends["Toggle Remove"].RemoveValue

local keep = Friends["Toggle Keep"].KeepValue

game.Players[loco].PlayerGui.Main.Friends.UserIds.Text = ''










Friends.Generate.MouseButton1Click:Connect(function()

	game.Players[loco].PlayerGui.Main.Friends.UserIds.Text = ''
	userids = ""

	for i,v in pairs(game.Players[loco].PlayerGui.Main.Friends.TextButtons:GetDescendants()) do
		if v:IsA("BoolValue") and v.Value == true and remove.Value == true then
			local Friendz = usernames[v.Parent.Name]


			userids = Friendz..", "..userids
		elseif v:IsA("BoolValue") and v.Value == false and keep.Value == true then
			local Friendz = usernames[v.Parent.Name]


			userids = Friendz..", "..userids

		end

	end


	game.Players[loco].PlayerGui.Main.Friends.UserIds.Text = userids

end)
