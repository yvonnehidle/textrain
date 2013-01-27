//////////////////////////////////////////////////////////////////
// GLOBAL VARIABLES
//////////////////////////////////////////////////////////////////
import processing.video.*;
Capture video;

// string array for poem
String poem = "Fancy lines and dancing swirls have nothing on simplicitys curls";
char[]letters = new char[poem.length()];

// letter positioning
final int max = letters.length;
float[]letterY = new float[max];
//////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// BASIC SETUP
//////////////////////////////////////////////////////////////////
void setup()
{
// general setup
size(640,480);
noStroke();
textSize(20);
fill(255,0,0);
  
// video
video = new Capture(this,640,480,30);
  
// divide poem into individual characters
for(int i=0; i<poem.length(); i++)
{
  letters[i] = poem.charAt(i);
}
}
//////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// TABLE OF CONTENTS
//////////////////////////////////////////////////////////////////
void draw()
{
background(255);

// falling letters
fallingLetters();
}
//////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
// FALLING LETTERS
//////////////////////////////////////////////////////////////////
void fallingLetters()
{
// if a webcam is available, load the video
if(video.available())
{
  video.read();
}
video.filter(GRAY);
image(video, 0, 0);


// variables
float letterS=1;
float letterX=0;
float letterXSpace=width/letters.length;
int darknessThreshold = 180;


// generate the letters and have them interact
// pixel by pixel of the video
video.loadPixels();
for(int i=0; i<letters.length; i++)
{ 
  // what is the pixel number in the array?
  int loc = int( letterX + letterY[i] * video.width );
  
  // draw letters
  text(letters[i],letterX,letterY[i]);
  letterX=letterX+letterXSpace;
  
  // if the letters reach the bottom of the screen, start them at top again
  if(letterY[i] >= video.height - 1)
  {
    letterY[i] = 0;
  }
  
  // if the brightness of the pixel is less than our darkness threshold
  // then do not move the letter
  else if(brightness(video.pixels[loc]) < darknessThreshold)
  {
    if(letterY[i] > 10)
    {
    letterY[i]-=letterS;
    }
  }
  
  // else always move the letter
  else
  {
    letterY[i]+=letterS; 
  }
}

}
//////////////////////////////////////////////////////////////////
