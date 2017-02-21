ArrayList<Circle> circles;
ArrayList<PVector> spots;
PImage img;

void setup() {
  size(326, 323);
  spots = new ArrayList<PVector>();
  img = loadImage("Frog2.png");
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int index = x + y * img.width;
      color c = img.pixels[index];
      float b = brightness(c);
      if (b > 1) {
        spots.add(new PVector(x, y));
      }
    }
  }  
  circles = new ArrayList<Circle>();
  circles.add(new Circle(200, 200));
}

void draw() {
  background(255);
  
  int total = 10;
  int count = 0;
  int attempts = 0;
  
  while (count < total) {
    Circle newC = newCircle();
    if (newC != null) {
       circles.add(newC);
       count ++;
    }
    attempts++;
    if (attempts > 100) {
      noLoop();
      println("FINISHED");
    }
  } 

  
  for (Circle c : circles){
    if (c.growing){
      if (c.edges()) {
        c.growing = false;
      } else {
        boolean overlapping = false;
        for (Circle other : circles) {
          if (c != other){
            float d = dist(c.x, c.y, other.x, other.y);
            if (d - 2 < c.r + other.r) {
              c.growing = false;
              break;
            }
          }  
        }
      }
    }
  c.show();
  c.grow();
  }
}

Circle newCircle() {
  
  int r = int(random(0, spots.size()));
  PVector spot = spots.get(r);
  
  float x = spot.x;
  float y = spot.y;
  
  boolean valid = true;
  for (Circle c : circles) {
    float d = dist (x, y, c.x, c.y);
    if (d < c.r + 1) {
      valid = false;
      break;
    }
  }
  
  if (valid) {
    return new Circle(x, y);
  } else {
    return null;
  }
}