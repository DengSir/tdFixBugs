--[[
AngryWorldQuests.lua
@Author  : DengSir (tdaddon@163.com)
@Link    : https://dengsir.github.io
]]

hooksecurefunc('KeyBindingFrame_Update', function()
    local self = KeyBindingFrame
    local numBindings = #self.cntCategory
    for i = 1, KEY_BINDINGS_DISPLAYED do
        self.keyBindingRows[i]:SetShown(self.scrollOffset + i <= numBindings)
    end
end)
