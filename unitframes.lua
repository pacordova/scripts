-- MIT License

-- Copyright (c) 2025 Olle Månsson, draon12, pacordova

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

---------------------------------------------
-- HealthBar
---------------------------------------------
TargetFrameTextureFrame:CreateFontString("TargetFrameHealthBarText", "BORDER", "TextStatusBarText")
TargetFrameHealthBarText:SetPoint("CENTER", TargetFrameTextureFrame, "CENTER", -50, 3)

TargetFrameTextureFrame:CreateFontString("TargetFrameHealthBarTextLeft", "BORDER", "TextStatusBarText")
TargetFrameHealthBarTextLeft:SetPoint("LEFT", TargetFrameTextureFrame, "LEFT", 8, 3)

TargetFrameTextureFrame:CreateFontString("TargetFrameHealthBarTextRight", "BORDER", "TextStatusBarText")
TargetFrameHealthBarTextRight:SetPoint("RIGHT", TargetFrameTextureFrame, "RIGHT", -110, 3)

---------------------------------------------
-- ManaBar
---------------------------------------------
TargetFrameTextureFrame:CreateFontString("TargetFrameManaBarText", "BORDER", "TextStatusBarText")
TargetFrameManaBarText:SetPoint("CENTER", TargetFrameTextureFrame, "CENTER", -50, -8)

TargetFrameTextureFrame:CreateFontString("TargetFrameManaBarTextLeft", "BORDER", "TextStatusBarText")
TargetFrameManaBarTextLeft:SetPoint("LEFT", TargetFrameTextureFrame, "LEFT", 8, -8)

TargetFrameTextureFrame:CreateFontString("TargetFrameManaBarTextRight", "BORDER", "TextStatusBarText")
TargetFrameManaBarTextRight:SetPoint("RIGHT", TargetFrameTextureFrame, "RIGHT", -110, -8)

---------------------------------------------
-- INITIALIZE
---------------------------------------------
local ADDON_NAME = ...
local frame = CreateFrame("frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
   if ( event == "ADDON_LOADED" and addonName == ADDON_NAME ) then
      TargetFrameHealthBar.LeftText = TargetFrameHealthBarTextLeft;
      TargetFrameHealthBar.RightText = TargetFrameHealthBarTextRight
      TargetFrameManaBar.LeftText = TargetFrameManaBarTextLeft;
      TargetFrameManaBar.RightText = TargetFrameManaBarTextRight;
      UnitFrameHealthBar_Initialize("target", TargetFrameHealthBar, TargetFrameHealthBarText, true);
      UnitFrameManaBar_Initialize("target", TargetFrameManaBar, TargetFrameManaBarText, true);
   end
end)

---------------------------------------------
-- FormatFix
---------------------------------------------
local BarFormatFuncs={
   [PlayerFrameHealthBar]=function(self,textstring,val,min,max)
      textstring:SetText(AbbreviateLargeNumbers(val));
   end;
   [TargetFrameHealthBar]=function(self,textstring,val,min,max)
      if not FormatFix_UsePercent then textstring:SetText(AbbreviateLargeNumbers(val));
      elseif max==100 then textstring:SetText(AbbreviateLargeNumbers(val).."%");
      else textstring:SetFormattedText("%s || %.0f%%",AbbreviateLargeNumbers(val),100*val/max); end
   end;
   [PetFrameHealthBar]=function(self,textstring,val,min,max)
      textstring:SetText(AbbreviateLargeNumbers(val));
   end;
   [PetFrameManaBar]=function(self,textstring,val,min,max)
      textstring:SetText(AbbreviateLargeNumbers(val));
      textstring:SetPoint("CENTER", PetFrame, "TOPLEFT", 82, -37);
   end;
}

BarFormatFuncs[PlayerFrameManaBar]=BarFormatFuncs[PlayerFrameHealthBar];
BarFormatFuncs[TargetFrameManaBar]=BarFormatFuncs[PlayerFrameHealthBar];

if FocusFrameHealthBar ~= nil then
   BarFormatFuncs[FocusFrameHealthBar]=BarFormatFuncs[PlayerFrameHealthBar];
   BarFormatFuncs[FocusFrameManaBar]=BarFormatFuncs[PlayerFrameHealthBar];
end

hooksecurefunc("TextStatusBar_UpdateTextStringWithValues",function(self,...)
   if BarFormatFuncs[self] then
      if GetCVar("statusTextDisplay") == "NUMERIC" then
         BarFormatFuncs[self](self,...);
         (...):Show();
      end
   end
end);
