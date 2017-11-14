// Initialize variables 
int go;
int timer;
int timerscreen;
int starttime;

void beginMovieState(){
 
  // set starttime
  starttime = millis()/1000; 
}

void doStepWhileInMovieState(){
  
    changeToStateIf123IsPressed();
    
    timer = (millis()/1000) - starttime;
    
    // layout
    background(199,217,195);
    textSize( 30 );
    fill(0);
    textAlign(CENTER);
    String uitleg = " Straks begint de vragen test. Je kunt ja en nee zeggen door met je hoofd te knikken. Je kan dit licht overdreven doen. Het kan zijn dat het even duurt voordat de camera de beweging ziet. Knik dan dus rustig door. Er is geen goed of fout antwoord. Als een antwoord is geregisteerd krijg hij een kleur. Wees dan stil en na 5 seconden wordt het antwoord doorgegeven.";
    text( uitleg , 20, height/5, width-70,(height/5)*3);
    text("Druk op een toets op het toetsenbord om verder te gaan.", width/2 ,height/1.5);
    
    // show timer
    timerscreen = 10 - timer;
    text("Tijd om te verder te gaan: " + timerscreen, (width/4)*3,(height/40)*37);
    
    // when a key is pressed
    if (keyPressed){
     // go to next state
     currentState = NODDING_STATE; 
    }
    
    // when nothing happened after 10 seconds
    if (timer > 10){
      // go back to start state
      currentState = START_STATE;
    }  
}

void endMovieState(){
}