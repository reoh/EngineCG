//カムシャフトを作るためのクラス
class Camshaft extends Cylinder{

	Camshaft(int _x,int _y,int _z){
		super(_x,_y,_z);
	}
        //カムシャフトを描写
	void drawCamshaft(float theta){
		//-----
		pushMatrix();
		translate(0, -35, 0);
		fill(255,255,0,255);
		//super.triangle(7,4,4,0,360);
		fill(120,120,120,255);
		popMatrix();
		//---


		pushMatrix();
		translate(posx, posy, posz);
		rotateX(radians(90));
		rotateY(radians(theta-42));
		createCamshaft();
		translate(0, 160, 0);
		createCampulley();
		popMatrix();


	}
        //カムシャフトの形を作る
	void createCamshaft(){
		pushMatrix();
		translate(0, 50, 0);
		super.columnar(250,3,3,0,360);
		popMatrix();
		fill(255,255,0,255);
		pushMatrix();
		translate(0, 100, 0);

		super.triangle(7,4,4,0,360);//cam1
		translate(0, -50, 0);
		pushMatrix();
		rotateY(radians(270));
		super.triangle(7, 4, 4, 0, 360);//cam2
		translate(0, -50, 0);
		rotateY(radians(180));
		super.triangle(7, 4, 4, 0, 360);//cam3

		popMatrix();
		translate(0, -100, 0);
		rotateY(radians(180));

		super.triangle(7, 4, 4, 0, 360);//cam4
		fill(120,120,120,255);
		popMatrix();
	}
        //カムプーリーの形を作る
	void createCampulley(){
		fill(120,120,120,50);
		super.gear(8,24,24,0,360,2);
		translate(0, 8, 0);
		super.columnar(15,20,20,0,360);
		fill(120,120,120,255);

	}
}
