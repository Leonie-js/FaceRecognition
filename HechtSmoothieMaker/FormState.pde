import de.bezier.data.sql.*;

// initialize variables 
MySQL msqlf;
import controlP5.*; 
ControlP5 cp5; 
String textValue = "";
String pvoornaam;
String pachternaam;
String pemail;

void beginFormState() {
  
  // layout
  noStroke();
  //BACKGROUND
  background(255,255,255);  
  // UPSIDE
  fill(199,217,195);
  rect(0,0,width,(height/5));
  image(img2, width/20, height/160, width/10, height/5);  
  //DOWNSIDE
  rect(0,(height/5)*4,width,height/5);
  
  // add form
  cp5 = new ControlP5(this);
  ControlFont cf1 = new ControlFont(createFont("Arial",40));
  
  cp5.setColorForeground(0x00000000);
  cp5.setColorBackground(0xffffffff);
  cp5.setColorActive(0xcccccccc);
  
  cp5.addTextfield("pvoornaam")
    .setPosition(width/2, (height/7)*1.5)
      .setSize(width/3, height/7)
      .setColor(0)
      .setFont(cf1); 
 
  cp5.addTextfield("pachternaam")
    .setPosition(width/2, (height/7)*3)
      .setSize(width/3, height/7)
      .setColor(0)
      .setFont(cf1);               
 
  cp5.addTextfield("pemail")
    .setPosition(width/2, (height/7)*4.5)
      .setSize(width/3, height/7)
      .setColor(0)
      .setFont(cf1)
      .getCaptionLabel().hide();
 
  cp5.addBang("Submit")
    .setPosition(width/2, (height/7)*6)
      .setSize(width/3, height/10)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
        .setColor(255)
      .setFont(cf1);
  
  // layout
  noStroke();  
  fill(0);
  textSize(50);
  text("Voornaam:", width/8, (height/7)*2.2);
  text("Achternaam:", width/8,(height/7)*3.7);
  text("Email:", width/8, (height/7)*5.2); 
}

void doStepWhileInFormState() {
  
  changeToStateIf123IsPressed();
}

// when submit is clicked
void Submit() {
  
  // get variables
  pvoornaam = cp5.get(Textfield.class,"pvoornaam").getText();
  pachternaam = cp5.get(Textfield.class,"pachternaam").getText();
  pemail = cp5.get(Textfield.class,"pemail").getText();
  
  // send data to database
  msql.query("INSERT INTO smoothiepeople (smoothie, voornaam, achternaam, email) VALUES ('%s', '%s', '%s', '%s')", psmoothie, pvoornaam, pachternaam, pemail);
  
  // go to next state
  currentState = END_STATE;
}

void endFormState() {
  
  // delete form
  cp5.remove("pvoornaam");
  cp5.remove("pachternaam");
  cp5.remove("pemail");
  cp5.remove("Submit");
} 