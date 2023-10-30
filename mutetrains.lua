--mute trains
mutetrains = CreateFrame("FRAME")
mutetrains:RegisterEvent("PLAYER_LOGIN");
mutetrains:SetScript('OnEvent', function()
	MuteSoundFile(539802)
	MuteSoundFile(539881)
	MuteSoundFile(540271)
	MuteSoundFile(540275)
end)
