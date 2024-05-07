//物を追加
#deffunc FallObjectAdd
	repeat OBJECT_TOTAL
	if object_exist(cnt)=0 {
		object_x(cnt)=rnd(640)
		object_y(cnt)=-30
		object_change_x(cnt)=2-rnd(5)
		object_change_y(cnt)=2+rnd(2)
		object_exist(cnt)=1
	}

	if bad_object_exist(cnt)=0 {
		bad_object_x(cnt)=rnd(640)
		bad_object_y(cnt)=-30
		bad_object_change_x(cnt)=2-rnd(5)
		bad_object_change_y(cnt)=2+rnd(2)
		bad_object_exist(cnt)=1
	}
	loop
	return

//上からもの落とす(演算処理)
#deffunc FallObjectCalc
	repeat OBJECT_TOTAL
	if object_exist(cnt)=1 {
		object_x(cnt)=object_x(cnt)+object_change_x(cnt)
		object_y(cnt)=object_y(cnt)+object_change_y(cnt)
		if object_y(cnt)>530 {
			//一番下まで行ったら消す
			object_exist(cnt)=0
		}
		if object_x(cnt)<-30 or object_x(cnt)>670 {
			//壁に当たったら反射
			object_change_x(cnt)=(-1)*object_change_x(cnt)
		}
	}
	if object_exist(cnt)=2 {
		//棒に引っかかって表示
		object_x(cnt)=player_x
		object_y(cnt)=object_y(cnt)+object_change_y(cnt)
		if object_y(cnt)>530 {
			//一番下まで行ったら消す
			dmmplay 2
			object_exist(cnt)=3
			score+100
			life+
		}
	}

	if bad_object_exist(cnt)=1 {
		bad_object_x(cnt)=bad_object_x(cnt)+bad_object_change_x(cnt)
		bad_object_y(cnt)=bad_object_y(cnt)+bad_object_change_y(cnt)
		if bad_object_y(cnt)>530 {
			//一番下まで行ったら消す
			bad_object_exist(cnt)=0
		}
		if bad_object_x(cnt)<-30 or bad_object_x(cnt)>670 {
			//壁に当たったら反射
			bad_object_change_x(cnt)=(-1)*bad_object_change_x(cnt)
		}
	}
	if bad_object_exist(cnt)=2 {
		//棒に引っかかって表示
		bad_object_x(cnt)=player_x
		bad_object_y(cnt)=bad_object_y(cnt)+bad_object_change_y(cnt)
		if bad_object_y(cnt)>530 {
			//一番下まで行ったら消す
			dmmplay 1
			bad_object_exist(cnt)=3
			score-100
			life-10
		}
	}
	loop
	return

//ものと接触しているか調べるのだ。ぼくはずんだもんなのだ()
#deffunc FallObjectCheck
	repeat OBJECT_TOTAL
	if abs(player_x-object_x(cnt))<OBJECT_SIZE/2 and abs(player_y-object_y(cnt))<OBJECT_SIZE/2 and object_exist(cnt)=1 {
		//get object!!!!!!
		dmmplay 3
		object_exist(cnt)=2
	}

	if abs(player_x-bad_object_x(cnt))<OBJECT_SIZE/2 and abs(player_y-bad_object_y(cnt))<OBJECT_SIZE/2 and bad_object_exist(cnt)=1 {
		//get object!!!!!!
		dmmplay 3
		bad_object_exist(cnt)=2
	}
	loop
	return

//上からもの落とす(描画処理)
#deffunc FallObjectDraw
	repeat OBJECT_TOTAL
	if object_exist(cnt)=1 or object_exist(cnt)=2 and object_y(cnt)>-30 and object_y(cnt)<500 {
		color object_color_r,object_color_g,object_color_b
		circle object_x(cnt)-(OBJECT_SIZE/2),object_y(cnt)-(OBJECT_SIZE/2),object_x(cnt)+(OBJECT_SIZE/2),object_y(cnt)+(OBJECT_SIZE/2)
		color 127+(object_color_r/2),127+(object_color_g/2),127+(object_color_b/2)
		circle object_x(cnt)-(OBJECT_SIZE/3),object_y(cnt)-(OBJECT_SIZE/3),object_x(cnt)+(OBJECT_SIZE/3),object_y(cnt)+(OBJECT_SIZE/3)
		color 255,255,255
		circle object_x(cnt)-(OBJECT_SIZE/4),object_y(cnt)-(OBJECT_SIZE/4),object_x(cnt)+(OBJECT_SIZE/4),object_y(cnt)+(OBJECT_SIZE/4)
	}

	if bad_object_exist(cnt)=1 or bad_object_exist(cnt)=2 and bad_object_y(cnt)>-30 and bad_object_y(cnt)<500 {
		color bad_object_color_r,bad_object_color_g,bad_object_color_b
		circle bad_object_x(cnt)-(OBJECT_SIZE/2),bad_object_y(cnt)-(OBJECT_SIZE/2),bad_object_x(cnt)+(OBJECT_SIZE/2),bad_object_y(cnt)+(OBJECT_SIZE/2)
		color 127+(bad_object_color_r/2),127+(bad_object_color_g/2),127+(bad_object_color_b/2)
		circle bad_object_x(cnt)-(OBJECT_SIZE/3),bad_object_y(cnt)-(OBJECT_SIZE/3),bad_object_x(cnt)+(OBJECT_SIZE/3),bad_object_y(cnt)+(OBJECT_SIZE/3)
		color 255,255,255
		circle bad_object_x(cnt)-(OBJECT_SIZE/4),bad_object_y(cnt)-(OBJECT_SIZE/4),bad_object_x(cnt)+(OBJECT_SIZE/4),bad_object_y(cnt)+(OBJECT_SIZE/4)
	}

	if object_exist(cnt)=3 {
		color object_color_r,object_color_g,object_color_b
		grect object_x(cnt),480,0,OBJECT_SIZE,300
	}
	if bad_object_exist(cnt)=3 {
		color bad_object_color_r,bad_object_color_g,bad_object_color_b
		grect bad_object_x(cnt),480,0,OBJECT_SIZE,300
	}
	loop
	return
	
#deffunc FallObjectEffect
	repeat OBJECT_TOTAL
	if object_exist(cnt)=3 {
		color object_color_r,object_color_g,object_color_b
		pos object_x(cnt),object_y(cnt)
		mes "+100"
		object_y(cnt)-3
		if object_y(cnt)<400 : object_exist(cnt)=0
	}
	if bad_object_exist(cnt)=3 {
		color bad_object_color_r,bad_object_color_g,bad_object_color_b
		pos bad_object_x(cnt),bad_object_y(cnt)
		mes "-100"
		bad_object_y(cnt)-3
		if bad_object_y(cnt)<400 : bad_object_exist(cnt)=0
	}
	loop
	return
