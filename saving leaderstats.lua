local players = game.Players
local datastoreservice = game:GetService("DataStoreService")
local currencydata = datastoreservice:GetDataStore("Currency data") -- Change the "Currency Data" to whatever you want to be name of your datastore
local currencyname = game.Workspace.How_The_Currency_Is_Gonna_Get_Named_Change_In_This_Value.Value
local startercurrency = 100 -- Change the 100 to whatever you want to be the starting amount of currency for new players
local rs = game:GetService("ReplicatedStorage") --DO NOT CHANGE THIS LINE
local click = rs:WaitForChild("click") --DO NOT CHANGE THIS LINE

players.PlayerAdded:Connect(function(player)
	
	--leaderstats code
	local leaderstats = Instance.new("Folder")
	leaderstats.Parent = player
	leaderstats.Name = "leaderstats"
	
	local currency = Instance.new("IntValue")
	currency.Name = currencyname
	currency.Parent = leaderstats
	currency.Value = currencydata:GetAsync(player.UserId, currency.Value) or startercurrency
	
	click.OnServerEvent:Connect(function(player)
		local howmuchwhenclicked = 1 --Change this line if you want to change how much currency the player gets when they click
		player:WaitForChild("leaderstats"):WaitForChild(currencyname).Value += howmuchwhenclicked
	end)
	
end)

players.PlayerRemoving:Connect(function(player)
	--Saving  leaderstats
	currencydata:SetAsync(player.UserId, player.leaderstats[currencyname].Value)
end)
