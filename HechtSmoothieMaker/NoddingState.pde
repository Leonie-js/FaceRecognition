import de.bezier.data.sql.*;

// Initialize variables 
MySQL msql;
PImage imgTimer;
int time;
int startTime;
int yes;
int no;
String user = "username";
String pass = "password";
String database = "databasename";
String question;
String oldAnswer;

void beginNoddingState() {
    
  // set answer to nothing
  answer = "";
  changeToStateIf123IsPressed();
    
  // retrieve the questions with the database
  if ( msql.connect() ) {
    msql.query( "SELECT * FROM realquestions");
    msql.next();
    question = msql.getString(1);
  } else {
    // when not able to connect go back to start state
    currentState = START_STATE;
  }
     
  imgTimer = loadImage("timer.png");
    
  // layout
  noStroke();
  //BACKGROUND
  background(255,255,255); 
  // UPSIDE
  fill(199,217,195);
  rect(0,0,width,height/5);
  image(img2, width/20, height/160, width/10, height/5);
  //DOWNSIDE
  rect(0,(height/5)*4,width,height/5);     
  //BOXES
  fill(199,217,195);
  rect(width/13,(height/5)*1.5,(width/13)*5,(height/5)*2);
  rect((width/13)*7,(height/5)*1.5,(width/13)*5,(height/5)*2);
  //TEXT
  textSize(60);
  fill(0,0,0);  
  text("YES",(width/13)*3.2,(height/5)*2.7);
  text("NO",(width/13)*9.2,(height/5)*2.7);
}


void doStepWhileInNoddingState() {
    
  changeToStateIf123IsPressed(); 
  // start function to look for nodding of the head
  DetectFaceNodding();
  
  // layout
  // UPSIDE
  fill(199,217,195);
  rect(0,0,width,height/5);  
  //DOWNSIDE
  rect(0,(height/5)*4,width,height/5);
  //TEXT
  fill(0,0,0);
  textSize( 50 );
  textAlign(CENTER);
  text(question,width/2,(height/10)*1.2);
  
  // when player nods yes
  if (answer == "yes"){
    
    // layout
    noStroke();
    fill(117,165,66);
    rect(width/13,(height/5)*1.5,(width/13)*5,(height/5)*2);
    fill(0,0,0);
    text("YES",(width/13)*3.2,(height/5)*2.7);
    textAlign(LEFT);
    text(time,(width/4)*3,(height/40)*37);
    image(imgTimer, (width/20)*13.5, (height/40)*33, width/16, height/8);
    
    // if answer before was different
    if (oldAnswer == "no"){
      // reset starttime so time starts counting from 0 again
      startTime = second();
    }   
           
    time = second() - startTime;
    
    // if the answer is selected for more than 5 secons      
    if (time > 5){
      // select next question
      msql.next();
      question = msql.getString(1);
      // reset starttime so time starts counting from 0 again
      startTime = second();
      // count how manys times the answer yes is given
      yes++;
    }   
    
    // if there has been more than 5 answers/questions
    if (yes + no >= 5){
      //go to next state
      currentState= ACTIVE_STATE;
    }
    
    // set old answer to yes
    oldAnswer="yes";
    
  } else if ( answer == "no"){
    
    // layout
    noStroke();
    fill(191,58,41);
    rect((width/13)*7,(height/5)*1.5,(width/13)*5,(height/5)*2);
    fill(0,0,0);
    text("NO",(width/13)*9.2,(height/5)*2.7);
    textAlign(LEFT);
    text(time,(width/4)*3,(height/40)*37);
    image(imgTimer, (width/20)*13.5, (height/40)*33, width/16, height/8);
     
    // if answer before was different  
    if (oldAnswer == "yes"){
      // reset starttime so time starts counting from 0 again
      startTime = second();
    }
      
    time = second() - startTime;
      
    if (time > 5){
      // reset starttime so time starts counting from 0 again
      startTime = second();
      // select next question
      msql.next();
      question = msql.getString(1);
      // count how many time answer yes is given
      no++;
    }
    
    // when there has been more than 5 answers / questions 
    if (yes + no >= 5){
      // go to next state
      currentState= ACTIVE_STATE;
    }
    
    // set oldanswer to no
    oldAnswer="no";    
    
  }
  if ( problem == 1){
    // problem 1 camera sees no faces
    
    // layout, show with text the problem
    fill(255);
    rect(0,height/5,width,(height/5)*3);
    fill(0);
    textSize(70);
    textAlign(CENTER);
    text("De camera ziet geen gezichten",width/2,(height/5)*2.7);
    //DOWNSIDE
    fill(199,217,195);
    rect(0,(height/5)*4,width,height/5);
    
    // reset startTime and time so that counting starts again
    startTime = second();
    time = 0;
    
  }else if (problem == 2){
    // problem 2 camera sees to many faces
    
    // layout, show with text the problem
    fill(255);
    rect(0,height/5,width,(height/5)*3);
    fill(0);
    textSize(70);
    textAlign(CENTER);
    text("De camera ziet teveel gezichten",width/2,(height/5)*2.7);
    fill(199,217,195);
    rect(0,(height/5)*4,width,height/5);    
    //DOWNSIDE
     fill(199,217,195);
    rect(0,(height/5)*4,width,height/5);
    
    // reset startTime and time so that counting starts again
    startTime = second();
    time = 0;
    
  }else if (problem == 3){
    // problem 3 face is too far away to recognize nodding
    
    // layout, show with text the problem
    fill(255);
    rect(0,height/5,width,(height/5)*3);
    fill(0);
    textSize(60);
    textAlign(CENTER);
    text("Kom dichter bij de camera, alstublieft",width/2,(height/5)*2.7);   
    //DOWNSIDE
     fill(199,217,195);
    rect(0,(height/5)*4,width,height/5);
    
    // reset startTime and time so that counting starts again
    startTime = second();
    time = 0;
    
  } else if (problem == 4){
    // problem 4 face is too close to recognize nodding
    
    // layout, show with text the problem
    fill(255);
    rect(0,height/5,width,(height/5)*3);
    fill(0);
    textSize(60);
    textAlign(CENTER);
    text("Ga verder weg bij de camera, alstublieft",width/2,(height/5)*2.7);    
    //DOWNSIDE
     fill(199,217,195);
    rect(0,(height/5)*4,width,height/5);
    
    // reset startTime and time so that counting starts again
    startTime = second();
    time = 0;
  }    
}

void endNoddingState() {
    
}