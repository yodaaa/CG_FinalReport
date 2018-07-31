
Spring spring;

class Spring 
{
  MouseJoint mouseJoint;

  Spring() {
    mouseJoint = null;
  }


  void update(float x, float y) {
    if (mouseJoint != null) {
      Vec2 mouseWorld = box2d.coordPixelsToWorld(x,y);
      mouseJoint.setTarget(mouseWorld);
    }
  }
  

  void display() {
    /*
    if (mouseJoint != null) {
      Vec2 v1 = null;
      mouseJoint.getAnchorA(v1);
      Vec2 v2 = null;
      mouseJoint.getAnchorB(v2);

      v1 = box2d.coordWorldToPixels(v1);
      v2 = box2d.coordWorldToPixels(v2);
      // And just draw a line
      stroke(0);
      strokeWeight(1);
      line(v1.x,v1.y,v2.x,v2.y);
    }
    */
  }


  // This is the key function where
  // we attach the spring to an x,y location
  // and the Boby_Box object's location
//  void bind(float x, float y, Body_Box box) 
//  {
//    MouseJointDef md = new MouseJointDef();
//    md.bodyA = box2d.getGroundBody();
//    md.bodyB = box.body;
//    Vec2 mp = box2d.coordPixelsToWorld(x,y);
//    md.target.set(mp);
//
//    md.maxForce = 1000.0f * box.body.m_mass;
//    md.frequencyHz = 5.0f;
//    md.dampingRatio = 0.9f;
//
//    // Make the joint!
//    mouseJoint = (MouseJoint) box2d.world.createJoint(md);
//  }
//
//  void destroy() {
//    if (mouseJoint != null) {
//      box2d.world.destroyJoint(mouseJoint);
//      mouseJoint = null;
//    } 
//  }
}


