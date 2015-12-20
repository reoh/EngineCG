//バルブの作成
class Valve extends Cylinder{
	float angle=20;
	Valve(int  _x,int  _y,int  _z){
		super(_x,_y,_z);
	}


	void drawIntakeValve(float theta,float stheta){
		pushMatrix();
		rotateZ(radians(-angle));
		pushMatrix();
		translate(posx-20, -8, posz);
		super.columnar(2,5,5,0,360);
		popMatrix();
		translate(posx-20, theta, posz);
		createvalve(stheta);

		popMatrix();
	}
	void drawExhaustValve(float theta,float stheta){
		pushMatrix();
		rotateZ(radians(angle));
		pushMatrix();
		translate(posx+20, -8, posz);
		super.columnar(2,5,5,0,360);
		popMatrix();
		translate(posx+20, theta, posz);

		createvalve(stheta);
		popMatrix();
	}


	void createvalve(float theta){
		pushMatrix();
		translate(0, -17, 0);
		super.columnar(7,5,5,0,360);//tappet
		fill(255,255,0,255);
		super.spring(1,5,5,0,360,5,theta);//spring
		fill(10,10,10,255);
		popMatrix();
		super.columnar(40,1,1,0,360);
		pushMatrix();
		translate(0, 20, 0);
		super.columnar(2,2,10,0,360);
		popMatrix();

	}

}
