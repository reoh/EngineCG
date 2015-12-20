//文字をかっこよく表示するエフェクトのためのクラス
class CharacterAnimation{
private PFont f;
private String character="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

int posx,posy,posz;

CharacterAnimation(int _x,int _y,int _z){
	posx=_x;
	posy=_y;
	posz=_z;
	f = createFont("Inpact",40,false);
	textFont(f);

}







void drawShuffleFont(String message,int x,int y,int z,int px,int py, int pz){
	pushMatrix();
	pushMatrix();
	translate(x, y, z);
	shufflefont(message);
	popMatrix();

	createline(x,y+5,z,int(textWidth(message)),px,py,pz);


	popMatrix();
}

int i=0;
boolean flag;

void reset(){
	i=0;

}

void drawOnlyShuffleFont(String message){
	pushMatrix();
	translate(posx, posy, posz);
	//flag=true;

	//if(flag){

		shufflefont(message);
	//}
	popMatrix();
}





void shufflefont(String message) {





	fill(0,255,255);

	text(message.substring(0,i),0,posy);
	if(i<message.length()){
		text(character.charAt(int(random(0, character.length()))),textWidth(message.substring(0,i)),posy);

		i++;

	}

	if(i==message.length()){
		message=null;
	}





}




void createline(int x,int y,int z,int length,int px,int py,int pz){
	stroke(0,255,255);
	line(x,y,z,x+length,y,z);
	line(x,y,z,px,py,pz);
}

}
