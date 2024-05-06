	font "MSñæí©",32,0
	BulletReset

	repeat

	if cnt\20=0 {
	b_x=rnd(640)
	b_y=rnd(480)
		repeat 6
		BulletSet b_x,b_y,sin(deg2rad(cnt_t+cnt*60))*5,cos(deg2rad(cnt_t+cnt*60))*5
		loop
		BulletReflect
	}
	cnt_t+
	BulletMove

	stick key
	if key&2048 {
		break
	}
	if key&4096 {
		end
	}

	redraw 0
	//îwåiï`âÊ
	color 0,0,0
	boxf

	//îwåiÇ…íeñãï`âÊ
	BulletDraw

	//Ç≈Ç°Ç‹Å[
	gmode 3,0,0,127
	color 0,0,0
	grect 320,240,0,640,480

	//ï∂éö
	color 255,255,255
	pos 100,50
	mes "CatchCatchCatch!!"
	mes "......MadeByComet"
	pos 200,150
	mes "Z:START"
	mes "X:EXIT"
	redraw 1
	await 16
	loop