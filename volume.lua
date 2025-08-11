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

-- Volume Slider
local vol = CreateFrame("Slider", "CharVol", PaperDollItemsFrame, "OptionsSliderTemplate")
vol:SetWidth(75)
vol:SetHeight(20)
vol:SetOrientation('HORIZONTAL')
vol:SetPoint("BOTTOMLEFT", PaperDollItemsFrame, "BOTTOMLEFT", 30, 90)
vol:Show()
vol:SetMinMaxValues(0, 10)
vol:SetValue(C_CVar.GetCVar("Sound_MasterVolume")*100)
vol:SetValueStep(1)
vol:SetObeyStepOnDrag(true)
vol:SetScript("OnValueChanged", function(self, val)
   SetCVar("Sound_MasterVolume", val/100)
end)

vol.Low:SetText('0')
vol.High:SetText('10')
--vol.Text:SetText("Volume")

-- Show Helm
local helm = CreateFrame("CheckButton", "CharHelm", PaperDollItemsFrame, "ChatConfigCheckButtonTemplate")
helm.Text:SetText("Helm")
helm:SetPoint("CENTER", PaperDollItemsFrame, "CENTER", -115, 5)
helm:SetChecked(ShowingHelm())
helm:Show()
helm:SetScript("OnClick", function(self, val)
   ShowHelm(self:GetChecked())
end)

-- Show Cloak
local cloak = CreateFrame("CheckButton", "CharHelm", PaperDollItemsFrame, "ChatConfigCheckButtonTemplate")
cloak:SetPoint("CENTER", PaperDollItemsFrame, "CENTER", -115, -15)
cloak:SetChecked(ShowingCloak())
cloak.Text:SetText("Cloak")
cloak:SetScript("OnClick", function(self, val)
   ShowCloak(self:GetChecked())
end)
