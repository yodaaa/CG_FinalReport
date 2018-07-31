class CustomListener implements ContactListener 
{
  CustomListener() {
  }

  // This function is called when a new collision occurs
   void beginContact(Contact cp) 
   {
    // Get both fixtures
    Fixture f1 = cp.getFixtureA();
    Fixture f2 = cp.getFixtureB();
    // Get both bodies
    Body b1 = f1.getBody();
    Body b2 = f2.getBody();
    

    // Get our objects that reference these bodies
    Object o1 = b1.getUserData();
    Object o2 = b2.getUserData();
    
    ///////////
  //two ball meet
  if (o1.getClass() == Particle.class && o2.getClass() == Particle.class) 
  {
    Particle p1 = (Particle) o1; 
    Particle p2 = (Particle) o2;

    /////////////////////
     Body mybody = p1.body;
     Vec2 mypos = box2d.getBodyPixelCoord(mybody);
     
     Body mybody2 = p2.body;
     Vec2 mypos2 = box2d.getBodyPixelCoord(mybody2);
     

     if(mypos.y > height/2.0 && p1.color_flag == p2.color_flag)
     {
       p1.delete();
       p2.delete();
       //play_effect_sound(0);
     }
  }
    
    ///////////
    // If object 1 is a Box, then object 2 must be a particle
    // If object 2 is a Box, then object 1 must be a particle
//    if (o1.getClass() == Body_Box.class && o2.getClass() != Body_Box.class) 
//    {
//      Particle p = (Particle) o2;    
//      play_effect_sound(1);
//         
//      if(o1 == robot && p.index % 3 == 0)
//      {
//        kago_count++;
//        p.delete();
//        kago_flag = 1;
//        flag_start = 0; 
//      }
//    } 
//    else if (o2.getClass() == Body_Box.class && o1.getClass() != Body_Box.class) 
//    {
//      Particle p = (Particle) o1;      
//      play_effect_sound(1);
//        
//      if(o2 == robot && p.index % 3 == 0)
//      {
//        kago_count++;
//        p.delete();
//        kago_flag = 1;
//        flag_start = 0; 
//      }
//    }
//    
    
    
    if (o1.getClass() == Boundary.class) {
      Particle p = (Particle) o2;
      Boundary step = (Boundary) o1;//this is a boundary;
      
      if(step.index > 6) // these are steps
      {
        p.color_flag = (p.color_flag + 1 )%2;
        p.change();
      }
      else 
      {
        p.color_flag = (p.color_flag + 1 )%2;
        p.change();
      }
    }
    
    
    if (o2.getClass() == Boundary.class) {
      Particle p = (Particle) o1;
      Boundary step = (Boundary) o2;//boundary
      
      if(step.index > 6)
      {
        p.color_flag = (p.color_flag + 1 )%2;
        p.change();
      }
      else
      {
        p.color_flag = (p.color_flag + 1 )%2;
        p.change();
      }
    }
  }/////end of fun
  
  

   void endContact(Contact contact) {
    // TODO Auto-generated method stub
  }
  

   void preSolve(Contact contact, Manifold oldManifold) {
    // TODO Auto-generated method stub
  }

   void postSolve(Contact contact, ContactImpulse impulse) {
    // TODO Auto-generated method stub
  }
}




