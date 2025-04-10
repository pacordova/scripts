-- Copyright © 2021 Paul A. Cordova

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

local function RANGE(BUTTON)
    oor = IsActionInRange(BUTTON.action)
    if oor == nil then
		return false
    else
        return not oor
    end
end

local function COLOR(self)
    local id = self.action
    if not id then
        return
    end
    local usable, oom = IsUsableAction(id)
    if oom then
        self.icon:SetVertexColor(0.1, 0.1, 0.8)
        return
    end
    if RANGE(self) then
        self.icon:SetVertexColor(0.8, 0.1, 0.1)
        return
    end
    self.icon:SetVertexColor(1.0, 1.0, 1.0)
    return
end

hooksecurefunc("ActionButton_UpdateRangeIndicator", COLOR)
hooksecurefunc("ActionButton_UpdateUsable", COLOR)
