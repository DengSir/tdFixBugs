--[[
GnomishVendorShrinker.lua
@Author  : DengSir (tdaddon@163.com)
@Link    : https://dengsir.github.io
]]

local GVS do
    for _, f in ipairs({MerchantBuyBackItem:GetChildren()}) do
        if f and f:GetObjectType() == 'Frame' and not f:GetName() and f:GetScript('OnHide') == f.UnregisterAllEvents then
            GVS = f
            break
        end
    end
end

local Refresh = GVS:GetScript('OnEvent')

local function Update()
    GVS:SetScript('OnUpdate', nil)
    Refresh()
end

local function OnShow()
    GVS:RegisterEvent('MERCHANT_SHOW')
    GVS:RegisterEvent('MERCHANT_FILTER_ITEM_UPDATE')
end

GVS:HookScript('OnShow', OnShow)
GVS:SetScript('OnEvent', function()
    GVS:SetScript('OnUpdate', Update)
end)

if GVS:IsVisible() then
    OnShow()
end
