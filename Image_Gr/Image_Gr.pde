//inspired by this video https://www.youtube.com/watch?v=ZzNO3FvkTJM&t=57s
float drag = 0.3;//speed *= drag
int n = 1000;
float noiseS = 1000;
PImage img;
ArrayList<Agent> agents = new ArrayList<Agent>();
float zoff = 0;
float offx = (width-height)/2;//image x offset 

void setup(){
  //size(500, 500);
  fullScreen();
  offx = (width-height)/2;
  img = loadImage("taeyeon.jpg");
  img.filter(BLUR, 3);
  for(int i=0; i<n; i++){
    agents.add(new Agent());
  }
  noStroke();
}

void keyPressed(){
  if(key=='r'){
    background(255);
    for(Agent agent : agents){
      agent.reset();
    }
  }
}

void draw(){
  if(mousePressed)fill(255, 0);
  else fill(255, 5);
  rect(0, 0, width, height);
  //background(0);
  fill(0);
  //image(img, 0, 0, width, height);
  for(Agent agent : agents){
    agent.update();
    agent.show();
  }
  zoff += 0.001;
}

PVector gradientAtPos(PVector pos){
  float x = brightness(img.pixels[int(pos.y)*img.width+int(pos.x+1)]) - brightness(img.pixels[int(pos.y)*img.width+int(pos.x-1)]);
  float y = brightness(img.pixels[int(pos.y+1)*img.width+int(pos.x)]) - brightness(img.pixels[int(pos.y-1)*img.width+int(pos.x)]);
  return new PVector(x, y);
}

class Agent{
  PVector pos;
  PVector initPos;
  PVector vel;
  
  Agent(){
    reset();
  }
  
  void update(){
    float angle = noise(pos.x/noiseS, pos.y/noiseS, zoff)*TWO_PI*4;
    //pos.add(PVector.fromAngle(angle).mult(0.5));
    pos.add(0, -1);
    PVector pd = new PVector((int)map(pos.x-offx, 0, height, 0, img.width), (int)map(pos.y, 0, height, 0, img.height));//project into image
    PVector grad = new PVector();
    if(pd.x <= 0 || pd.x >= img.width-1 || pd.y <= 0 || pd.y >= img.height-1 || random(1) < 0){
      //reset();
      return;
    }else{
      grad = gradientAtPos(pd).mult(0.05);
      if(PVector.add(grad, new PVector(0, 0.1)).mag() < 0.1){
        //reset();
        return;
      }
    }
    vel.add(grad);
    pos.add(vel);
    //pos.y = lerp(pos.y, initPos.y, 0.1);
    vel.setMag(constrain(vel.mag()*drag, 0, 2));
  }
  
  void show(){
    float r = vel.mag()+1;
    rect(pos.x, pos.y, r, r);
  }
  
  void reset(){
    pos = new PVector(random(offx, width-offx), random(height));//ensure in the image and prevent stop
    initPos = pos.copy();
    vel = PVector.random2D();
  }
}
