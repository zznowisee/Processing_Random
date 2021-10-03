float yoff = 0.0;
float r = 300;
void setup() {
  size(800,800);
  background(255);
}


void draw() {
stroke(255, 20);
//fill(random(255),random(255),random(255),1);

float xoff= 0;
translate(width/2,height/2);
beginShape();
for(int a = 0; a < TWO_PI; a+= 0.1){
  float offset = map(noise(xoff, yoff), 0, 1, 0, 100);
  float currnetR = r + offset;
  float x = cos(a) * currnetR;
  float y = sin(a) * currnetR;
  
  // Set the vertex
  vertex(x, y);
  xoff += 0.5;
}
yoff += 0.8;
endShape(CLOSE);

}


void mousePressed() {
setup();
}
