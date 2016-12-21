--[[
Rematch.lua
@Author  : DengSir (tdaddon@163.com)
@Link    : https://dengsir.github.io
]]

hooksecurefunc('BattlePetToolTip_Show', function(speciesID, level, rarity, health, power, speed, customName)
    rarity = rarity + 1

    local petID = {
        speciesID = speciesID,
        level = level,
        rarity = rarity,
        health = health,
        power = power,
        speed = speed,
        breed = Rematch:GetBreedByStats(speciesID, level, rarity, health, power, speed),
    }

    Rematch.PetCard.keepOnScreen = true
    -- BattlePetTooltip:Hide()
    Rematch.PetCard.keepOnScreen = false

    if Rematch.PetCard:CurrentPetIDIsDifferent(petID) then
        Rematch:ShowPetCard(BattlePetTooltip, petID)
        Rematch.PetCard:ClearAllPoints()
        Rematch.PetCard:SetPoint(BattlePetTooltip:GetPoint())

        print(BattlePetTooltip:GetPoint())
    end
end)

hooksecurefunc(BattlePetTooltip, 'Hide', function()
    Rematch:HidePetCard(true)
end)

hooksecurefunc(BattlePetTooltip, 'SetPoint', function(_, ...)
    Rematch.PetCard:ClearAllPoints()
    Rematch.PetCard:SetPoint(...)

    print(...)
end)

hooksecurefunc(RematchPetCard, 'FlipCardIfAltDown', function(self)
    if IsControlKeyDown() then
        self.locked = not self.locked
        self:UpdateLockState()
    end
end)
