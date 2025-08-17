-- MIT License

-- Copyright (c) 2025 starpt, pacordova

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

local class = select(2, UnitClass("player"))
if class == "WARRIOR" then return end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD", "player")
frame:RegisterEvent("UNIT_AURA", "player")
frame:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "player")
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
frame:RegisterEvent("UNIT_POWER_FREQUENT", "player")

frame:SetScript("OnEvent", function(self, event, ...)
   if event == "PLAYER_ENTERING_WORLD" then
      function self.cure(key)
         local type = UnitPowerType("player")
         if key == "druid" then
            type = 0
         end
         return UnitPower("player", type), type
      end
      function self.rest(key, event, unit, powerType)
         local cure, type = self.cure(key)
         if event == "UPDATE_SHAPESHIFT_FORM" and class == "DRUID" then
            self[key].cure = cure
            self[key].timer = GetTime()
         elseif event == "UNIT_POWER_FREQUENT" and unit == "player" then
            if cure > self[key].cure then
               self[key].cure = cure
               self[key].timer = GetTime()
               PowerSparkDB[key].timer = self[key].timer
            end
         elseif event == "UNIT_SPELLCAST_SUCCEEDED" and unit == "player" then
            if cure < self[key].cure and type == 0 then
               self[key].wait = GetTime() + 5
            end
            self[key].cure = cure
         end
      end
      function self.init(parent, key)
         if not parent or self[key] then return end
         if not PowerSparkDB then PowerSparkDB = {} end
         if not PowerSparkDB[key] then PowerSparkDB[key] = {} end
         local power = CreateFrame("StatusBar", nil, parent)
         power:SetWidth(parent.width or parent:GetWidth())
         power:SetHeight(parent.height or parent:GetHeight())
         power:SetPoint("CENTER")
         power.spark = power:CreateTexture(nil, "OVERLAY")
         power.spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
         power.spark:SetWidth(32)
         power.spark:SetHeight(32)
         power.spark:SetBlendMode("ADD")
         power.spark:SetAlpha(0)
         power.cure = self.cure(key)
         power.rate = GetTime()
         power.timer = PowerSparkDB[key].timer or GetTime()
         power.interval = 2
         power.key = key
         power.parent = parent
         function power.hide(key)
            local cure, type = self.cure(key)
            return UnitIsDeadOrGhost("player")
            or key == "default" and type == 1
            or type == 0 and cure >= UnitPowerMax("player", 0)
            or type == 3
            and cure >= UnitPowerMax("player")
            and not IsStealthed()
            and (not UnitCanAttack("player", "target") or UnitIsDeadOrGhost(
               "target"
            ))
         end
         power:HookScript("OnUpdate", function(self)
            local now = GetTime()
            if now < self.rate then
               return
            end
            self.rate = now + 0.02
            self.spark:SetAlpha(1)
            self.spark:SetPoint(
               "CENTER",
               self,
               "LEFT",
               self:GetWidth()
               * (
                  mod(now - self.timer, self.interval)
                  / self.interval
               ),
               0
            )
         end)
         self[key] = power
      end
      self.init(PlayerFrameManaBar, "default")
   elseif event == "UNIT_AURA" and class == "ROGUE" and unit == "player" then
      self.interval = 2
      local i = 1
      while UnitBuff("player", i) do
         if select(10, UnitBuff("player", i)) == 13750 then
            self.interval = 1
            break
         end
         i = i + 1
      end
   elseif self.rest then
      self.rest("default", event, ...)
      if self.druid then
         self.rest("druid", event, ...)
      end
   end
end)
