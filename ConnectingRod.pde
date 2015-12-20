//コネクティングロッドを作るためのクラス
class ConnectingRod {
	float posx,posy,z,h;
	float v=60;
	ConnectingRod(float _x,float _y,float _z){
		posx=_x;
		posy=_y;
		z=_z;
	}

	void drawRod(float thetax,float thetay,float h){
		setVertex(thetax,thetay,h);
	}
        //四角柱を作る
	void setVertex(float x,float y,float h){
		float d=7;
		beginShape(QUAD_STRIP);
		vertex(5, y+h, z+d);//A
		vertex(5, y+h, z-d);//B
		vertex(x-5, y+h, z-d);//C
		vertex(x-5, y+h, z+d);//D

		vertex(5, y+h, z+d);//A
		vertex(5, y+h, z-d);//B
		vertex(x+6, y+h+v, z+d);//F
		vertex(x+6, y+h+v, z-d);//G

		vertex(5, y+h, z+d);//A
		vertex(-5, y+h, z+d);//D
		vertex(x-6, y+h+v, z+d);//E
		vertex(x+6, y+h+v, z+d);//F

		vertex(5, y+h, z-d);//B
		vertex(-5, y+h, z-d);//C
		vertex(x+6, y+h+v, z-d);//G
		vertex(x-6, y+h+v, z-d);//H

		vertex(-5, y+h, z-d);//C
		vertex(-5, y+h, z+d);//D
		vertex(x-6, y+h+v, z+d);//E
		vertex(x-6, y+h+v, z-d);//H

 		vertex(x-6, y+h+v, z+d);//E
		vertex(x+6, y+h+v, z+d);//F
		vertex(x+6, y+h+v, z-d);//G
		vertex(x-6, y+h+v, z-d);//H

		endShape();
	}


}
