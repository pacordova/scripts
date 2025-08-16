-- MIT License

-- Copyright (c) 2025 Brik

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local frame = CreateFrame("Frame");

frame:SetScript("OnEvent", function(self, event, arg1)
   if IsModifiedClick("AUTOLOOTTOGGLE") then
      -- Don't loot if auto loot key is held down
      return
   else
      -- Otherwise, try to loot items every frame until there are none
      frame:SetScript("OnUpdate", function(self)
         local numItems = GetNumLootItems()
         if numItems > 0 then
            for i = numItems, 1, -1 do
               LootSlot(i)
            end
         else
            -- No more loot, stop checking every frame
            frame:SetScript("OnUpdate", nil)
         end
      end)
   end
end)

frame:RegisterEvent("LOOT_READY")

-- Speed up built-in autolooting so it can play with us when there's a lot of loot
SetCVar("autoLootRate", "0")
