import processing.video.*;

// Initialize variables
Movie Anim;
int movieTimer;
int movieStartTimer;
int moviescreenTimer;

void beginEndState(){
  
  // initialize movie
  Anim = new Movie(this, "animatie.mp4");
  Anim.play();
  
  // layout of movie
  imageMode(CORNER);
  image(Anim, 0, 0);
  
  movieStartTimer = millis()/1000;        
}

void doStepWhileInEndState(){
  changeToStateIf123IsPressed();
  
  // if movie is available
  if (Anim.available()) {
    Anim.read();
  }
   
  // show movie 
  image(Anim, 0,0);
  
  // count the time the movie has passed
  movieTimer = (millis()/1000) - movieStartTimer;
  
  if (Anim.time() > 44){
    
    // layout
    noStroke();
    //BACKGROUND
    background(255,255,255);  
    // UPSIDE
    fill(199,217,195);
    rect(0,0,width,height/7);
    image(img2, width/20, height/160, width/10, height/5);  
    //DOWNSIDE
    rect(0,(height/5)*4,width,height/5);      
    textSize( 50 );
    fill(0);
    textAlign(CENTER);
    text( "Je kunt nu de tour beginnen.", width/2,  height/3 );
    text("Je vindt de tour op: www.hechtsmoothies.nl", width/2 ,height/1.5);
    
    // show time to when to go back to start state
    moviescreenTimer = 61 - movieTimer;    
    text("Tijd tot restart: " + moviescreenTimer, (width/4)*3,(height/40)*37);
    
    // when time is up
    if (movieTimer>=61){
      
      // go to start state again
      currentState = START_STATE;
    }      
  }
}

void endEndState(){
  
  // stop movie
  Anim.stop();
}