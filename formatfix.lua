-- MIT License

-- Copyright (c) 2020 Olle Månsson

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

-- focus frame
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
