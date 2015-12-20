//エフェクトのクラス
class Effect extends Cylinder{
	int th,tw,tx1,ty1,cnt;
	Effect(int _x,int _y,int _z){
		super(_x,_y,_z);
		tw=0;
		th=0;
		tx1=0;
		ty1=0;
		cnt=0;

	}
	void reset(){
		tw=0;
		th=0;
		tx1=0;
		ty1=0;
		cnt=0;

	}
        //シリンダー内の吸入された空気を青で表現する
	void drawIntakeAir(float swing){
	pushMatrix();
	translate(posx, posy, posz);

	fill(70,170,230,60);
	springCylinder(0,24,24,0,360,swing,33);
	fill(120,120,120,255);
	popMatrix();

	}
        //燃焼後のシリンダー内の空気の状態を赤で表現する
	void drawExhaustAir(float swing){
	pushMatrix();
	translate(posx, posy, posz);

	fill(255,0,0,60);
	springCylinder(0,24,24,0,360,swing,33);
	fill(120,120,120,255);
	popMatrix();
	}


//バネを作る
	void springCylinder(float top, float radius1 , float radius2 ,int degstart, int degend,float swing,float length){
		float x,y,z;
		pushMatrix();
		beginShape(TRIANGLE_STRIP);

		for(int deg =degstart; deg <= degend; deg = deg + 5){
		x = cos(radians(deg)) * radius1;
		y =top;
		z = sin(radians(deg)) * radius1;
		vertex(x,y,z);
		x = cos(radians(deg)) * radius2;
		y = swing+length;
		z = sin(radians(deg)) * radius2;
		 vertex(x,y,z);
		}
		endShape();
		super.cover(0,top,0,radius1,degstart,degend);
		super.cover(0,swing+length,0,radius2,degstart,degend);
		popMatrix();
	}


	int MAGNIFICATION =30;//波の倍率(sinは-1から1までなので)

	float increase;



	void effectSinwave(){
		//colorMode(HSB, width, 100, 100);
		pushMatrix();
		translate(10, 0, 0);


		drawbackboard(posx+50,posy,300,150);


		drawStraightLine(300);

	 	pushMatrix();
	 	translate(40, 0, 0);
	 	for (float x=0;x<250;x+=0.3) {//1回drawが呼ばれるごとに波を全部描画する
		float degrees = x + increase;

		//float colorWave = sin(radians(degrees))*127+127;
		//float colorWave = sin(radians(degrees))*width/255+width;
		//fill(colorWave,100,100);




		float sinWave = (sin(radians(degrees)*2));
		float cosWave = (cos(radians(degrees)*2));
		//fill(255, 0, 0,255);

		ellipse (x,  sinWave * MAGNIFICATION, 0.5,0.5);
		if(x==0){
			fill(255,0,0);
			ellipse (x,  sinWave * MAGNIFICATION, 10,10);
		}
		//ellipse (x, centerY + cosWave * MAGNIFICATION, ELLIPSE_WIDTH, ELLIPSE_WIDTH);
		//println(sinWave);
		}
		increase+=3;
		popMatrix();


	 	popMatrix();
	 	fill(120,120,120,255);
	 	popMatrix();
	}

	void textbox1(int transx,int transy,int transz,int w,int h){
		pushMatrix();
		translate(transx, transy, transz);
		drawbackboard(posx,posy,w,h);

		popMatrix();
	}




	void drawpVdiagram(){
		pushMatrix();
		translate(200, -300, -200);
		drawbackboard(posx,posy,300,300);
		stroke(0,255,255);
		horizonLine(30,280,260);
		verticalLine(30,280,230);

		if(cnt>=1){
			text("V",280,305);
			text("hPa",10,50);

			textSize(12);
			text("1013",0,230);
			text("TDC",40,305);
			text("BDC",240,305);
			dotLine(50,280,200,false);
			dotLine(250,280,100,false);
			cnt=2;


		}

		if(cnt>=2){
			if(strokeCount[0]==1)strokeWeight(3);
			else strokeWeight(1);
			stroke(0,0,255);
			line(50,230,250,230);//intake
			line(200,230,195,225);
			line(200,230,195,235);


			if(strokeCount[0]==2)strokeWeight(3);
			else strokeWeight(1);
			stroke(225,128,0);
			noFill();
			bezier(250,230, 200, 220, 100, 210, 50, 150);




			if(strokeCount[0]==3)strokeWeight(3);
			else strokeWeight(1);
			stroke(255,0,0);
			line(50,150,50,80);
			line(50,130,45,135);
			line(50,130,55,135);
			bezier(50, 80, 100, 200, 200, 200, 250, 210);


			if(strokeCount[0]==4)strokeWeight(3);
			else strokeWeight(1);
			stroke(255,255,255);
			//line(250,210,250,225);//exhaust
			bezier(250, 210, 280, 240, 100, 210, 50, 230);


			//line(250,225,50,225);
			line(150,223,155,218);
			line(150,223,155,228);
			//line(50,225,50,230);


		}

		strokeWeight(1);










		popMatrix();
	}


	void dotLine(int x,int y,int length,boolean horizon){
		for(int i=0;i<length;i+=5){
			if(horizon){
				point(x+i,y);
			}else{
				point(x,y-i);
			}
		}
	}



	void horizonLine(int x,int y,int length){
		line(x,y,x+tx1,y);
		if(tx1>=length){
			tx1=length;
			line(x+tx1,y,x+tx1-10,y-5);
			line(x+tx1,y,x+tx1-10,y+5);
			cnt=1;


		}else{
			tx1+=10;
		}

	}


	void verticalLine(int x,int y,int length){
		line(x,y,x,y-ty1);
		if(ty1>=length){
			ty1=length;
			line(x,y-ty1,x-5,y-ty1+10);
			line(x,y-ty1,x+5,y-ty1+10);
		}else{
			ty1+=10;
		}

	}


	void drawStraightLine(int length){
		noStroke();
		smooth();
		pushMatrix();
		translate(posx+30, posy+50, posz);
		stroke(0,255,255);
		line(40,-25,0,40,25,0);
	 	line(30,0,0,len,0,0);

	 	if(len>=length){
	 		len=length;
	 	}else{
	 		len+=10;
	 	}


	}




	void drawbackboard(int x,int y,int w,int h){
		pushMatrix();
		translate(0, 0, -1);
		fill(0,255,255,100);
		stroke(0,255,255);
		line(x,y,x+tw,y);
		line(x+w-tw,y+h,x+w,y+h);
		line(x,y+h,x,y+h-th);
		line(x+w,y,x+w,y+th);
		if(tw>=w)tw=w;
		else tw+=10;
	 	if(th>=h)th=h;
	 	else th+=10;
		noStroke();
		rect(x,y,w,h);
		popMatrix();


	}


}
