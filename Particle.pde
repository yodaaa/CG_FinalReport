int ballnum = 30; //ボールの個数


void setup_balls()
{
  particles = new ArrayList<Particle>();

  for(int i=0; i<ballnum; i++)
  {
    particles.add(new Particle(i, 0,
           20+random(width - 40), 
          random(-5*height, 0), 
          10.0+random(20)));
  }   
}

 
/////////////////////////////////////////
class Particle 
{
  Body body;
  int index;
  float r;
  color col;
  int color_flag;
  boolean delete = false;


  Particle(int index_, int color_flag_, float x, float y, float r_) 
  {
    index = index_;
    color_flag = color_flag_;
    r = r_;
    
    ///////////////////////////////////////////////////
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
       
    fd.density = 0.8;   
    fd.friction = 0.03;
    fd.restitution = 0.6;

    // Attach fixture to body
    body.createFixture(fd);
    body.setAngularVelocity(random(-10, 10));

    /////////////////////////////////////////////////////
    body.setUserData(this);
    col = color(255, 128);
  }


  // This function removes the particle from the box2d world
  void killBody() 
  {
    box2d.destroyBody(body);
  }

  void delete() 
  {
    delete = true;
  }

  // Change color when hit
  void change() 
  {
    if(color_flag == 0)
    col = color(255, 178);
    else if(color_flag == 1)
    col = color(255, 0, 0, 178);
  }
  


  // Is the particle ready for deletion?
  boolean done() 
  {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+r*2 || delete) 
    {
      killBody();
      return true;
    }
    return false;
  }
  
  
  // draw the particle
  void display() 
  {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);


    if(index % 3 != 0)
    {
      pushMatrix();
      fill(col);
      sphere(r);
      popMatrix();
    }
    else
    {
      pushMatrix();
      fill(col);
      box(r*1.2);
      popMatrix();
    }

    popMatrix();
  }
}



