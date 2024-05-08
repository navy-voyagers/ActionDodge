#module Bullet2
#deffunc Bullet2Init
	BULLET_TOTAL=1024

	ddim BulletX,BULLET_TOTAL
	ddim BulletY,BULLET_TOTAL
	ddim BulletXChange,BULLET_TOTAL
	ddim BulletYChange,BULLET_TOTAL
	dim BulletColorR,BULLET_TOTAL
	dim BulletColorG,BULLET_TOTAL
	dim BulletColorB,BULLET_TOTAL
	dim BulletExist,BULLET_TOTAL
	dim BulletSize,BULLET_TOTAL
	return

#deffunc Bullet2Reset
	repeat BULLET_TOTAL
	BulletX(cnt)=0.0
	BulletY(cnt)=0.0
	BulletXChange(cnt)=0.0
	BulletYChange(cnt)=0.0
	BulletExist(cnt)=0
	BulletColorR(cnt)=0
	BulletColorG(cnt)=127
	BulletColorB(cnt)=255
	BulletSize(cnt)=30
	loop
	return

#deffunc Bullet2Color int Bullet2ColorPrm1 , int Bullet2ColorPrm2 , int Bullet2ColorPrm3
	repeat BULLET_TOTAL
	if BulletExist(cnt)=0 {
		BulletColorR(cnt)=Bullet2ColorPrm1
		BulletColorG(cnt)=Bullet2ColorPrm2
		BulletColorB(cnt)=Bullet2ColorPrm3
	}
	loop
	return

#deffunc Bullet2Set double BulletSet2Prm1 , double BulletSet2Prm2 , double BulletSet2Prm3 , double BulletSet2Prm4 , int BulletSet2Prm5
	BulletLog=0
	repeat BULLET_TOTAL
	if BulletExist(cnt)=0 {
		BulletX(cnt)=BulletSet2Prm1
		BulletY(cnt)=BulletSet2Prm2
		BulletXChange(cnt)=BulletSet2Prm3
		BulletYChange(cnt)=BulletSet2Prm4
		BulletSize(cnt)=BulletSet2Prm5
		BulletExist(cnt)=1
		BulletLog=1
		dmmplay 10
		break
	}
	loop
	if BulletLog=0 {
		logmes "Too Many Bullet"
	}
	return

#deffunc Bullet2Del int Bullet2DelPrm1
	BulletExist(Bullet2DelPrm1)=0
	return

#deffunc Bullet2SpeedChange double Bullet2SpeedChangePrm1
	repeat BULLET_TOTAL
	if BulletExist(cnt)=1 {
		BulletXChange(cnt)=BulletXChange(cnt)*Bullet2SpeedChangePrm1
		BulletYChange(cnt)=BulletYChange(cnt)*Bullet2SpeedChangePrm1
	}
	loop
	return

#deffunc Bullet2MoveChange double Bullet2MoveChangePrm1 , double Bullet2MoveChangePrm2
	repeat BULLET_TOTAL
	if BulletExist(cnt)=1 {
		BulletXChange(cnt)=Bullet2MoveChangePrm1
		BulletYChange(cnt)=Bullet2MoveChangePrm2
	}
	loop
	return

#deffunc Bullet2Move
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

	loop

	repeat BULLET_TOTAL
	if absf(player_x-BulletX(cnt))<BulletSize(cnt)/2 and absf(player_y-BulletY(cnt))<BulletSize(cnt)/2 and BulletExist(cnt)=1 {
		Miss_sw=1
		BulletExist(cnt)=0
	}
	loop

	return

#deffunc Bullet2Reflect
	repeat BULLET_TOTAL
	if BulletExist(cnt)=1 {
		if BulletX(cnt)>640 or BulletX(cnt)<0 {
			BulletXChange(cnt)=(-1.0)*BulletXChange(cnt)
		}
		if BulletY(cnt)<0 {
			BulletYChange(cnt)=(-1.0)*BulletYChange(cnt)
		}
	}
	loop
	return

#deffunc Bullet2Draw
	repeat BULLET_TOTAL
	if BulletExist(cnt)=1 {
		if BulletY(cnt)>-30 and BulletY(cnt)<500 {
			color BulletColorR(cnt),BulletColorG(cnt),BulletColorB(cnt)
			circle BulletX(cnt)-(BulletSize(cnt)/2),BulletY(cnt)-(BulletSize(cnt)/2),BulletX(cnt)+(BulletSize(cnt)/2),BulletY(cnt)+(BulletSize(cnt)/2)
			color 127+(BulletColorR(cnt)/2),127+(BulletColorG(cnt)/2),127+(BulletColorB(cnt)/2)
			circle BulletX(cnt)-(BulletSize(cnt)/3),BulletY(cnt)-(BulletSize(cnt)/3),BulletX(cnt)+(BulletSize(cnt)/3),BulletY(cnt)+(BulletSize(cnt)/3)
			color 255,255,255
			circle BulletX(cnt)-(BulletSize(cnt)/4),BulletY(cnt)-(BulletSize(cnt)/4),BulletX(cnt)+(BulletSize(cnt)/4),BulletY(cnt)+(BulletSize(cnt)/4)
		}
	}
	loop
	return

#defcfunc Bullet2Miss		//ミスを知らせる関数
	if Miss_sw=1 {
		Miss_sw=0
		return 1
	}else{
		return 0
	}

#defcfunc Bullet2Info int Bullet2InfoPrm1 , int Bullet2InfoPrm2
	if Bullet2InfoPrm2>BULLET_TOTAL {
		return "error"
	}
	switch Bullet2InfoPrm1
	case 0		//BulletX
	return BulletX(Bullet2InfoPrm2)

	case 1		//BulletY
	return BulletY(Bullet2InfoPrm2)

	case 2		//BulletXChange
	return BulletXChange(Bullet2InfoPrm2)

	case 3		//BulletYChange
	return BulletYChange(Bullet2InfoPrm2)

	case 4		//BulletExist
	return BulletExist(Bullet2InfoPrm2)

	case 5		//BULLET_TOTAL
	return BULLET_TOTAL

	swend

	return "error"

#deffunc Bullet2SetVector double Bullet2SetVectorPrm1 , double Bullet2SetVectorPrm2 , double Bullet2SetVectorPrm3 , double Bullet2SetVectorPrm4 , double Bullet2SetVectorPrm5
	//BulletSetVector X,Y,スピード,角度,弾の大きさ
	Bullet2Set Bullet2SetVectorPrm1,Bullet2SetVectorPrm2,cos(deg2rad(Bullet2SetVectorPrm4))*Bullet2SetVectorPrm3,sin(deg2rad(Bullet2SetVectorPrm4))*Bullet2SetVectorPrm3,Bullet2SetVectorPrm5
	return

#global