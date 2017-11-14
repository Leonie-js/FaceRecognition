import cc.arduino.*;

// Initialize variables 
Arduino arduino;
PImage img;
int distanceSensorPin = 1;
int distanceSensorValue;


void beginStartState() {
  
  img = loadImage("logo.png");
  
  // initialize arduino
  connectArduino();
  setupArduinoDigitalPins();
}


void doStepWhileInStartState() {
  
  // try to have arduino always connected
  tryReConnectIfDisconnected();
  
  if(arduino !=null) {
    // read Arduino inputs and store it in a variable
    // distance sensor which was in the front of the installation to see if people where standing in front of the installation
    distanceSensorValue = arduino.analogRead(1);
    
    println("sensor: "+ distanceSensorValue);   
  }
  
  changeToStateIf123IsPressed();

  // change state when person is standing close by
  if(distanceSensorValue > 150){
      currentState= MOVIE_STATE;
  }
  
  changeToStateIf123IsPressed();

  // layout 
  background(199,217,195);
  textSize( 32 );
  fill(0);
  textAlign(CENTER);
  text( "Welkom bij de (H)echt smoothiekiezer!!", width/2,  height/10 );   
  imageMode(CENTER);
  image(img, width/2, (height/4)*2.1, width/2, height/1.2);
}

void setupArduinoDigitalPins() {
  
  // set inputs and outputs like the default sensor/actuator shield 
  arduino.pinMode( 2, Arduino.INPUT ); // button 
  arduino.pinMode( 3, Arduino.INPUT ); // button 
  arduino.pinMode( 4, Arduino.SERVO);  // servo
  arduino.pinMode( 7, Arduino.SERVO);  // servo
  arduino.pinMode( 8, Arduino.SERVO);  // servo
  arduino.pinMode( 5, Arduino.OUTPUT );  // output (PWM)
  arduino.pinMode( 6, Arduino.OUTPUT );  // output (PWM)
  arduino.pinMode( 9, Arduino.OUTPUT );  // output (PWM)
  arduino.pinMode( 10, Arduino.OUTPUT ); // output (PWM)
  arduino.pinMode( 11, Arduino.OUTPUT ); // output (PWM)
  arduino.pinMode( 12, Arduino.OUTPUT ); // output
  arduino.pinMode( 13, Arduino.OUTPUT ); // output 
}

void tryReConnectIfDisconnected() {
  
  // in case you remove the Arduino, it will be re-connected 
  try {
      if(connectArduino()) setupArduinoDigitalPins();  
  }
  catch( Exception exception ) {
      println( "Exception :'"  + exception + "'" );
  }
  catch( Error error ) {
      println( "Exception :'"  + error + "'" );
  }
}

float applySmoothening(float oldValue, float newValue, float factor) {
  return factor * oldValue + ( 1 - factor ) * newValue;
}

void endStartState() {
}