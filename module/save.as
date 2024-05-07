#module
#deffunc InitUserData
	savedata=""
	notesel savedata
	notesave "user/save.dat"
	return

#deffunc LoadUserData
	notesel savedata
	noteload "user/save.dat"
	noteget Name,0
	noteget Hiscore,1
	return

#deffunc SaveUserData
	savedata=""
	notesel savedata
	noteadd Name
	noteadd Hiscore
	notesave "user/save.dat"
	return

#defcfunc HiscoreChange
	if int(Hiscore)<int(score) {
		Hiscore=str(score)
		return 0
	}
	return 1

#deffunc SaveUserDataName str SaveUserDataNamePrm1
	noteadd SaveUserDataNamePrm1
	return

#global