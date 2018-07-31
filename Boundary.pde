float wall_depth = 20;
float board_depth = 20;


void setup_boundary()
{
  boundaries = new ArrayList<Boundary>();
  // Add bottom boundaries
  color ccc = color(255, 198);

  //left wall
  boundaries.add(new Boundary(0, width-5,height/2,10,height, ccc, wall_depth));
  
  //right wall
  boundaries.add(new Boundary(1, 5, height/2,10,height, ccc, wall_depth));
  
  //steps
  for(int i = 0; i < 5; i++)
  {
    boundaries.add(new Boundary(2+i, 120 + i*width/5, random(height/6, height/2), 
      100, 15, ccc, board_depth));
  }

  //step
  boundaries.add(new Boundary(7, width/2, height - 100, width/2, 15, ccc, wall_depth));
}
    




class Boundary 
{
  // A boundary is a simple rectangle with x,y,width,and height
  float x;
  float y;
  float w;
  float h;
    color col;
    float deepth;
    int index;
  
  // But we also have to make a body for box2d to know about it
  Body b;


  Boundary(int index_, float x_,float y_, float w_, float h_, color col_, float deepth_) 
  {
    index = index_;
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    col = col_;
    deepth = deepth_;

    

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
    
    b.setUserData(this);
  }


  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() 
  {
    fill(col);
    noStroke();
    pushMatrix();
    translate(x, y);
    box(w, h, deepth);
    popMatrix();
  }

}


