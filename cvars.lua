local MY_GLOBALS = { 
   DAMAGE_TEXT_FONT = "Fonts\\PEPSI.ttf",
}

local MY_CVARS = {
   autoLootRate = "0",
   cameraDistanceMaxZoomFactor = 1.5,
   Sound_MasterVolume = 0.05,
   UIScale = 768/1080,
   gxWindowedResolution = "1920x1080",
}

for k, v in pairs(MY_GLOBALS) do _G[k] = v end
for k, v in pairs(MY_CVARS) do SetCVar(k, v) end
