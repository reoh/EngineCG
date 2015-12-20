//あらゆる形状の円柱を作るためのクラス
class Cylinder{
int posx,posy,posz;

Cylinder(int _x,int _y,int _z){
	posx=_x;
	posy=_y;
	posz=_z;

}

void drawCylinder(){
	pushMatrix();
	translate(posx, posy, posz);
	intakeManifold(50,15,10);
	exhaustManifold(50,15,10);
	pushMatrix();
	translate(0, 28, 0);
	cylinder(77,25,25);
	popMatrix();
	cover(0,20,0,25,210,330);//シリンダー上面
	//cover(0,15,0,25,25,0,360);


	popMatrix();
}



void cylinder(float length,float radius1,float radius2){
	//fill(255,255,0,150);
	pushMatrix();
	translate(0, 30, 0);
	pillar(length,radius1,radius2,0,180,360);
	popMatrix();
}
//インマニを作る
void intakeManifold(float length,float radius1,float radius2){
	//fill(255,255,0,150);
	pushMatrix();
	translate(-20, 0, 0);
	rotateZ(radians(-20));
	pillar(length,radius1,radius2,1,0,360);
	popMatrix();
}
//エキマニを作る
void exhaustManifold(float length,float radius1,float radius2){
	//fill(255,255,0,150);
	pushMatrix();
	translate(20, 0, 0);
	rotateZ(radians(20));
	rotateY(radians(180));
	pillar(length,radius1,radius2,1,0,360);
	popMatrix();
}





//上面、下面、側面がある円柱を作るメソッド
void columnar(float length,float radius1,float radius2,int degstart,int degend){
	//fill(255,255,0,255);
	pushMatrix();

	pillar(length,radius1,radius2,0,degstart,degend);
	cover(0,length/2,0,radius2,degstart,degend);
	cover(0,-length/2,0,radius1,degstart,degend);
	popMatrix();
}


void pillar(float length, float radius1 , float radius2 ,int flag,int degstart, int degend){//円柱側面作成
float x,y,z;
pushMatrix();
beginShape(TRIANGLE_STRIP);
for(int deg =degstart; deg <= degend; deg = deg + 5){
x = cos(radians(deg)) * radius1;
y = -length/2;
z = sin(radians(deg)) * radius1;
if(flag==0||flag==3)vertex(x,y,z);
else if(flag==1)vertex(y,z,x);
x = cos(radians(deg)) * radius2;
y = length / 2;
z = sin(radians(deg)) * radius2;

 vertex(x,y,z);
}
endShape();
popMatrix();
}

void spring(float length, float radius1 , float radius2 ,int degstart, int degend,int coils,float swing){//円柱側面作成
float x,y,z;
y=0;
pushMatrix();
beginShape(TRIANGLE_STRIP);
for(int i=0;i<coils;i++){
for(int deg =degstart; deg <= degend; deg = deg + 10){
x = cos(radians(deg)) * radius1;
y +=swing;
z = sin(radians(deg)) * radius1;
vertex(x,y,z);

x = cos(radians(deg)) * radius2;
y = y+length;
z = sin(radians(deg)) * radius2;

 vertex(x,y,z);
 y=y-length;
}
}
endShape();
popMatrix();
}
//円柱の上面、下面を作る
void cover(float x,float y,float z,float radius1,int degstart,int degend){
	beginShape(TRIANGLE_FAN);

	vertex(x, y, z);//面の中心点
	for(int deg = degstart; deg <= degend; deg = deg + 10){
	x = cos(radians(deg)) * radius1;
	z = sin(radians(deg)) * radius1;
	vertex(x, y, z);//円周上の点
	}
	endShape();
}
//歯車を作る
void gearside(float x,float y,float z,float radius1,int degstart,int degend,float length){
	beginShape(TRIANGLE_STRIP);
	float x1,z1;
	boolean flg=false;
	vertex(x, y, z);//面の中心点
	vertex(x, y-length, z);
	for(int deg = degstart; deg <= degend; deg = deg + 10){
	x1 = cos(radians(deg)) * radius1;
	z1 = sin(radians(deg)) * radius1;
	vertex(x1, y, z1);//円周上の点
	vertex(x1,y-length,z1);
	if(flg){
	vertex(x, y, z);
	}
	flg=!flg;
	}
	endShape();
}
void gearcover(float x,float y,float z,float radius1,int degstart,int degend){
	beginShape(TRIANGLE_FAN);
	float x1,z1;
	boolean flg=false;
	vertex(x, y, z);//面の中心点

	for(int deg = degstart; deg <= degend; deg = deg + 10){
	x1 = cos(radians(deg)) * radius1;
	z1 = sin(radians(deg)) * radius1;
	vertex(x1, y, z1);//円周上の点
	if(flg){
	vertex(x, y, z);
	}
	flg=!flg;
	}
	endShape();
}
void gear(float length,float radius1,float radius2,int degstart,int degend,float a ){
	columnar(length,radius1,radius2,degstart,degend);
	gearside(0,length/2,0,radius1+a,degstart,degend,length);
	gearcover(0,length/2-1,0,radius1+a,degstart,degend);
	gearcover(0,-length/2,0,radius2+a,degstart,degend);
}
void hexcover(float x,float y,float z,float radius1,int degstart,int degend){
	beginShape(TRIANGLE_FAN);

	vertex(x, y, z);//面の中心点
	for(int deg = degstart; deg <= degend; deg = deg + 60){
	x = cos(radians(deg)) * radius1;
	z = sin(radians(deg)) * radius1;
	vertex(x, y, z);//円周上の点
	}
	endShape();
}



void hexagon(float length,float radius1,float radius2,int degstart,int degend){
float x,y,z;
pushMatrix();
pushMatrix();
beginShape(TRIANGLE_STRIP);
for(int deg =degstart; deg <= degend; deg = deg + 60){
x = cos(radians(deg)) * radius1;
y = -length/2;
z = sin(radians(deg)) * radius1;
vertex(x,y,z);
x = cos(radians(deg)) * radius2;
y = length / 2;
z = sin(radians(deg)) * radius2;
 vertex(x,y,z);
}
endShape();
popMatrix();
hexcover(0,length/2,0,radius1,degstart,degend);
hexcover(0,-length/2,0,radius2,degstart,degend);
popMatrix();
}

void tricover(float x,float y,float z,float radius1,int degstart,int degend){
	beginShape(TRIANGLE_FAN);

	vertex(x, y, z);//面の中心点
	for(int deg = degstart; deg <= 180; deg = deg + 1){
	x = cos(radians(deg)) * radius1;
	z = sin(radians(deg)) * radius1;
	vertex(x, y, z);//円周上の点
	}

	for(int deg=260;deg<=280;deg+=1){
	x = cos(radians(deg)) * radius1*1.5;
	z = sin(radians(deg)) * radius1*1.5;
	vertex(x, y, z);
	}

	x = cos(radians(degend)) * radius1;
	z = sin(radians(degend)) * radius1;
	vertex(x, y, z);



	endShape();
}

void triangle(float length,float radius1,float radius2,int degstart,int degend){
float x,y,z;
pushMatrix();
pushMatrix();
beginShape(TRIANGLE_STRIP);
for(int deg =degstart; deg <= 180; deg = deg + 5){
x = cos(radians(deg)) * radius1;
y = -length/2;
z = sin(radians(deg)) * radius1;
vertex(x,y,z);
x = cos(radians(deg)) * radius2;
y = length / 2;
z = sin(radians(deg)) * radius2;
 vertex(x,y,z);
}

for(int deg=260;deg<=280;deg+=1){
x = cos(radians(deg)) * radius1*1.5;
y = -length/2;
z = sin(radians(deg)) * radius1*1.5;
vertex(x,y,z);
x = cos(radians(deg)) * radius2*1.5;
y = length / 2;
z = sin(radians(deg)) * radius2*1.5;
 vertex(x,y,z);
}

x = cos(radians(degend)) * radius1;
y = -length/2;
z = sin(radians(degend)) * radius1;
vertex(x,y,z);
x = cos(radians(degend)) * radius2;
y = length / 2;
z = sin(radians(degend)) * radius2;
 vertex(x,y,z);

endShape();
popMatrix();
tricover(0,length/2,0,radius1,degstart,degend);
tricover(0,-length/2,0,radius2,degstart,degend);
popMatrix();
}

}
