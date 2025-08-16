-- Copyright (c) 2021 cybermind

-- This software is provided ‘as-is’, without any express or implied
-- warranty. In no event will the authors be held liable for any damages
-- arising from the use of this software.

-- Permission is granted to anyone to use this software for any purpose,
-- including commercial applications, and to alter it and redistribute it
-- freely, subject to the following restrictions:

-- 1. The origin of this software must not be misrepresented; you must not
-- claim that you wrote the original software. If you use this software
-- in a product, an acknowledgment in the product documentation would be
-- appreciated but is not required.

-- 2. Altered source versions must be plainly marked as such, and must not be
-- misrepresented as being the original software.

-- 3. This notice may not be removed or altered from any source
-- distribution.

local HideHotKeys_Frame = CreateFrame("Frame")

-- default enabled
if (HideHotKeys_HK_Hidden == nil) then
   HideHotKeys_HK_Hidden = true
end

-- default disabled
if (HideHotKeys_MN_Hidden == nil) then
   HideHotKeys_MN_Hidden = false
end


function HideHotKeys_EventHandler(self, event)
   if (event == "PLAYER_ENTERING_WORLD") then
      HideHotKeys_Update()
   end
end

-- the default ActionButton_UpdateHotkeys function will reget the first hotkey associated with a button
-- and show/hide if there is a bind or not, so we will rehide it if neccesary after the default function runs
function HideHotKeys_ActionButton_UpdateHotkeys(self, actionButtonType)
   local hkf = self.HotKey --_G[self:GetName().."HotKey"]

   if (hkf) then
      if (HideHotKeys_HK_Hidden and hkf:IsShown()) then
         hkf:Hide()

      elseif (not HideHotKeys_HK_Hidden and not hkf:IsShown()) then
         local action = self.action

         if action and HasAction(action) then
            -- only show hotkey if the default UI would
            local range = IsActionInRange(action)

            if hkf:GetText() ~= RANGE_INDICATOR or range or range == false then
               hkf:Show()
            end
         end

      end
   end
end


-- same with macro names, except i don't see any example of it actually being hidden/shown in the default UI
-- the macro name frame only has its text property changed to a space to "hide" it, but we will do this anyway
function HideHotKeys_ActionButton_Update(self)
   local mnf = self.Name --_G[self:GetName().."Name"]

   if (mnf) then
      if (HideHotKeys_MN_Hidden and mnf:IsShown()) then
         mnf:Hide()
      elseif (not HideHotKeys_MN_Hidden and not mnf:IsShown()) then
         mnf:Show()
      end
   end
end


--rehides if they should be hidden, called whenever the UI reshows them
function HideHotKeys_Update()
   if (HideHotKeys_HK_Hidden) then
      HideHotKeys_HK_HideAll()
   else
      HideHotKeys_HK_ShowAll()
   end
   if (HideHotKeys_MN_Hidden) then
      HideHotKeys_MN_HideAll()
   else
      HideHotKeys_MN_ShowAll()
   end
end


function HideHotKeys_HK_HideAll()
   HideHotKeys_HideBar("Action", "HotKey")
   HideHotKeys_HideBar("BonusAction", "HotKey")
   HideHotKeys_HideBar("PetAction", "HotKey")
   HideHotKeys_HideBar("MultiBarBottomLeft", "HotKey")
   HideHotKeys_HideBar("MultiBarBottomRight", "HotKey")
   HideHotKeys_HideBar("MultiBarRight", "HotKey")
   HideHotKeys_HideBar("MultiBarLeft", "HotKey")
   HideHotKeys_HK_Hidden = true
end


function HideHotKeys_HK_ShowAll()
   HideHotKeys_ShowBar("Action", "HotKey")
   HideHotKeys_ShowBar("BonusAction", "HotKey")
   HideHotKeys_ShowBar("PetAction", "HotKey")
   HideHotKeys_ShowBar("MultiBarBottomLeft", "HotKey")
   HideHotKeys_ShowBar("MultiBarBottomRight", "HotKey")
   HideHotKeys_ShowBar("MultiBarRight", "HotKey")
   HideHotKeys_ShowBar("MultiBarLeft", "HotKey")
   HideHotKeys_HK_Hidden = false
end


function HideHotKeys_MN_HideAll()
   HideHotKeys_HideBar("Action", "Name")
   HideHotKeys_HideBar("BonusAction", "Name")
   HideHotKeys_HideBar("MultiBarBottomLeft", "Name")
   HideHotKeys_HideBar("MultiBarBottomRight", "Name")
   HideHotKeys_HideBar("MultiBarRight", "Name")
   HideHotKeys_HideBar("MultiBarLeft", "Name")
   HideHotKeys_MN_Hidden = true
end


function HideHotKeys_MN_ShowAll()
   HideHotKeys_ShowBar("Action", "Name")
   HideHotKeys_ShowBar("PetAction", "Name")
   HideHotKeys_ShowBar("BonusAction", "Name")
   HideHotKeys_ShowBar("MultiBarBottomLeft", "Name")
   HideHotKeys_ShowBar("MultiBarBottomRight", "Name")
   HideHotKeys_ShowBar("MultiBarRight", "Name")
   HideHotKeys_ShowBar("MultiBarLeft", "Name")
   HideHotKeys_MN_Hidden = false
end

function HideHotKeys_HideBar(b, f)
   for i = 1, 12 do
      local o = _G[b.."Button"..i..f]
      if (o) then
         o:Hide()
      end
   end
end


function HideHotKeys_ShowBar(b, f)
   for i = 1, 12 do
      local o = _G[b.."Button"..i..f]
      if (o) then
         if f == "HotKey" then
            local action = _G[b.."Button"..i].action
            local range = IsActionInRange(action)
            if o:GetText() ~= RANGE_INDICATOR or range or range == false then
               o:Show()
            end
         else
            o:Show()
         end
      end
   end
end

HideHotKeys_Frame:SetScript("OnEvent", HideHotKeys_EventHandler)
HideHotKeys_Frame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- register a hook for action button update functions
--hooksecurefunc(ActionBarActionButtonMixin, "UpdateHotkeys", HideHotKeys_ActionButton_UpdateHotkeys)
--hooksecurefunc(ActionBarActionButtonMixin, "Update", HideHotKeys_ActionButton_Update)
