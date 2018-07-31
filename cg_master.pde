import de.voidplus.leapmotion.*;
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;


import org.jbox2d.callbacks.ContactImpulse;
import org.jbox2d.callbacks.ContactListener;
import org.jbox2d.collision.Manifold;

LeapMotion leap;
Box2DProcessing box2d;
ArrayList<Particle> particles;
ArrayList<Boundary> boundaries;
Boundary wall;
Particle p;

float my_timer;
PFont f;//フォント

int state = 0;

void setup() {
  size(1020, 800, P3D);
  smooth();
  noStroke();
  frameRate(60);
  background(255);
  leap = new LeapMotion(this);
  
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.world.setContactListener(new CustomListener());
  
  setup_balls();
  setup_boundary();
  textureMode(IMAGE);  
  
  my_timer = 0.0;
  
  //setup font
  println(PFont.list());
  f = createFont("Georgia", 10);
  textFont(f); 
}


// ======================================================
// 1. Callbacks

void leapOnInit() {
  println("Leap Motion Init");
}
void leapOnConnect() {
  println("Leap Motion Connect");
}
void leapOnFrame() {
  println("Leap Motion Frame");
}
void leapOnDisconnect() {
  println("Leap Motion Disconnect");
}
void leapOnExit() {
  println("Leap Motion Exit");
}


void draw() {
  lights();
  background(255);
  // ...
  if (state == 0)
  {
    background(0);
    fill(255);
    textAlign(CENTER);
    text("Press S key to start!", width/2, height/2);
  } else if (state == 1)//playing
  {


    my_timer = my_timer + 0.01;
    box2d.step();

    //falling balls
    for (int i = particles.size()-1; i >= 0; i--) 
    {
      p = particles.get(i);
      p.display();

    // Particles that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (p.done()) 
    {
       particles.remove(i);      
       particles.add(new Particle(i, 0, 20+random(width - 40), 
          random(-height, 0), 10.0+random(20)));            
    }
  }

  for (Boundary wall: boundaries) {
    wall.display();
  }

    int fps = leap.getFrameRate();
    for (Hand hand : leap.getHands ()) {


      // ==================================================
      // 2. Hand

      int     handId             = hand.getId();
      PVector handPosition       = hand.getPosition();
      PVector handStabilized     = hand.getStabilizedPosition();
      PVector handDirection      = hand.getDirection();
      PVector handDynamics       = hand.getDynamics();
      float   handRoll           = hand.getRoll();
      float   handPitch          = hand.getPitch();
      float   handYaw            = hand.getYaw();
      boolean handIsLeft         = hand.isLeft();
      boolean handIsRight        = hand.isRight();
      float   handGrab           = hand.getGrabStrength();
      float   handPinch          = hand.getPinchStrength();
      float   handTime           = hand.getTimeVisible();
      PVector spherePosition     = hand.getSpherePosition();
      float   sphereRadius       = hand.getSphereRadius();

      // --------------------------------------------------
      // Drawing
      hand.draw();
      //rect red
      rectMode(CENTER);
      strokeWeight(5);
      stroke(150, 0, 0);
      fill(#ff0000);
      rect(width/2, height/2, 50, 100);




      // ==================================================
      // 3. Arm

      if (hand.hasArm()) {
        Arm     arm              = hand.getArm();
        float   armWidth         = arm.getWidth();
        PVector armWristPos      = arm.getWristPosition();
        PVector armElbowPos      = arm.getElbowPosition();
      }


      // ==================================================
      // 4. Finger

      Finger  fingerThumb        = hand.getThumb();
      // or                        hand.getFinger("thumb");
      // or                        hand.getFinger(0);

      Finger  fingerIndex        = hand.getIndexFinger();
      // or                        hand.getFinger("index");
      // or                        hand.getFinger(1);

      Finger  fingerMiddle       = hand.getMiddleFinger();
      // or                        hand.getFinger("middle");
      // or                        hand.getFinger(2);

      Finger  fingerRing         = hand.getRingFinger();
      // or                        hand.getFinger("ring");
      // or                        hand.getFinger(3);

      Finger  fingerPink         = hand.getPinkyFinger();
      // or                        hand.getFinger("pinky");
      // or                        hand.getFinger(4);


      for (Finger finger : hand.getFingers ()) {
        // or              hand.getOutstretchedFingers();
        // or              hand.getOutstretchedFingersByAngle();

        int     fingerId         = finger.getId();
        PVector fingerPosition   = finger.getPosition();
        PVector fingerStabilized = finger.getStabilizedPosition();
        PVector fingerVelocity   = finger.getVelocity();
        PVector fingerDirection  = finger.getDirection();
        float   fingerTime       = finger.getTimeVisible();

        // ------------------------------------------------
        // Drawing

        // Drawing:
        // finger.draw();  // Executes drawBones() and drawJoints()
        // finger.drawBones();
        //finger.drawJoints();

        // ------------------------------------------------
        // Selection

        switch(finger.getType()) {
        case 0:
          // System.out.println("thumb");
          break;
        case 1:
          // System.out.println("index");
          //circle red
          rectMode(CENTER);
          strokeWeight(5);
          stroke(0, 0, 0);
          fill(#ff0000);
          ellipse(finger.getPosition().x, finger.getPosition().y, 50, 50);
          break;
        case 2:
          // System.out.println("middle");
          break;
        case 3:
          // System.out.println("ring");
          break;
        case 4:
          // System.out.println("pinky");
          break;
        }


        // ================================================
        // 5. Bones
        // --------
        // https://developer.leapmotion.com/documentation/java/devguide/Leap_Overview.html#Layer_1

        Bone    boneDistal       = finger.getDistalBone();
        // or                      finger.get("distal");
        // or                      finger.getBone(0);

        Bone    boneIntermediate = finger.getIntermediateBone();
        // or                      finger.get("intermediate");
        // or                      finger.getBone(1);

        Bone    boneProximal     = finger.getProximalBone();
        // or                      finger.get("proximal");
        // or                      finger.getBone(2);

        Bone    boneMetacarpal   = finger.getMetacarpalBone();
        // or                      finger.get("metacarpal");
        // or                      finger.getBone(3);

        // ------------------------------------------------
        // Touch emulation

        int     touchZone        = finger.getTouchZone();
        float   touchDistance    = finger.getTouchDistance();

        switch(touchZone) {
        case -1: // None
          break;
        case 0: // Hovering
          //background(0, 255, 0, 0);

          rectMode(CENTER);
          strokeWeight(5);
          stroke(150, 0, 0);
          fill(#ff0000);
          rect(width/2, height/2, 50, 100);
          println("Hovering (#" + fingerId + "): " + touchDistance);
          break;
        case 1: // Touching
          //background(0, 0, 255, 220);

          rectMode(CENTER);
          strokeWeight(5);
          stroke(150, 0, 0);
          fill(#00ff00);
          rect(width/2, height/2, 50, 100);
          println("Touching (#" + fingerId + ")");
          break;
        }
      }


      // ==================================================
      // 6. Tools

      for (Tool tool : hand.getTools ()) {
        int     toolId           = tool.getId();
        PVector toolPosition     = tool.getPosition();
        PVector toolStabilized   = tool.getStabilizedPosition();
        PVector toolVelocity     = tool.getVelocity();
        PVector toolDirection    = tool.getDirection();
        float   toolTime         = tool.getTimeVisible();

        // ------------------------------------------------
        // Drawing:
        // tool.draw();

        // ------------------------------------------------
        // Touch emulation

        int     touchZone        = tool.getTouchZone();
        float   touchDistance    = tool.getTouchDistance();

        switch(touchZone) {
        case -1: // None
          break;
        case 0: // Hovering
          //println("Hovering (#" + toolId + "): " + touchDistance);
          break;
        case 1: // Touching
          //println("Touching (#" + toolId + ")");
          break;
        }
      }
    }


    // ====================================================
    // 7. Devices

    for (Device device : leap.getDevices ()) {
      float deviceHorizontalViewAngle = device.getHorizontalViewAngle();
      float deviceVericalViewAngle = device.getVerticalViewAngle();
      float deviceRange = device.getRange();
    }
  } else if (state == 2)//press s key again to stop the game
  {
    background(0);
    fill(255);
    textAlign(CENTER);
    //text("get point: "+ kago_count, width/2, height/2 - 30);
    text("Thanks for Enjoying the Game!", width/2, height/2 + 200);
    //music_stop();//music
  }
}

