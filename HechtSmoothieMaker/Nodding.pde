import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

// Initialize variables 
Capture video;
OpenCV cv;
OpenCV cvFlip;
Rectangle[] faces;
int cvWidth; 
int cvHeight;
int cvDivider = 4;
PImage detectionImg;
int faceX =0;
int faceXOld =0;
int faceXDif = 0;
int faceXDifSum = 0;
int faceXCntr = 0;
int faceXmin = 1000000000;
int faceXmax = -1000000000;
int minXDif;
int maxXDif;
int faceY =0;
int faceYOld =0;
int faceYDif = 0;
int faceYDifSum = 0;
int faceYCntr;
int faceYmin = 1000000000;
int faceYmax = -1000000000;
int minYDif;
int maxYDif;
int problem;
int treshold = 30;
String[] devices = Capture.list();
String answer = "";

void SetupFaces(){
  
  // 70 webcam
  // startup the camera
  video = new Capture(this, 640 , 480, devices[0]);
  video.start();
  cvFlip = new OpenCV( this, video.width, video.height); 
  cvFlip.useColor();
  
  // make quality of video less so that computer can handle it better
  cvWidth = video.width/cvDivider;
  cvHeight = video.height/cvDivider;
  
  // make a new OpenCv
  cv = new OpenCV(this, cvWidth, cvHeight);
  cv.useColor();
  cv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  
  // make a dot where the face is on the camera
  detectionImg = createImage(cvWidth, cvHeight, RGB);
  
  // detect faces
  faces = cv.detect();
}


void DetectFaceNodding(){
  
  // when there is a camera feed available
  if ( video.available() ) {
    
    // show camera feed and flip it horizontal like a mirror
    video.read();   
    cvFlip.loadImage(video);
    cvFlip.flip(OpenCV.HORIZONTAL); 
    
    // show the dot on the screen
    detectionImg.copy(cvFlip.getOutput(), 0, 0, cvFlip.width, cvFlip.height, 0, 0, cv.width, cv.height);    
    cv.loadImage(detectionImg);
    
    // detect the faces
    faces = cv.detect();
    
    // when there is no faces
    if ( faces.length < 1 ) {
      
      // save the x and y positions
      faceX = faceXOld;
      faceY = faceYOld;
      // have a counter
      time = millis() - startTime;
      
      // when there is no face for 3 sec
      if (time > 3000){
        // reset x and y position
        faceX = 0;
        faceY = 0;
      }
    
    // tell problem to NoddingState 
    problem = 1; 
    
    //when there is only one face
    } else if ( faces.length == 1 ) {
      
      // track the x and y position of the face
      faceX = faces[0].x;
      faceY = faces[0].y;
      
      // layout
      fill(255);
      rect(0,height/5,width,(height/5)*3);    
      fill(199,217,195);
      textSize(60);
      fill(0,0,0);
      text("YES",(width/13)*3.2,(height/5)*2.7);
      text("NO",(width/13)*9.2,(height/5)*2.7);
      
      // start detecting nodding
      DetectNodding();
      
    // when there is more than one face
    } else {
      
      // tell problem to NoddingState
      problem = 2;

    }
  }
}

final int CLOSE = 28;
final int FAR = 55;


void DetectNodding(){
  
  // when face is close enough in front of the camera
  if (faces[0].width > CLOSE && faces[0].width < FAR && faces[0].height > CLOSE && faces[0].height < FAR ){
    
    // save the difference of nodding from left to right
    faceXDif = faceXOld - faceX;
    // save the difference of nodding up and down
    faceYDif = faceYOld - faceY;
    
    // when you nod up and down
    if (faceXDif > faceYDif || (faceXDif < faceYDif && faceYDif < 0)){
      
      // face is going up
      if(faceXDif > 0){
        
        // track the highest position of the face
        if(faceX > faceXmax){
          faceXmax = faceX;
        }
        
        // the total distance the face made moving up
        maxXDif =  faceXmax - faceX;
        
        // if the face went high enough
        if (maxXDif >= 4){
          // count a half way up nod
          faceXCntr++;
          // reset variables
          maxXDif = 0;
          faceXmax = -1000000;
        }
        
        // the total distance the face made moving down
        minXDif = faceXmin - faceX;
        
        // if the face went down enough
        if (minXDif <= -7){
          // count a half way down nod
          faceXCntr++;
          // reset variables
          minXDif = 0;
          faceXmin = 10000000;
        } 
        
      }
      
      // face is going down
      if(faceXDif < 0){ 
        
        // track the lowest position of the face
        if(faceX < faceXmin){
          faceXmin = faceX; 
        }
        
        // the total distance the face made moving down
        minXDif = faceXmin - faceX;
        
        // if the face went down enough
        if (minXDif <= -7){
          // count a half way down nod
          faceXCntr++;
          // reset variables
          minXDif = 0;
          faceXmin = 10000000;
        } 
                        
        // the total distance the face made moving up
        maxXDif =  faceXmax - faceX;
        
        // if the face went high enough
        if (maxXDif >= 4){
          // count a half way up nod
          faceXCntr++;
          // reset variables
          maxXDif = 0;
          faceXmax = -1000000;
        }
      }
      
    // when you nod from left to right  
    }else if (faceYDif > faceXDif || (faceYDif < faceXDif && faceXDif < 0)){
      
      // face is going to the right (on the screen)
      if(faceYDif > 1){
        
        // track the most right position
        if(faceY > faceYmax){
          faceYmax = faceY;
        }
        
        // the total distance the face made moving to the right
        maxYDif =  faceYmax - faceY;
        
        // if the face went enough to the right
        if (maxYDif >= 4){
          // count a half way to right nod
          faceYCntr++;
          // reset variables
          maxYDif = 0;
          faceYmax = -1000000;
        }
        
        // the total distance the face made moving to the left 
        minYDif = faceYmin - faceY;
        
        // if the face went enough to the left
        if (minYDif <= -5){
          // count a half way to left nod
          faceYCntr++;
          // reset variables
          minYDif = 0;
          faceYmin = 10000000;
        } 
      }
      
      // face is going to left (on the screen)
      if(faceYDif < 1){ 
        
        // track the most left position
        if(faceY < faceYmin){
          faceYmin = faceY; 
        }
        
        // the total distance the face made moving to the left 
        minYDif = faceYmin - faceY;
        
        // if the face went enough to the left
        if (minYDif <= -5){
          // count a half way to left nod
          faceYCntr++;
          // reset variables
          minYDif = 0;
          faceYmin = 10000000;
        } 
        
        // the total distance the face made moving to the right
        maxYDif =  faceYmax - faceY;
        
        // if the face went enough to the right
        if (maxYDif >= 4){
          // count a half way to right nod
          faceYCntr++;
          // reset variables
          maxYDif = 0;
          faceYmax = -1000000;
        }
      }
    } 
    
    
    // when there is a whole no nod
    if (faceXCntr >= 3){
      // set answer to no
      answer = "no";   
      // reset variable
      faceXCntr = 0;
      
    // when there is a whole yes nod  
    }else if (faceYCntr >= 3){
      // set answer to yes
      answer = "yes";
      // reset varialbe
      faceYCntr = 0;
    }
    
    // save the positon of the face 
    faceXOld = faceX; 
    faceYOld = faceY;  
   
  // face is too far away
  } else if (faces[0].height < CLOSE && faces[0].width < CLOSE){
   
   // tell problem to NoddingState
   problem = 3;
  
  // face is too close
  } else if (faces[0].height > FAR && faces[0].width > FAR){
   
    // tell problem to NoddingState
    problem = 4;
    
  }
}

void captureEvent(Capture c) {
  c.read();
}