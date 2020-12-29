/**
 * Loop. 
 * 
 * Shows how to load and play a QuickTime movie file.  
 *
 */
 
 
import ddf.minim.analysis.*;
import ddf.minim.*; 

Minim minim;        

AudioPlayer player,player2;
import processing.serial.*;
Serial myPort;  // Create object from Serial class
int val; 
PImage img;
int lf = 10; // 10在ASCII表中表示'\n'
byte[] inBuffer = new byte[300];
int fz=0;
int p=1;
int nowp=1;
int mp3paly=0;
int mubiao=0;
void setup() {
   size(700, 400);
  // fullScreen();
  background(0);
      String portName = Serial.list()[0];          //huo de com lie biao 0-n
   myPort = new Serial(this, "/dev/cu.usbserial-14120", 115200);

minim = new Minim(this);
//player.close();
player = minim.loadFile("1.mp3",2048);
player2=minim.loadFile("2.mp3",2048);  
}

void draw() {
  getBuffer(); 

  //image(loadImage(val+".jpg"), 0,0,width, height);
  if(mubiao>716)mubiao=716;
  if(mubiao<1)mubiao=1;
  if(mubiao>nowp)nowp=nowp+1;
  if(mubiao<nowp)nowp=nowp-1;
  if(nowp<1)nowp=1;
  if(nowp>716)nowp=716;
  if(nowp<191 &&  mp3paly !=1)
  {
     player.loop();
     player2.pause();
      mp3paly=1;
  }
  if(nowp>=191 &&  mp3paly !=2)
  {
     player2.loop();
     player.pause();
      mp3paly=2;
  }
  image(loadImage(nowp+".jpg"), 0,0,width, height); 

}
void getBuffer()  
{
  while (myPort.available() > 0) 
  { 
    if (myPort.readBytesUntil(lf, inBuffer) > 0)
    {
    String inputString = new String(inBuffer);
            
    String [] inputStringArr = split(inputString, ',');    
    
     p= int(inputStringArr[0]);
     
     println(p);
     if(p<400)//0  1-48
       mubiao=48;     
     if(p>400 && p<450)//426.8g  49-96
       mubiao=96;
     if(p>450 && p<490)//61.6g  96-143
       mubiao=143;       
     if(p>490 && p<530)//33g  144-191
       mubiao=191;   
     if(p>530 && p<550)//25.7g  192-211
       mubiao=211;    
       
     if(p>720 && p<740)//184g  212-234
       mubiao=234;  
     if(p>880 && p<920)//171.5g  235-294
       mubiao=294;         
     if(p>960 && p<999)//77.1g  295-351
       mubiao=351;        
     if(p>1030 && p<1070)//69.9g  352-406
       mubiao=406;   
     if(p>1090 && p<1130)//63.3g  407-467
       mubiao=467;          
     if(p>1150 && p<1190)//56.9g  468-587
       mubiao=587;   
     if(p>1190)//40.5g  588-716
       mubiao=716;          
    }
  } 
}
