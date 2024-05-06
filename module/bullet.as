#module Bullet
#deffunc BulletInit
	BULLET_SIZE=15
	BULLET_TOTAL=128

	ddim BulletX,BULLET_TOTAL
	ddim BulletY,BULLET_TOTAL
	ddim BulletXChange,BULLET_TOTAL
	ddim BulletYChange,BULLET_TOTAL
	dim BulletExist,BULLET_TOTAL

	Bullet_r=0
	Bullet_g=127
	Bullet_b=255

	return
#deffunc BulletReset
	repeat BULLET_TOTAL
	BulletX(cnt)=0.0
	BulletY(cnt)=0.0
	BulletXChange(cnt)=0.0
	BulletYChange(cnt)=0.0
	BulletExist(cnt)=0
	loop
	return

#deffunc BulletSet double BulletSetPrm1 , double BulletSetPrm2 , double BulletSetPrm3 , double BulletSetPrm4
	BulletLog=0
	repeat BULLET_TOTAL
	if BulletExist(cnt)=0 {
		BulletX(cnt)=BulletSetPrm1
		BulletY(cnt)=BulletSetPrm2
		BulletXChange(cnt)=BulletSetPrm3
		BulletYChange(cnt)=BulletSetPrm4
		BulletExist(cnt)=1
		BulletLog=1
		break
	}
	loop
	if BulletLog=0 {
		logmes "Too Many Bullet"
	}
	return

#deffunc BulletMove
	player_x=PlayerInfo(0)
	player_y=PlayerInfo(1)

	repeat BULLET_TOTAL

	if BulletExist(cnt)=1 {
		BulletX(cnt)=double(BulletX(cnt)+BulletXChange(cnt))
		BulletY(cnt)=double(BulletY(cnt)+BulletYChange(cnt))
		if BulletY(cnt)>500 or BulletY(cnt)<-60 or BulletX(cnt)<-60 or BulletX(cnt)>700 {
			BulletExist(cnt)=0
		}
	}
	if BulletExist(cnt)=2 {
		BulletX(cnt)=double(player_x)
		BulletY(cnt)=double(BulletY(cnt)+(BulletYChange(cnt)))
		if BulletY(cnt)>500 {
			BulletExist(cnt)=0
			score@-10
			life@-1
		}
	}

	loop

	repeat BULLET_TOTAL
	if absf(player_x-BulletX(cnt))<BULLET_SIZE/2 and absf(player_y-BulletY(cnt))<BULLET_SIZE/2 and BulletExist(cnt)=1 {
		dmmplay 3
		BulletExist(cnt)=2
	}
	loop

	return

#deffunc BulletReflect
	repeat BULLET_TOTAL
	if BulletExist(cnt)=1 {
		if BulletX(cnt)<-30 or BulletX(cnt)>655 {
			BulletXChange(cnt)=(-1.0)*BulletXChange(cnt)
			if absf(BulletYChange(cnt))<0.5 {
				BulletExist(cnt)=0
			}
		}
		if BulletY(cnt)<-30 {
			BulletYChange(cnt)=(-1.0)*BulletYChange(cnt)
		}
	}
	loop
	return

#deffunc BulletDraw
	repeat BULLET_TOTAL
	if BulletExist(cnt)=1 or BulletExist(cnt)=2 {
		if BulletY(cnt)>-30 and BulletY(cnt)<500 {
			color Bullet_r,Bullet_g,Bullet_b
			circle BulletX(cnt)-(BULLET_SIZE/2),BulletY(cnt)-(BULLET_SIZE/2),BulletX(cnt)+(BULLET_SIZE/2),BulletY(cnt)+(BULLET_SIZE/2)
			color 127+(Bullet_r/2),127+(Bullet_g/2),127+(Bullet_b/2)
			circle BulletX(cnt)-(BULLET_SIZE/3),BulletY(cnt)-(BULLET_SIZE/3),BulletX(cnt)+(BULLET_SIZE/3),BulletY(cnt)+(BULLET_SIZE/3)
			color 255,255,255
			circle BulletX(cnt)-(BULLET_SIZE/4),BulletY(cnt)-(BULLET_SIZE/4),BulletX(cnt)+(BULLET_SIZE/4),BulletY(cnt)+(BULLET_SIZE/4)
		}
	}
	loop
	return

#defcfunc BulletInfo int BulletInfoPrm1 , int BulletInfoPrm2
	if BulletInfoPrm2>BULLET_TOTAL {
		return "error"
	}
	switch BulletInfoPrm1
	case 0		//BulletX
	return BulletX(BulletInfoPrm2)

	case 1		//BulletY
	return BulletY(BulletInfoPrm2)

	case 2		//BulletXChange
	return BulletXChange(BulletInfoPrm2)

	case 3		//BulletYChange
	return BulletYChange(BulletInfoPrm2)

	case 4		//BulletExist
	return BulletExist(BulletInfoPrm2)

	swend

	return "error"

#global