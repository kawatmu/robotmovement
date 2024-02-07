import processing .opengl.*;
MouseCamera mouseCamera;
void setup() {
  size(1200,1200,P3D);
  lights();
  mouseCamera = new MouseCamera(800.0, 0, 0, (height/2.0)/tan(PI*30.0/180.0), 0, 0, 0, 0, 1, 0); // MouseCameraの生成
  draw();
}

int gain = 15;
float θ1 = 0;
float θ2 = 0;
float θ3 = 0;
float θ1m = 0;
float θ2m = 0;
float θ3m = 0;
float θ4 = 0;
float θ5 = 0;
float x1 = -399;
float y1 = 200;
float z1 = 399;
float c3 = 0;
float s3 = 0;
float aA = 0;
float aM = 0;
float aB = 0;
float aN = 0;
int power = 1;
int time = 0;
int pattern1 = 0;
int pattern2 = 0;

void keyPressed() {  //矢印キーでx,y変化
  //if (sqrt(x1*x1 + y1*y1 + (z1-400)*(z1-400)) < 800){
  if (pattern1 == 1){
    if (key == CODED) {
    if (keyCode == RIGHT) {
           x1 += gain;
    } else if (keyCode == LEFT) {
           x1 -= gain;
    }else if (keyCode == UP) {
           y1 += gain;
    }else if (keyCode == DOWN) {
           y1 -= gain;
    }
  }
  else if (key == 'w'){
           z1 += gain;
  }else if (key == 's'){
           z1 -= gain;
  }else if (key == 'e'){
           θ4 += gain;
  }else if (key == 'd'){
           θ4 -= gain;
  }else if (key == 'r'){
           θ5 -= gain;
  }else if (key == 'f'){
           θ5 += gain;
  }else if (key == 'a'){
           pattern1 = 0;
  }else if (key == 'q'){
           pattern1 = 1;
  }}else if (pattern1 == 0){
    if (key == 'a'){
           pattern1 = 0;
  }else if (key == 'q'){
           pattern1 = 1;
  }}
    
  if (key == CODED) {
  if (sqrt(x1*x1 + y1*y1 + (z1-400)*(z1-400)) > 800){
    if (x1 < 0){
      x1 += 15;
    }else if (x1 > 0){
      x1 -= 15;
    }else if (y1 < 0){
      y1 += 15;
    }else if (y1 > 0){
      y1 -= 15;
    }else if (z1 < 0){
      z1 += 15;
    }else if (z1 > 0){
      z1 -= 15;
    }
   }
  }
}

void rolling(){
  if (power == 1){
    while (θ4 != 360){
    θ4 += 5;
    y1 += 1;
    }
  }else if (power == -1){
    while ( θ4 != 0){
    θ4 -= 5;
    y1 =-1;
  }
 }
}
    

void variable (){
    if (pattern1 == 1) {
      pattern2 = 0;
    } else if (pattern1 == 0) {
   if (pattern2 == 0){
     x1 = -399;
     y1 = 200;
     z1 = 399;  
     θ4 = 0;
     θ5 = 0;
     pattern2 = 1;
   }else if(pattern2 ==1){
   }
   if ((x1<400)&&(-400<x1)){
   x1 = power * (-1) * 400 + power * (millis()-time)/5;
   z1 = power * (-1) * 400 + power * (millis()-time)/5+400;
   }else if (x1<=-400){
   power = 1;
   time = millis();
   if ((y1 < 500)&&(θ5 == 45)){
      y1 += 4;
   }else if((y1 == 500) && (θ5 != 0)){
      θ5 -= 3;
    }else if ((y1 > 200)&&(θ5 == 0)){
      //θ4 += 10;
       y1 -= 4;
    }else if (y1 == 200){
      x1 = 399;
    }
   }else if (400<=x1){
   power = -1;
   time = millis();
   if ((y1 < 560)&&(θ5 != 45)){
      θ4 -= 10;
       y1 += 4;
    }else if ((y1 == 560)&&(θ5 != 45)){
      θ5 += 3;
    }else if ((θ5 == 45)&&(y1 >= 400)){
       y1 -= 4;
    }else if (y1 < 400){
      x1 = 399;
    }
   }
  }
  θ1m = atan2(y1,x1);
   c3 = (x1*x1 + y1*y1 +(z1 - 400)*(z1 - 400)-400*400-400*400)/(2*400*400);
  θ3m = atan2(c3,sqrt(1-c3*c3));
   aA = sqrt(x1*x1 + y1*y1);
   aM = 400 + 400*c3;
   aB = z1 - 400;
   s3 = sqrt(1-c3*c3);
   aN = 400*s3;
  θ2m = atan2(aN*aA + aM*aB, aM*aA - aN*aB);
  θ1 = θ1m*45/0.785;
  θ2 = 90-θ2m*45/0.785;
  θ3 = 180 - θ3m*45/0.785-90;
}

void draw() {
    variable();
    //rolling()
    println("θ1","θ2","θ3","x1","y1","z1","power","θ5");
    println(int(θ1),int(θ2),int(θ3),int(x1),int(y1),int(z1),power,θ5);
    mouseCamera.update(); // MouseCameraのアップデート
    background(255);
    translate(0,50,0);
    box(200,100,200);
    translate(0,-250,0);
    rotateY(radians(θ1));
    pillar(400,50,50);
    translate(0,-200,0);
    rotateZ(radians(90));
    rotateY(radians(θ2));
    //sphere(50);
    pillar(50,50,50);
    translate(-200,0,0);
    //pillar(400,50,50);
    box(400,50,100);
    translate(-200,0,0);
    pillar(50,50,50);
    rotateY(radians(θ3));  
    translate(-200,0,0);
    box(400,50,100);
    translate(-200,0,0);
    sphere(50);
    rotateY(radians(90-θ2-θ3));
    rotateZ(radians(90-θ1));
    translate(-75,0,0);
    rotateZ(radians(90));
    //rotateY(radians(θ3));
    rotateY(radians(θ4));
    pillar(150,50,50);
    translate(0,50,42.5);
    rotateZ(radians(-90));
    pillar(25,15,15);
    //θ5 = ((power * (-1) * 400 + power * (millis()-time)/5)+400)/9;
    rotateY(radians(θ5));
    translate(-40,0,0);
    box(80,25,25);
    translate(-50,0,-12.5);
    box(20,25,50);
    translate(50,0,12.5);
    translate(40,0,0);
    rotateY(radians(-θ5));
    translate(0,0,-85);
    pillar(25,15,15);
    rotateY(radians(-θ5));
    translate(-40,0,0);
    box(80,25,25);
    translate(-50,0,12.5);
    box(20,25,50);
}

void torus(float R, float r, int countS, int countT) {
    for (int s=0; s<countS; s++) {
        float theta1 = map(s, 0, countS, 0, 2*PI);
        float theta2 = map(s+1, 0, countS, 0, 2*PI);
        beginShape(TRIANGLE_STRIP);
        // beginShape(QUAD_STRIP);
        for (int t=0; t<=countT; t++) {
            float phi = map(t, 0, countT, 0, 2*PI);
            vertex((R+r*cos(phi))*cos(theta1), (R+r*cos(phi))*sin(theta1), r*sin(phi));
            vertex((R+r*cos(phi))*cos(theta2), (R+r*cos(phi))*sin(theta2), r*sin(phi));
        }
        endShape();
    }
}

float rad = 0;


//円柱の作成
// length 長さ
// radius 上面の半径
// radius 底面の半径

void pillar(float length, float radius1 , float radius2){
float x,y,z; //座標
pushMatrix();

//上面の作成
beginShape(TRIANGLE_FAN);
y = -length / 2;
vertex(0, y, 0);
for(int deg = 0; deg <= 360; deg = deg + 10){
x = cos(radians(deg)) * radius1;
z = sin(radians(deg)) * radius1;
vertex(x, y, z);
}
endShape();

//底面の作成
beginShape(TRIANGLE_FAN);
y = length / 2;
vertex(0, y, 0);
for(int deg = 0; deg <= 360; deg = deg + 10){
x = cos(radians(deg)) * radius2;
z = sin(radians(deg)) * radius2;
vertex(x, y, z);
}
endShape();

//側面の作成
beginShape(TRIANGLE_STRIP);
for(int deg =0; deg <= 360; deg = deg + 5){
x = cos(radians(deg)) * radius1;
y = -length / 2;
z = sin(radians(deg)) * radius1;
vertex(x, y, z);

x = cos(radians(deg)) * radius2;
y = length / 2;
z = sin(radians(deg)) * radius2;
vertex(x, y, z);

}
endShape();

popMatrix();
}

// マウス操作に応じたMouseCameraの関数を呼び出す
void mousePressed() {
    mouseCamera.mousePressed();
}
void mouseDragged() {
    mouseCamera.mouseDragged();
}
void mouseWheel(MouseEvent event) {
    mouseCamera.mouseWheel(event);
}
