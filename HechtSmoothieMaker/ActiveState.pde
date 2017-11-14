// initialize variables 
String psmoothie;
float random;
int loop;
PImage img2;

void beginActiveState() {
 
    random = (int)random(3);
    println(random);
    img2 = loadImage("logo.png");
}

void doStepWhileInActiveState() {    

    // when enter is pressed go to next state
    if ( key == ENTER ) { 
      currentState = FORM_STATE;
    }
    
    // smoothie is chosen at random
    if(random == 0){
      psmoothie = "pittig";
    } else if (random == 1){
      psmoothie = "zoet";
    } else if (random == 2){
      psmoothie = "krachtig";
    }
     
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
    textSize( 50 );
    fill(0);
    textAlign(CENTER);
    text( "Jouw smoothie is "+ psmoothie, width/2,  height/3 );
    text("Druk op enter om je aan te melden voor de tour", width/2 ,height/1.5);
    noStroke();
    fill( 255, 255, 0 );
    
    changeToStateIf123IsPressed();    
}

void endActiveState() {
}