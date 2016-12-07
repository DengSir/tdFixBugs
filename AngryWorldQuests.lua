--[[
AngryWorldQuests.lua
@Author  : DengSir (tdaddon@163.com)
@Link    : https://dengsir.github.io
]]

local Addon  = AngryWorldQuests
local Config = Addon.Config
local Data   = Addon.Data

local orig_RegisterCallback = Config.RegisterCallback
function Config:RegisterCallback(key, func)
    if type(key) == 'table' and key[1] == 'onlyCurrentZone' and key[2] == 'sortMethod' then

        setfenv(func, setmetatable({
            WorldMapFrame = {
                IsShown = function()
                    return QuestMapFrame:IsVisible()
                end
            }
        }, {__index = _G}))
        
        QuestMapFrame:HookScript('OnShow', func)
        QuestMapFrame:HookScript('OnHide', function()
            local owner = WorldMapTooltip:GetOwner()
            if owner and owner.TagText and owner.TimeIcon then
                WorldMapTooltip:Hide()
            end
        end)

        Config.RegisterCallback = orig_RegisterCallback
    end
    return orig_RegisterCallback(self, key, func)
end

local orig_ItemArtifactPower = Data.ItemArtifactPower
function Data:ItemArtifactPower(itemID)
    return IsArtifactPowerItem(itemID) and orig_ItemArtifactPower(self, itemID)
end
