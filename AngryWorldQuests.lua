--[[
AngryWorldQuests.lua
@Author  : DengSir (tdaddon@163.com)
@Link    : https://dengsir.github.io
]]

local Addon  = AngryWorldQuests
local Config = Addon.Config
local Data   = Addon.Data

local Updater = CreateFrame('Frame', nil, QuestMapFrame)
local QuestFrame_Update
local isOurCall = false

local _ENV = setmetatable({
    WorldMapFrame = {
        IsShown = function()
            if isOurCall then
                return QuestMapFrame:IsVisible()
            else
                return Updater:Request()
            end
        end
    }
}, {__index = _G})

function Updater:Update()
    self:SetScript('OnUpdate', nil)
    isOurCall = true
    QuestFrame_Update()
    isOurCall = false
end

function Updater:Request()
    self:SetScript('OnUpdate', self.Update)
end

local orig_RegisterCallback = Config.RegisterCallback
function Config:RegisterCallback(key, func)
    if type(key) == 'table' and key[1] == 'onlyCurrentZone' and key[2] == 'sortMethod' then
        QuestFrame_Update = func

        setfenv(func, _ENV)

        Config.RegisterCallback = orig_RegisterCallback
    end
    return orig_RegisterCallback(self, key, func)
end

local orig_ItemArtifactPower = Data.ItemArtifactPower
function Data:ItemArtifactPower(itemID)
    return IsArtifactPowerItem(itemID) and orig_ItemArtifactPower(self, itemID)
end
