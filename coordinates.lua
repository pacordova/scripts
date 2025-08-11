-- Copyright 2020 Hegwin Xiao Wang

-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files 
-- (the "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish, 
-- distribute, sublicense, and/or sell copies of the Software, and to permit
-- persons to whom the Software is furnished to do so, subject to the 
-- following conditions:

-- The above copyright notice and this permission notice shall be included
-- in all copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
-- THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
-- OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
-- ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
-- OTHER DEALINGS IN THE SOFTWARE.

WorldMapFrame:HookScript("OnUpdate", function(self, elapsed)
 self.elapsed = (self.elapsed or 0) + elapsed
 if self.elapsed > 0.2 then
  if not self.locationTip then
   local tip = CreateFrame("Frame", nil, WorldMapFrame)
   tip:SetFrameStrata("FULLSCREEN_DIALOG")
   self.locationTip = tip:CreateFontString(
    nil,
    "OVERLAY",
    "GameFontGreen"
   )
   self.locationTip:SetPoint("BOTTOM", self, "BOTTOM", 0, 8)
  end

  local pwmid, wmid =
  C_Map.GetBestMapForUnit("player"), WorldMapFrame:GetMapID()
  if pwmid == nil then
   return
  end

  RunScript('position = C_Map.GetPlayerMapPosition(0, "player")')
  local pinfo = C_Map.GetMapInfo(pwmid)
  local finfo = C_Map.GetMapInfo(wmid)
  local x, y = WorldMapFrame:GetNormalizedCursorPosition()

  if position then
   self.locationTip:SetText(
    format(
     "Player: %s %d,%d  Cursor: %s %d,%d",
     pinfo.name,
     position.x * 100,
     position.y * 100,
     finfo.name,
     x * 100,
     y * 100
    )
   )
  else
   self.locationTip:SetText(
    format("Cursor: %s %d,%d", finfo.name, x * 100, y * 100)
   )
  end

  self.elapsed = 0
 end
end)
