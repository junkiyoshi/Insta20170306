ArrayList<Particle> particles;
PVector target;

void setup()
{
  size(512, 512, P3D);
  frameRate(30);
  
  particles = new ArrayList<Particle>();
  for(int i = 0; i < 12; i++)
  {
    particles.add(new Particle(width / 2, height / 2, 0));
  }
}

void draw()
{
  background(255);
  
  stroke(0);
  strokeWeight(30);
  line(width / 4, 0, 0, width / 4, height , 0);
  line(width / 4 * 3, 0, 0, width / 4 * 3, height , 0);
  
  for(Particle p : particles)
  {
    p.run();
  }
  
  /*
  println(frameCount);
  saveFrame("screen-#####.png");
  if(frameCount > 900)
  {
     exit();
  }
  */
}