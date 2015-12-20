//クランクシャフトを作るためのクラス
class Crankshaft extends Cylinder{

	Crankshaft(int _x,int _y,int _z){
		super(_x,_y,_z);
	}

	void drawCrankshaft(float theta){
		pushMatrix();
		translate(posx, posy, posz+20);

		//crankJournal(100,20,20);//仮
		rotateX(radians(90));
		rotateY(radians(theta));
		pushMatrix();
		translate(0, 5, 0);
		crank(34,12,12,0,360);
		//crank(5,15,15,0,360);
		popMatrix();

		pushMatrix();
		//translate(thetax, -20,thetay);
		//translate(-25, -15, -15);
		translate(10, -10, 0);
		crankArm();
		translate(0, -20, 0);
		pushMatrix();
		translate(10, 10, 0);
		crank(20,12,12,0,360);//crankpin
		popMatrix();
		crankArm();


		popMatrix();
		popMatrix();



	}

	void crank(float length,float radius1,float radius2,int degstart,int degend){
		//fill(255,255,0,255);
		pushMatrix();
		//translate(0, 130, 0);

		super.pillar(length,radius1,radius2,0,degstart,degend);
		super.cover(0,length/2,0,radius1,degstart,degend);
		super.cover(0,-length/2,0,radius1,degstart,degend);

		popMatrix();
	}
        //クランクアームを作る
	void crankArm(){
		crank(5,25,25,0,360);
		pushMatrix();
		translate(0, 2, 0);
		fill(0,0,0,255);
		crank(2,25,25,250,360);//counterWeight
		fill(10,10,10,255);
		popMatrix();
	}

        //クランクプーリーを作る
	void createCrankpulley(float theta){
		pushMatrix();
		translate(posx, posy, posz+20);


		rotateX(radians(90));
		rotateY(radians(theta));

		pushMatrix();
		translate(0, 40, 0);
		crank(34,6,6,0,360);

		pushMatrix();
		translate(0, -15, 0);
		super.columnar(3,20,20,0,360);
		translate(0, 3, 0);
		super.columnar(3,12,12,0,360);
		popMatrix();


		super.gear(8,12,12,0,360,2);

		translate(0, -6, 0);
		super.gear(5,20,20,0,360,2);



		popMatrix();


		popMatrix();

	}


}
