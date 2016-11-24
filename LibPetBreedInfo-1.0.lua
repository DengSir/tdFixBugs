--[[
LibPetBreedInfo-1.0.lua
@Author  : DengSir (tdaddon@163.com)
@Link    : https://dengsir.github.io
]]

local lib = LibStub('LibPetBreedInfo-1.0')

local MAX_PETS_PER_TEAM = 3
local STATE_Mod_SpeedPrecent = 25
local STATE_MaxHealthBonus = 2
local STATE_Mod_MaxHealthPrercent = 99
local WILD_PET_HEALTH_MULTIPLIER = 1.2
local WILD_PET_POWER_MULTIPLIER = 1.25

local function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

local function inverseStats(num)
	return num ~= 0 and 100/(num+100) or 1
end

function lib:GetBreedByPetBattleSlot(petOwner,id)
	if not C_PetBattles.IsInBattle() then return end
	if petOwner ~= LE_BATTLE_PET_ALLY and petOwner ~= LE_BATTLE_PET_ENEMY then return end
	if id <= 0 or id > MAX_PETS_PER_TEAM and id <= C_PetBattles.GetNumPets(petOwner) then return end
    local powerMutiplier   = 1
	local speedMultiplier  = C_PetBattles.GetStateValue(petOwner,id,STATE_Mod_SpeedPrecent)
	local healthMultiplier = C_PetBattles.GetStateValue(petOwner,id,STATE_Mod_MaxHealthPrercent)
	local healthModifier   = C_PetBattles.GetStateValue(petOwner,id,STATE_MaxHealthBonus)
	if not speedMultiplier or not healthMultiplier or not healthModifier then return end
	speedMultiplier  = inverseStats(speedMultiplier)
	healthMultiplier = inverseStats(healthMultiplier)

	if C_PetBattles.IsWildBattle() and petOwner == LE_BATTLE_PET_ENEMY then
		healthMultiplier = healthMultiplier * WILD_PET_HEALTH_MULTIPLIER
        powerMutiplier   = WILD_PET_POWER_MULTIPLIER
	end
	local speciesID = C_PetBattles.GetPetSpeciesID(petOwner,id)
	local speed     = round(C_PetBattles.GetSpeed(petOwner,id) * speedMultiplier)
	local power     = C_PetBattles.GetPower(petOwner,id) * powerMutiplier
	local health    = (C_PetBattles.GetMaxHealth(petOwner,id) * healthMultiplier) - healthModifier
	local rarity    = C_PetBattles.GetBreedQuality(petOwner,id)
	local level     = C_PetBattles.GetLevel(petOwner,id)
	return self:GetBreedByStats(speciesID,level,rarity,health,power,speed)
end
