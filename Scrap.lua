--[[
Scrap.lua
@Author  : DengSir (tdaddon@163.com)
@Link    : https://dengsir.github.io
]]


local orig_MerchantFrame_UpdateBuybackInfo = MerchantFrame_UpdateBuybackInfo
MerchantFrame_UpdateBuybackInfo = function()
    if MerchantFrame.selectedTab == 2 then
        return orig_MerchantFrame_UpdateBuybackInfo()
    else
        for i = 11, 12 do
            _G['MerchantItem' .. i]:Hide()
        end
        MerchantBuyBackItem:Hide()
    end
end
