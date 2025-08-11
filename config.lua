--SetCVAR("gxWindowedResolution", "1920x1080")
SetCVar("UIScale", 768/1080)
SetCVar("cameraDistanceMaxZoomFactor", 1.5)
DAMAGE_TEXT_FONT = "Fonts\\PEPSI.ttf"

local main = CreateFrame('Frame');
main:RegisterEvent('PLAYER_LOGIN');
main:SetScript('OnEvent', function()
   PlayerFrame:ClearAllPoints()
   PlayerFrame:SetPoint("CENTER", UIParent, "CENTER", -500, 300)
   PlayerFrame:SetUserPlaced(true);
   TargetFrame:ClearAllPoints() 
   TargetFrame:SetPoint("CENTER", UIParent, "CENTER", -250, 300) 
   TargetFrame:SetUserPlaced(true)
   FriendsMicroButton:Hide()
   ChatFrameChannelButton:Hide()
end)