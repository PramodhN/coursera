PImage [] recordPlayer;
PImage prev,next,swiper;
Maxim maxim;
AudioPlayer[] player;
int p1,p2;
boolean p1play=false;
boolean p2play=false;
float speedAdjust1=1.0;
float speedAdjust2=1.0;
String audio1="dj01.wav";
String audio2="dj02.wav";
float rotate1=0.0;
float rotate2=0.0;
int imgwidth=0;
int pnwidth=0;
float magnify = 50; 
float phase = 0; 
float amp = 0;
float pow1,pow2,avgpower;
int elements = 128; 
float threshold = 0.35;
int wait=0;
int trackNumber1,trackNumber2;
void setup()
{
  size(360,560);
  imageMode(CENTER);
  recordPlayer = loadImages("black-record_", ".png", 36);
  maxim = new Maxim(this);
  player=new AudioPlayer[5];
  player[0]=maxim.loadFile("dj01.wav");
  player[0].setAnalysing(true);
  player[0].setLooping(true);
  player[1]=maxim.loadFile("dj02.wav");
  player[1].setAnalysing(true);
  player[1].setLooping(true);
  player[2]=maxim.loadFile("dj03.wav");
  player[2].setAnalysing(true);
  player[2].setLooping(true);
  player[3]=maxim.loadFile("dj04.wav");
  player[3].setAnalysing(true);
  player[3].setLooping(true);
  player[4]=maxim.loadFile("dj05.wav");
  player[4].setAnalysing(true);
  player[4].setLooping(true);
  p1=0;
  p2=1;
  prev=loadImage("Prev.png");
  next=loadImage("Next.png");
  swiper=loadImage("swiper.png");
  colorMode(HSB);
}
void draw()
{
  rectMode(CENTER);
  background(0);
  fill(100);
  rect(width/2,(3*height)/8,width,height/4);
  pow1=0.0;
  pow2=0.0;
  if(p1play)
  {
    player[p1].speed(speedAdjust1);
    pow1 = player[p1].getAveragePower();
  }
  if(p2play)
  {
    player[p2].speed(speedAdjust2);
    pow2 = player[p2].getAveragePower();
  }
  rectMode(CORNER); 
  image(swiper,width/4,(3*height)/4,width/2,height/2);
  image(swiper,(3*width)/4,(3*height)/4,width/2,height/2);

  imgwidth=(height*recordPlayer[0].width)/(6*recordPlayer[0].height);
  image(recordPlayer[(int)rotate1],width/4,(3*height)/8,imgwidth,height/6);
  image(recordPlayer[(int)rotate2],(3*width)/4,(3*height)/8,imgwidth,height/6);
  pnwidth=(height*prev.width)/(20*prev.height);
  image(prev,width/8,(15*height)/32,pnwidth,height/20);
  image(next,(3*width)/8,(15*height)/32,pnwidth,height/20);
  image(prev,(5*width)/8,(15*height)/32,pnwidth,height/20);
  image(next,(7*width)/8,(15*height)/32,pnwidth,height/20);
  fill(255,255,255);
  if(p1play)
  {
    rect((width/2)-(width/32), 7*height/16, width/32, -pow1*height/2);
    rotate1+=1*speedAdjust1;
    if(rotate1>=recordPlayer.length)
    {
      rotate1=0;
    }
  }
  if(p2play)
  {
    rect((width/2), 7*height/16, width/32, -pow2*height/2);
    rotate2+=1*speedAdjust2;
    if(rotate2>=recordPlayer.length)
    {
      rotate2=0;
    }
  }
  avgpower=(pow1+pow2)/2;
  if(avgpower<0)
  {
    avgpower=0.0;
  }
  if (avgpower > threshold && wait<0) 
  {
    phase+=avgpower*10; 
    wait+=10;
  }
  wait--;
  amp += 0.05;
  float spacing = TWO_PI/(elements);
  translate(width/2, height/8);
  strokeWeight(2);
  for (int i = 0; i < elements;i++) 
  {
    stroke(i*2, 255, 255, 50);
    pushMatrix();
    rotate(spacing*i*phase);
    translate(sin(spacing*amp*i)*magnify, 0);
    rotate(-(spacing*i*phase));
    rotate(i);
    if((i*(avgpower*10)-(height/32)) > height/10)
    {
      line(width/8, height/10, width/8, height/16);      
    }
    else
    {
      line(width/8, i*(avgpower*10)-(height/32), width/8, height/16);
    }
    popMatrix();
    stroke(255, 0, 0);
  } 
  if(avgpower>0.5)
  {
    println(avgpower);
  }

}
void mouseClicked()
{
  if(dist(mouseX, mouseY, width/8, (15*height)/32) < pnwidth/2)
  {
    player[p1].stop();
    p1--;
    if(p1 == -1)
    {
      p1 = 4;
    }
    if(p2 == p2)
    {
      p1--;
    }
    if(p1 == -1)
    {
      p1 = 4;
    }
    player[p1].play();
  }
  if(dist(mouseX, mouseY, (3*width)/8, (15*height)/32) < pnwidth/2)
  {
    player[p1].stop();
    p1++;
    if(p1 == 5)
    {
      p1 = 0;
    }
    if(p1 == p2)
    {
      p1++;
    }
    if(p1 == 5)
    {
      p1 = 0;
    }
    player[p1].play();
  }
  if(dist(mouseX, mouseY, (5*width)/8, (15*height)/32) < pnwidth/2)
  {
    player[p2].stop();
    p2--;
    if(p2 == -1)
    {
      p2 = 4;
    }
    if(p2 == p1)
    {
      p2--;
    }
    if(p2 == -1)
    {
      p2 = 4;
    }
    player[p2].play();
  }
  if(dist(mouseX, mouseY, (7*width)/8, (15*height)/32) < pnwidth/2)
  {
    player[p2].stop();
    p2++;
    if(p2 == 5)
    {
      p2 = 0;
    }
    if(p2 == p1)
    {
      p2++;
    }
    if(p2 == 5)
    {
      p2 = 0;
    }    
    player[p2].play();
  }
  if(dist(mouseX, mouseY, width/4, (3*height)/8) < imgwidth/2)
  {
    p1play=!p1play;
    if(p1play)
    {
      player[p1].play();
    }
    else
    {
      player[p1].stop();
    }
  }
  if(dist(mouseX, mouseY, (3*width)/4, (3*height)/8) < imgwidth/2)
  {
    p2play=!p2play;
    if(p2play)
    {
      player[p2].play();
    }
    else
    {
      player[p2].stop();
    }  
  }  
}
void mouseDragged()
{
   if (mouseX<width/2 && mouseY>height/2)
   {  
     speedAdjust1=map(mouseY,height/2,height,0,2);
   } 
   if (mouseX>width/2 && mouseY>height/2)
   {  
     speedAdjust2=map(mouseY,height/2,height,0,2);
   }
}
