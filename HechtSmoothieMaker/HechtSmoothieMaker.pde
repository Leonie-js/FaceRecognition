import processing.serial.*;

import processing.video.*;
import java.awt.GraphicsEnvironment;
import java.awt.GraphicsDevice;
import java.awt.HeadlessException;
import processing.net.*;

// initialize variables 
// all state are constants to prevent programming errors 
final String START_STATE = "Start State";
final String MOVIE_STATE = "Movie State";
final String NODDING_STATE = "Nodding State";
final String ACTIVE_STATE = "Active State";
final String FORM_STATE = "Form State";
final String END_STATE = "End state";

long stateStartTime = 0;
Movie movie;
Server myServer;
String  currentState = START_STATE;
String previousState = "";

void setup(){
  
  fullScreen(P3D,1);
  
  SetupFaces();
  
  // layout
  //BACKGROUND
  background(255,255,255);  
  // UPSIDE
  fill(199,217,195);
  rect(0,0,width,height/5);  
  //DOWNSIDE
  rect(0,(height/5)*4,width,height/5);
  
  //setup database to store data
  msql = new MySQL( this, "database domain", database, user, pass );
}

void draw(){
  
  // check if the currentState was changed so we can end the (now) previousState and start the currentState
  if ( currentState != previousState ) {
    
    println( "end of " + previousState );
        
    if ( previousState == START_STATE ) { 
        endStartState();   
    }
    else if ( previousState == NODDING_STATE ) { 
        endNoddingState(); 
    }
    else if ( previousState == ACTIVE_STATE ) {
        endActiveState();     
    }  
    else if ( previousState == FORM_STATE ) { 
        endFormState();    
    }   
    else if ( previousState == END_STATE ) {
        endEndState();
    }
    else if (previousState == MOVIE_STATE ) {
        endMovieState();
    }
            
    println( "beginning " + currentState );
        
    if ( currentState == START_STATE ) { 
        beginStartState();    
    }
    else if ( currentState == NODDING_STATE ) { 
        beginNoddingState(); 
    }
    else if ( currentState == ACTIVE_STATE ) { 
        beginActiveState();     
    }   
    else if ( currentState == FORM_STATE ) { 
        beginFormState();     
    }     
    else if ( currentState == END_STATE ) { 
        beginEndState();
    }
    else if ( currentState == MOVIE_STATE ) { 
        beginMovieState();
    }
        
    stateStartTime = millis(); 
        
    // save currentState as previousState to see if state changes
    previousState = currentState;
  }
   
  // handle the current state, do a singe step each draw
  if ( currentState == START_STATE ) { 
      doStepWhileInStartState();    
  }
  else if ( currentState == NODDING_STATE ) { 
      doStepWhileInNoddingState(); 
  }
  else if ( currentState == ACTIVE_STATE ) { 
      doStepWhileInActiveState();     
  }  
  else if ( currentState == FORM_STATE ) { 
      doStepWhileInFormState();     
  } 
  else if ( currentState == END_STATE ) { 
      doStepWhileInEndState();
  }
  else if ( currentState == MOVIE_STATE ) { 
      doStepWhileInMovieState();
  }   
}

// function for developer to quickly change between states
void changeToStateIf123IsPressed() {
  
  if ( keyPressed ) {
    if ( key == '1' ) {
        currentState = START_STATE; 
    }
  }
}