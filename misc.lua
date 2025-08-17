-- Copyright 2025 pacordova

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

local frame = CreateFrame('Frame');
frame:RegisterEvent('PLAYER_LOGIN');
frame:SetScript('OnEvent', function()
   PlayerFrame:ClearAllPoints()
   PlayerFrame:SetPoint("CENTER", UIParent, "CENTER", -500, 300)
   PlayerFrame:SetUserPlaced(true);
   TargetFrame:ClearAllPoints() 
   TargetFrame:SetPoint("CENTER", UIParent, "CENTER", -250, 300) 
   TargetFrame:SetUserPlaced(true)
   FriendsMicroButton:Hide()
   ChatFrameChannelButton:Hide()
end)

-- Volume Slider
local volume = CreateFrame("Slider", "CharVol", PaperDollItemsFrame, "OptionsSliderTemplate")
volume:SetWidth(75)
volume:SetHeight(20)
volume:SetOrientation('HORIZONTAL')
volume:SetPoint("BOTTOMLEFT", PaperDollItemsFrame, "BOTTOMLEFT", 30, 90)
volume:Show()
volume:SetMinMaxValues(0, 10)
volume:SetValue(C_CVar.GetCVar("Sound_MasterVolume")*100)
volume:SetValueStep(1)
volume:SetObeyStepOnDrag(true)
volume:SetScript("OnValueChanged", function(self, val)
   SetCVar("Sound_MasterVolume", val/100)
end)

volume.Low:SetText('0')
volume.High:SetText('10')
--volume.Text:SetText("Volume")

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

-- CrapAway
if C_Container ~= nil then
   GetContainerNumSlots = C_Container.GetContainerNumSlots
   GetContainerItemLink = C_Container.GetContainerItemLink
   UseContainerItem     = C_Container.UseContainerItem
end

frmcrapaway = CreateFrame("FRAME")
frmcrapaway:RegisterEvent("MERCHANT_SHOW");
frmcrapaway:SetScript('OnEvent', function()
   local caSlots,caLink,caQuality;
   local i=0,j;
   local _,caClass=UnitClass("player");
   repeat
      if not(GetContainerNumSlots(i)==nil)then
         caSlots=GetContainerNumSlots(i);
         j=1;
         repeat
            caLink=GetContainerItemLink(i,j);
            if not(caLink==nil)then                        
               _,_,caQuality=GetItemInfo(caLink);
               if(caQuality==0)then
                  UseContainerItem(i,j);
               end
            end
            j=j+1;
         until(j>=caSlots+1)
      end
      i=i+1;
   until(i>=5)
end)
