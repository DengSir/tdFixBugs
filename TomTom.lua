--[[
TomTom.lua
@Author  : DengSir (tdaddon@163.com)
@Link    : https://dengsir.github.io
]]

local function Update()
    if TomTomBlock then
        TomTomBlock:SetFrameStrata('HIGH')
    end
end

hooksecurefunc(TomTom, 'ShowHideCoordBlock', Update)
Update()
