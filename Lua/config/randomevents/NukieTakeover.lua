local event = {}
event.Name = "NukieTakeover"
event.MinRoundTime = 5
event.MinIntensity = 0
event.MaxIntensity = 0.1
event.ChancePerMinute = 0.000005
event.OnlyOncePerRound = true

event.Start = function()
    local deadCharacters = {}
    for _,client in pairs(Client.ClientList) do
        if client.Character == nil or client.Character.IsDead then
            table.insert(deadCharacters, client) -- Add dead characters to the list
        end
    end

    if #deadCharacters == 0 then
        event.End()
        return
    end

    for _, deadCharacter in ipairs(deadCharacters) do
        local submarine = Submarine.MainSub
        local subPosition = submarine.WorldPosition
        local angle = math.random() * 2 * math.pi
        local distance = math.random(2000, 3000)
        local offsetX = math.cos(angle) * distance
        local offsetY = math.sin(angle) * distance
        local position = Vector2(subPosition.X + offsetX, subPosition.Y + offsetY)
        Traitormod.GeneratePirate(position, deadCharacter, "nukie")
        Traitormod.SendMessageCharacter(deadCharacter.Character, "You are the Nukies, you are not aligned with anyone but yourselves, your goal is to set off the reactor and kill any who stand in your way", "CrewWalletIconLarge")
    end

    Traitormod.RoundEvents.SendEventMessage("The Nukies have arrived!", "CrewWalletIconLarge")
end

event.End = function()
end

return event