ArrayList<BrightnessMapper> mappers;

void setup(){
     size(1920, 1080,P2D);
    
    ArrayList all = new ArrayList();
    
    background(0);
    mappers = new ArrayList();
    String[] list = loadStrings("list.txt");
    for(int i = 0 ; i < list.length;i++){
    String imagePath = list[i]; // Make sure the image is in the sketch's data folder
    int threshold = 150;
    mappers.add(new BrightnessMapper(imagePath, threshold));
    BrightnessMapper current = (BrightnessMapper)mappers.get(mappers.size()-1);
    current.processImage();
    
    println("list[i]");
    String tmp = "";
    for(int ii = 0 ; ii < current.stripes.size();ii++){
      Stripe balmer = (Stripe)current.stripes.get(ii);
      tmp = tmp+" "+balmer.x;
      
    }
    println(tmp);
    all.add(tmp);
    }
    
    String tmp2 = "";
    String result[] = new String[mappers.size()];
    for(int i = 0 ; i < all.size();i++){
      result[i]=(String)all.get(i)+"";
    }
    saveStrings("frequencies.txt",result);
}


void draw(){
  fill(0,128);
  noStroke();
  rect(0,0,width,height);
  BrightnessMapper current = (BrightnessMapper)mappers.get(frameCount%mappers.size());
  
  ArrayList<Stripe> result = current.getStripes();
    
    // Draw the stripes for visualization
    for (Stripe stripe : result) {
        stroke(255,50); 
        line(stripe.x, 0, stripe.x, height);
    }
    saveFrame("/run/media/kof/kof17/render/frame#####.tga");
    
    if(frameCount>1228)
    exit();
  
}

 // Inner class to hold stripe information
    class Stripe {
        float x; // x-coordinate of the stripe
        int startY; // starting y-coordinate of the stripe
        int endY; // ending y-coordinate of the stripe
        PImage img;

        Stripe(int x, PImage _img) {
          img = _img;
            this.x = map(x,0,img.width,350,750);
            this.startY = startY;
            this.endY = endY;
        }
    }

class BrightnessMapper {
    PImage img;
    int threshold;
    ArrayList<Stripe> stripes;

   

    BrightnessMapper(String imagePath, int threshold) {
        img = loadImage(imagePath);
        this.threshold = threshold;
        stripes = new ArrayList<Stripe>();
    }

    void processImage() {
        img.loadPixels();
        for (int x = 0; x < img.width; x++) {
            int startY = -1; // Initialize startY
            for (int y = 0; y < img.height; y++) {
                int pixelColor = img.pixels[y * img.width + x];
                float brightness = brightness(pixelColor);
                if (brightness > threshold) {
                    if (startY == -1) {
                        startY = y; // Mark the start of a stripe
                    }
                } else {
                    if (startY != -1) {
                        // End of a stripe
                        stripes.add(new Stripe(x, img));
                        startY = -1; // Reset startY
                    }
                }
            }
            // Check if the stripe extends to the bottom of the image
            if (startY != -1) {
                stripes.add(new Stripe(x, img));
            }
        }
    }

    ArrayList<Stripe> getStripes() {
        return stripes;
    }
}
