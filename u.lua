local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function getTargetPlayer(query)
    query = query:lower()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower() == query or (p.DisplayName and p.DisplayName:lower() == query) then
            return p
        end
    end
    return nil
end

player.Chatted:Connect(function(message)
    local args = message:split(" ")
    local command = args[1]:lower()
    
    if command == "/pos" then
        local targetPlayer
        if args[2] then
            targetPlayer = getTargetPlayer(args[2])
        else
            targetPlayer = player
        end
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            print("Position of " .. targetPlayer.Name .. ": " .. tostring(targetPlayer.Character.HumanoidRootPart.Position))
        else
            print("Could not get position for target player.")
        end

    elseif command == "/tp" then
        if args[2] then
            local targetPlayer = getTargetPlayer(args[2])
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local targetPos = targetPlayer.Character.HumanoidRootPart.Position
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 5, 0))
                    print("Teleported to " .. targetPlayer.Name)
                else
                    print("Player not found.")
                end
            else
                print("Player not found.")
            end
        else
            print("Usage: /tp <username or displayname>")
        end
    end
end)
