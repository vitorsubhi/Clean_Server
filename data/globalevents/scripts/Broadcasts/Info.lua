function onThink(interval, lastExecution)
	MENSAGEM = {
		"Any doubt? Ask us in the help channel (Ctrl+T) in Old-Client or (CTRL+H) in New-Client.",
		"Found a bug or want to report somebody? Send us a report (Ctrl+R), and wait our reply. -- Do not close the Channel",
		"Want to report a bug? Send us a bug report with (CTRL+Z)."
	}

	doBroadcastMessage(MENSAGEM[math.random(1,#MENSAGEM)],22)
	return TRUE
end
