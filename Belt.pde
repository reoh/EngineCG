//タイミングベルトを描画する関数
class Belt extends Cylinder{

	Belt(int _x,int _y,int _z){
		super(_x,_y,_z);
	}
       //ベルトを描写する
	void drawBelt(){
		pushMatrix();

		translate(posx, posy, posz);
		rotateX(radians(-90));
		createBelt(7,15,15,0,360);
		popMatrix();
	}

       //ベルトの形を作る
	void createBelt(float length,float radius1,float radius2,int degstart,int degend){
		float x,y,z;
		pushMatrix();
		pushMatrix();
		beginShape(TRIANGLE_STRIP);
		for(int deg =degstart+5; deg <= 175; deg = deg + 5){
		x = cos(radians(deg)) * radius1;
		y = -length/2;
		z = sin(radians(deg)) * radius1;
		vertex(x,y,z);
		x = cos(radians(deg)) * radius2;
		y = length / 2;
		z = sin(radians(deg)) * radius2;
		 vertex(x,y,z);
		}
		pushMatrix();
		//translate(-20, -400, 50);
		for(int deg=155;deg<=270;deg+=5){
		x = cos(radians(deg)) * radius1*2-25;
		y = -length/2;
		z = sin(radians(deg)) * radius1*2-148;
		vertex(x,y,z);
		x = cos(radians(deg)) * radius2*2-25;
		y = length / 2;
		z = sin(radians(deg)) * radius2*2-148;
		 vertex(x,y,z);
		}
		popMatrix();
		pushMatrix();
		//translate(20, 0, 0);
		for(int deg=270;deg<=385;deg+=5){
		x = cos(radians(deg)) * radius1*2+25;
		y = -length/2;
		z = sin(radians(deg)) * radius1*2-148;
		vertex(x,y,z);
		x = cos(radians(deg)) * radius2*2+25;
		y = length / 2;
		z = sin(radians(deg)) * radius2*2-148;
		 vertex(x,y,z);
		}
		popMatrix();

		x = cos(radians(degend+5)) * radius1;
		y = -length/2;
		z = sin(radians(degend+5)) * radius1;
		vertex(x,y,z);
		x = cos(radians(degend+5)) * radius2;
		y = length / 2;
		z = sin(radians(degend+5)) * radius2;
		 vertex(x,y,z);

		endShape();
		popMatrix();
		//tricover(0,length/2,0,radius1,degstart,degend);
		//tricover(0,-length/2,0,radius2,degstart,degend);
		popMatrix();
	}

}
