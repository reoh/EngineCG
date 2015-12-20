//ビルボーディング処理をするためのクラス
class Billboard{
	int posx,posy,posz;
	Billboard(int _x,int _y,int _z){
		posx=_x;
		posy=_y;
		posz=_z;
	}


	void startBillboard(){
		pushMatrix();
		translate(posx, posy, posz);
		billMatrix();


	}

	void endBillboard(){
		popMatrix();
	}

	void billMatrix(){
		PMatrix3D builboardMat = (PMatrix3D)g.getMatrix();
 		 // 回転成分を単位行列に
  		builboardMat.m00 = builboardMat.m11 = builboardMat.m22 = 1;
  		builboardMat.m01 = builboardMat.m02 =builboardMat.m10 =
  		builboardMat.m12 =builboardMat.m20 = builboardMat.m21 = 0;
  		resetMatrix();
  		applyMatrix(builboardMat);

	}









}
