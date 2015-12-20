import peasy.*;

/*how to peasyCam.
 left-drag to rotate
 mouse wheel, or right-drag up and down to zoom
 middle-drag (cmd-left-drag on mac) to pan
 double-click to reset
 */

PeasyCam cam;
ParticleSystem ps, inps;
ParticleSystem []exps=new ParticleSystem[2];

Cylinder []c=new Cylinder[4];
Piston []p=new Piston[4];
ConnectingRod []rod=new ConnectingRod[4];
Crankshaft []cs=new Crankshaft[4];
Sparkplug []spark=new Sparkplug[4];
Valve []invalv=new Valve[4];
Valve []exvalv=new Valve[4];
Camshaft intakeCams, exhaustCams;
CharacterAnimation sfont, sfont1;
CharacterAnimation []cycle=new CharacterAnimation[4];
CharacterAnimation []onlyfont=new CharacterAnimation[7];
Billboard []b=new Billboard[3];
Billboard []b1=new Billboard[4];
Belt belt;
Effect []effect=new Effect[5];
PFont font;
boolean pressEnter=false;
boolean pressC=false;
float rpm;
int arrow_angle = 20;
int arrow_headlen = 20;
float []swing=new float[4];
float []intakeValvSwing=new float[4];
float []exhaustValvSwing=new float[4];
float []intakeSpringSwing=new float[4];
float []exhaustSpringSwing=new float[4];
float []th= {
  0, 180, 180, 0
};//180度型クランクシャフトエンジン
float camth=0;
//float []th={0,90,270,0};//クロスプレーン型クランクシャフトエンジン
float cmotion=25;
float[] x= {
  0, 0, 0, 0
};
int s=0;
int t=0;
float radius=20;
int []strokeCount= {
  1, 4, 2, 3
};
int len=0;
float thetaSpeed=6.0;
PImage img1, img2, img3;
//final boolean IS_FULLSCREEN = true;

void setup() {
/*
  if (IS_FULLSCREEN) {
    size(displayWidth, displayHeight, P3D);
  } else {
    size(1000, 800, P3D);
  }
  */
  size(1000,800,P3D);

//  frameRate(30);
//  noSmooth();
  font = createFont("MS-Gothic", 24);

  //カメラの設定
  cam = new PeasyCam(this, width/2, height/2, 0, 400); 
  cam.setMinimumDistance(50); // カメラの最小距離定義
  cam.setMaximumDistance(1000); // カメラの最大距離定義

  //テクスチャの読み込み、テクスチャの位置
  PImage img = loadImage("f.png");
  img1 = loadImage("particle.png");
  img2 = loadImage("sprite.png");
  img3=loadImage("spark.png");
  img.resize(img.width/2, img.height/2);
  img1.resize(img1.width/2, img1.height/2);
  img2.resize(img2.width/2, img2.height/2);
  img3.resize(img3.width/5, img3.width/5);
  ps = new ParticleSystem(0, new PVector(0, -30), img);
  inps = new ParticleSystem(0, new PVector(15, -25), img1);
  exps[0] = new ParticleSystem(0, new PVector(0, 0), img2);
  exps[1] = new ParticleSystem(0, new PVector(0, -20), img3);



  //初期化
  int z=0;
  for (int i=0; i<c.length; i++) {
    c[i]=new Cylinder(0, 0, z);
    p[i]=new Piston(0, 0, z);
    rod[i]=new ConnectingRod(0, 0, z);
    cs[i]=new Crankshaft(0, 130, z);
    spark[i]=new Sparkplug(0, 5, z);
    invalv[i]=new Valve(0, 5, z);
    exvalv[i]=new Valve(0, 5, z);
    effect[i]=new Effect(0, 21, z);
    cycle[i]=new CharacterAnimation(120, 70, 0);
    b1[i]=new Billboard(40, 10, z);
    z-=50;
  }
  effect[4]=new Effect(0, 0, 0);
  intakeCams=new Camshaft(-28, -19, -100);
  exhaustCams=new Camshaft(28, -19, -100);
  belt=new Belt(0, 130, 60);
  sfont=new CharacterAnimation(0, 0, 0);
  sfont1=new CharacterAnimation(0, 0, 0);
  for (int i=0; i<6; i++) {
    onlyfont[i]=new CharacterAnimation(360, -150+(10*i), -100);
  }
  onlyfont[6]=new CharacterAnimation(-330, -125, -100);
  b[0]=new Billboard(40, 0, 3);
  b[1]=new Billboard(-40, 0, 3);
  b[2]=new Billboard(0, 0, 0);


 // hint(ENABLE_DEPTH_SORT); //processing2のみ
  //hint(DISABLE_DEPTH_MASK);
}

void draw() {
  background(0);
  //smooth();
  fill(255, 0, 0, 255);

  translate(width/2, height/2, 0);


  camth+=3.0;
  //バルブの開閉処理等
  for (int i=0; i<swing.length; i++) {
    th[i]+=thetaSpeed;
    if (th[i]>=720)th[i]=0;
    swing[i]=cmotion*sin(radians(th[i]));
    intakeValvSwing[i]=3*sin(radians(th[i]));
    exhaustValvSwing[i]=3*sin(radians(th[i]+180));
    intakeSpringSwing[i]=0.02*sin(radians(th[i]+180))+0.04;
    exhaustSpringSwing[i]=0.02*sin(radians(th[i]))+0.04;

    if (th[i]%180==0) {
      strokeCount[i]++;
      if (strokeCount[i]==5)strokeCount[i]=1;
    }
  }




  //カメラの回転
  rotateX(-.5); // X軸 回転する
  rotateY(-.5); // Y軸 回転する




  //エフェクト
  if (pressEnter) {
    drawAxis(500);
    ground(1000);
    onlyfont[0].drawOnlyShuffleFont("TDC:top dead center -上死点-");
    onlyfont[1].drawOnlyShuffleFont("BDC:bottom dead center -下死点-");
    fill(0, 0, 255);
    onlyfont[2].drawOnlyShuffleFont("→(blue)     ：intake");
    fill(255, 128, 0);
    onlyfont[3].drawOnlyShuffleFont("→(orange) ：compression");
    fill(255, 0, 0);
    onlyfont[4].drawOnlyShuffleFont("→(red)      ：ignition&burn");
    fill(255, 255, 255);
    onlyfont[5].drawOnlyShuffleFont("→(white)    ：exhaust");
    textFont(font, 24);
    onlyfont[6].drawOnlyShuffleFont("Inline-four DOHC engine");
    if (strokeCount[0]==1) {
      cycle[0].drawOnlyShuffleFont("Intake -吸入-");
    } else if (strokeCount[0]==2) {
      cycle[1].drawOnlyShuffleFont("Compression -圧縮-");
    } else if (strokeCount[0]==3) {
      cycle[2].drawOnlyShuffleFont("Power -燃焼-");
      cycle[3].reset();
    } else if (strokeCount[0]==4) {
      cycle[3].drawOnlyShuffleFont("Exhaust -排気-");
      for (int i=0; i<cycle.length-1; i++)cycle[i].reset();
    }


    stroke(0);
    for (int k=0; k<4; k++) {
      if (k==0)textFont(font, 48);
      else textFont(font, 24);
      fill(0, 255, 255);
      text(strokeCount[k], 80, 140, -50*k);
    }

    text(int(frameRate)+"fps", -330, -220, -100);
    text(int((thetaSpeed*frameRate)/6)+"rpm", -330, -200, -100);
  }







  noStroke();
//光源の設定
  ambientLight(20, 20, 20);//環境光を当てる
  lightSpecular(255, 255, 255);//光の鏡面反射色を設定
  directionalLight(102, 102, 102, 0, 1, -1);//指向性ライトを設定
  specular(255, 255, 255);
  shininess(5.0);//光沢


  for (int i=0; i<c.length; i++) {
    x[i]=cmotion*cos(radians(th[i]));
    fill(120, 120, 120, 255);

    c[i].drawCylinder();
    p[i].drawPiston(swing[i]);
    rod[i].drawRod(x[i], swing[i], 70);
    cs[i].drawCrankshaft(th[i]);
    spark[i].drawSparkplug();

    if (strokeCount[i]!=1) {
      invalv[i].drawIntakeValve(-2, 0.06);
    } else {
      invalv[i].drawIntakeValve(intakeValvSwing[i], intakeSpringSwing[i]);
    }
    if (strokeCount[i]!=4) {
      exvalv[i].drawExhaustValve(-2, 0.06);
    } else {
      exvalv[i].drawExhaustValve(exhaustValvSwing[i], exhaustSpringSwing[i]);
    }
  }


  cs[0].createCrankpulley(th[0]);
  intakeCams.drawCamshaft(camth);
  exhaustCams.drawCamshaft(camth+180);
  belt.drawBelt();


  //--------------effect-----------------------------------
  if (pressEnter) {
    effect[0].effectSinwave();
    effect[1].drawpVdiagram();
    effect[2].textbox1(350, -350, -100, 250, 150);
    effect[3].textbox1(-350, -300, -100, 300, 100);
  }


  //--------------------------------------------------------



  //-------------空気の吸入、燃焼のエフェクト --------------------------
  b[2].startBillboard();
  rotateX(radians(180));

  float dx = map(mouseX, 0, width, 0.0, 0.0);
  float dy = map(width-50, 0, width, 0.2, 0.0);
  float dz = map(mouseX, 0, width, 0.0, 0.0);

  PVector wind = new PVector(dx, 0);
  PVector inwind = new PVector(dy, 0);
  PVector exwind = new PVector(dz, 0);


  exps[1].applyForce(exwind);
  exps[1].run();


  ps.applyForce(wind);
  inps.applyForce(inwind);

  ps.run();
  inps.run();

  if (strokeCount[0]==1) {
    inps.addParticle();
  } else if (th[0]>=348&&th[0]<366) {
    exps[1].addParticle();
  } else if (th[0]>378&&th[0]<540) {
    for (int k = 0; k < 2; k++) {
      ps.addParticle();
    }
  }









  b[2].endBillboard();
  //---------------------------------------------------------




  //--------------排気ガスのエフェクト------------------------------
  b1[0].startBillboard();
  rotateZ(radians(90));
  exps[0].applyForce(exwind);
  exps[0].run();
  if (strokeCount[0]==4) {
    exps[0].addParticle();
  }
  b1[0].endBillboard();

  /*	
   	for(int i=3;i>=0;i--){
   		b1[i].startBillboard();
   		rotateZ(radians(90));
   		exps[i].applyForce(exwind);
   		exps[i].run();
   		if(strokeCount[i]==4){
   			exps[i].addParticle();
   		}
   		b1[i].endBillboard();
   	}
   */


  //-------------------------------------------------------------








  for (int i=0; i<c.length; i++) {
    noStroke();
    if (strokeCount[i]<=2) {
      effect[i].drawIntakeAir(swing[i]);
    } else {
      effect[i].drawExhaustAir(swing[i]);
    }
  }

//ビルボーディングを用いたテキスト処理
  if (pressEnter) {
    textFont(font, 16);
    b[0].startBillboard();
    sfont.drawShuffleFont("Exhaust manifold", 100, -100, 0, 0, 0, 0);
    b[0].endBillboard();

    b[1].startBillboard();
    sfont1.drawShuffleFont("Intake manifold", -100, -100, 0, 0, 0, 0);
    b[1].endBillboard();
  }
}


void keyPressed() {

  if (keyCode==ENTER) {
    if (pressEnter)pressEnter=false;
    else pressEnter=true;
    for (int i=0; i<effect.length; i++) {
      effect[i].reset();
    }
    for (int i=0; i<onlyfont.length; i++) {
      onlyfont[i].reset();
    }
    sfont.reset();
    sfont1.reset();
  }




  if (key==' ') {
    frameRate(5);


    if (strokeCount[0]==3) {
      effect[4].textbox1(-300, 30, 10, 200, 100);
      textSize(12);
      text("Ignition coil→spark plug", -300, 50, 10);
      text("1次コイル(自己誘導):12V→300V", -300, 70, 10);
      text("2次コイル(相互誘導):300V→30,000V", -300, 90, 10);
      stroke(255, 0, 0);
      line(-100, 30, 10, 0, -10, 0);
    } else if (strokeCount[0]==1) {
      effect[4].textbox1(-300, 30, 10, 200, 100);
      textSize(12);
      text("空燃比", -300, 50, 10);
      text("空気:燃料=14.7:1", -300, 70, 10);

      stroke(255, 0, 0);
      line(-100, 30, 10, -20, 30, 0);
    }
  }
}

void keyReleased() {
  if (key==' ') {
    frameRate(120);
    effect[4].reset();
  }
}



//------------------------------------------------------------------------------------------
//線を描写する関数
void line(int x1, int y1, int z1, int x2, int y2, int z2) {
  beginShape(LINES);
  vertex(x1, y1, z1);
  vertex(x2, y2, z2);
  endShape();
}
//3軸を描写する関数
void drawAxis(float length) {
  stroke(255, 0, 0);
  line(-length, 0, 0, length, 0, 0);
  fill(0, 0, 0);
  //text("x",length,10,0);
  stroke(0, 255, 0);
  line(0, -length, 0, 0, length, 0);
  //text("y",10,length,0);
  stroke(0, 0, 255);
  line(0, 0, -length, 0, 0, length);
  //text("z",10,0,length);
}
//地面を描写する関数
void ground(float length) {
  pushMatrix();
  translate(0, 500, 0);
  stroke(0, 255, 255);
  for (int i=-10; i<=10; i++) {
    line(-length, 0, 100*i, length, 0, 100*i);
    line(100*i, 0, -length, 100*i, 0, length);
  }

  popMatrix();
}