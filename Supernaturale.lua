-- Create the main frame for your addon
local Supernaturale = CreateFrame("Frame")

-- Create a function to play the sound
local function play_sound()
    PlaySoundFile("Interface\\AddOns\\Supernaturale\\cheese.mp3", "Master")
end

local funkyTextFrame = CreateFrame("Frame")
funkyTextFrame:Hide()

local function UpdateFunkyTextColor(frame)
    local r, g, b = math.random(), math.random(), math.random()
    frame.text:SetTextColor(r, g, b)
end

local function DisplayFunkyText(text, fontSize, duration)
    funkyTextFrame.text = funkyTextFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    funkyTextFrame.text:SetText(text)
    funkyTextFrame.text:SetFont("Fonts\\FRIZQT__.TTF", fontSize)
    funkyTextFrame.text:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    funkyTextFrame:Show()

    local startTime = GetTime()
    UpdateFunkyTextColor(funkyTextFrame)

    funkyTextFrame:SetScript("OnUpdate", function()
        if GetTime() - startTime >= duration then
            funkyTextFrame:Hide()
            funkyTextFrame:SetScript("OnUpdate", nil)
        else
            UpdateFunkyTextColor(funkyTextFrame)
        end
    end)
end

-- Function to handle loot events and trigger the sound
-- local function HandleLootCelebration(event, arg1, addon)
--     if event == "CHAT_MSG_LOOT" or event == "PLAYER_XP_UPDATE" then
--         play_sound()
--         DisplayFunkyText("UDRI SIRENYE!!!!!", 36, 5)
--         print("aide")
--         -- Add more celebration effects or sound here
--     end
--     if addon == "Supernaturale" then
--         print("Supernaturale loaded!")
--     end
-- end

Supernaturale:RegisterEvent("CHAT_MSG_LOOT") -- Register for loot events
Supernaturale:RegisterEvent("ADDON_LOADED") -- Register for addon loaded events
Supernaturale:RegisterEvent("PLAYER_XP_UPDATE") -- Register for combat log events

-- Register the loot event handler
Supernaturale:SetScript("OnEvent", function(self, event, addon)
    if event == "CHAT_MSG_LOOT" then
        local player, itemLink = string.match(arg1, "(.+) receives (.+).")
        if player and itemLink then
            local _, _, quality, _, _, itemType = GetItemInfo(itemLink)
            if quality == 2 then
                print(player .. " received an uncommon item: " .. itemLink)
                play_sound()
                DisplayFunkyText("UDRI SIRENYE!!!!!", 36, 5)
                print("aide")
                -- Add more celebration effects or sound here
            end
        end
    end
    -- if event == "CHAT_MSG_LOOT" then
    --     play_sound()
    --     DisplayFunkyText("UDRI SIRENYE!!!!!", 36, 5)
    --     print("aide")
    --     -- Add more celebration effects or sound here
    -- end
    if addon == "Supernaturale" then
        print("Supernaturale loaded!")
    end
end)

-- Slash command for testing the sound effect
SLASH_CHEESE1 = "/cheese"

function SlashCmdList.CHEESE(msg, editbox)
    if msg == "play" then
        -- Trigger the sound effect manually for testing
        play_sound()
        DisplayFunkyText("UDRI SIRENYE!!!!!", 36, 5)
    else
        print("Usage: /cheese play")
    end
end
