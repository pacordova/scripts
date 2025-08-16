-- Copyright © 2025 pacordova

-- Redistribution and use of this script, with or without modification, is
-- permitted provided that the following conditions are met:

-- 1. Redistributions of this script must retain the above copyright
-- notice, this list of conditions and the following disclaimer.

-- THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
-- WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
-- MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
-- EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
-- PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
-- OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
-- WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
-- OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
-- ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

local function isoor(x)
   local ir = IsActionInRange(x.action)
   if ir == nil then return false else return not ir end
end

local function colorize(self)
   local id = self.action
   if not id then return end
   local usable, oom = IsUsableAction(id)
   if not usable then
      if oom then
         self.icon:SetVertexColor(35/255, 45/255, 75/255)
      else
         self.icon:SetVertexColor(48/255, 76/255, 30/255)
      end
   elseif isoor(self) then
      self.icon:SetVertexColor(48/255, 76/255, 30/255)
   else
      self.icon:SetVertexColor(1, 1, 1)
   end
end

hooksecurefunc("ActionButton_UpdateRangeIndicator", colorize)
hooksecurefunc("ActionButton_UpdateUsable", colorize)
