//スパークプラグを作成するクラス
class Sparkplug extends Cylinder{

	Sparkplug(int _x,int _y,int _z){
		super(_x,_y,_z);
	}

	void drawSparkplug(){
		pushMatrix();
		translate(posx, posy, posz);

		pushMatrix();
		translate(0, -2, 0);
		super.columnar(25,6,6,180,360);
		popMatrix();

		insulator();



		pushMatrix();
		translate(0, 5, 0);
		//super.columnar(2,5,5,0,360);
		//stroke(1);
		super.hexagon(2,5,5,0,360);//ボルト
		//noStroke();
		popMatrix();

		pushMatrix();
		translate(0, 6, 0);
		super.columnar(7,4,4,0,360);

		popMatrix();

		pushMatrix();
		translate(0, 10, 0);
		reach();
		translate(0, 5, 0);
		pushMatrix();
		translate(0,-3, 0);
		super.pillar(7,4,4,0,180,360);
		popMatrix();
		pushMatrix();
		translate(-0.5, 2.5, 0);
		box(3,0.5,1);
		translate(-1.2, -1.5, 0);
		box(0.5,3,1);
		popMatrix();
		popMatrix();



		popMatrix();
	}

	void reach(){

		super.columnar(10,2.5,2.5,0,360);
		super.columnar(13,1,1,0,360);
		for(float y=0;y<=5;y+=0.5){
		super.cover(0,y,0,2.6,0,360);//ネジの部分
		}


	}
	void insulator(){//絶縁体部分
		shininess(1.0);
		pushMatrix();
		translate(0, -4, 0);
		super.columnar(1.5,2.6,3,0,360);

		for(int i=0;i<3;i++){
			translate(0, -1.5, 0);
			super.columnar(1.5,2.6,3,0,360);
		}
		translate(0, -1.5, 0);
		terminal();


		popMatrix();
		super.columnar(7,3,3,0,360);
		shininess(5.0);
	}
        //ターミナルの作成
	void terminal(){
		shininess(3.0);
		super.columnar(1.7,2.6,2.6,0,360);
		translate(0, -1.1, 0);
		super.columnar(0.5,2,2.6,0,360);
		translate(0, -0.6, 0);
		super.columnar(0.8,2,2,0,360);
		translate(0, -0.8, 0);
		super.columnar(0.8,2.6,2.0,0,360);
		translate(0, -0.8, 0);
		super.columnar(0.8,2.2,2.6,0,360);


		shininess(1.0);
	}





}
