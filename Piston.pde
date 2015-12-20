//ピストンを作るクラス
class Piston extends Cylinder{

	Piston(int _x,int _y,int _z){
		super(_x,_y,_z);
	}

	void drawPiston(float theta){

		pushMatrix();
		translate(posx, theta, posz);
		piston(25,24,24);
		super.cover(0,60,0,24,0,360);//第２引数ピストン上部の位置
		//ピストンリング----
		super.cover(0,60,0,25,0,360);
		super.cover(0,62,0,25,0,360);
		super.cover(0,64,0,25,0,360);
		//ピストンピン------
		pushMatrix();
		translate(0, 73, -60);
		rotateX(radians(90));
		piston(25,7,7);
		fill(10,10,10,255);
		super.cover(0,84,0,7,0,360);
		fill(0,0,0,255);
		super.cover(0,85,0,6,0,360);
		fill(120,120,120,255);

		//-----------------

		popMatrix();
		popMatrix();
	}



	void piston(float length,float radius1,float radius2){
		//fill(255,255,0,255);
		pushMatrix();
		translate(0, 70, 0);//ピストンの位置
		super.pillar(length,radius1,radius2,0,0,360);
		popMatrix();


	}

       //コンロッドを作成
	void conRod(float length,float radius1,float radius2){
		//fill(255,255,0,255);
		pushMatrix();
		translate(0, 160, 0);
		super.pillar(length,radius1,radius2,0,0,360);
		popMatrix();
	}


}
