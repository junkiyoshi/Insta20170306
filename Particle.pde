class Particle
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float radius;
  float max_force;
  float max_speed;
  color body_color;
  
  Particle(float x, float y, float z)
  {
    location = new PVector(x, y, z);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    radius = 50;
    max_force = 1;
    max_speed = 8;
    body_color = color(0, 0, 255);
  }
    
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
  void seek(PVector target)
  {
    PVector desired = PVector.sub(target, location);
    float distance = desired.mag();
    desired.normalize();
    if(distance < radius)
    {
      float m = map(distance, 0, radius, 0, max_speed);
      desired.mult(m);
    }else
    {   
      desired.mult(max_speed);
    }
    
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(max_force);
    applyForce(steer);
  }
  
  void run()
  {    
    update();
    display();
  }
  
  void update()
  {     
    strokeWeight(1);    
    float power = 50;
    
    PVector future = velocity.copy();
    future.normalize();
    future.mult(power * 2);
    future.add(location);
    
    pushMatrix();
    translate(future.x, future.y, future.z);
    
    fill(255, 0, 0);
    noStroke();
    sphere(10);
      
    popMatrix();
   
    stroke(128);
    line(location.x + velocity.x, location.y + velocity.y, location.z + velocity.z, future.x, future.y, future.z);
        
    float angle_1 = random(360);
    float angle_2 = random(360);
    float x = power * cos(radians(angle_1)) + future.x;
    float y = power * sin(radians(angle_1)) + future.y;
    float z = power * cos(radians(angle_2)) + future.z;
   
    pushMatrix();
    translate(x, y, z);
    
    noStroke();
    fill(0, 255, 0);
    sphere(5);
    
    popMatrix();
    
    stroke(128);
    line(future.x, future.y, future.z, x, y, z);
    
    seek(new PVector(x, y, z));
    
    if(PVector.dist(new PVector(width / 2, height / 2, 0), location) > 250)
    {
      seek(new PVector(width / 2, height / 2, 0));
    }
    
    velocity.add(acceleration);
    velocity.limit(max_speed);
    location.add(velocity);
    acceleration.mult(0);
    velocity.mult(0.98);
  }
  
  void display()
  {
    fill(body_color);
    noStroke();
    
    pushMatrix();
    translate(location.x, location.y, location.z);
    
    sphere(10);
    
    popMatrix();
  }
}