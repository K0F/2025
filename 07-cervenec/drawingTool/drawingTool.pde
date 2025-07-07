import java.awt.Component;
import java.awt.Window;
import java.awt.Frame;
import javax.swing.SwingUtilities;

Frame frame;
boolean initialized = false;

ArrayList strokes;

void setup(){
	size(1280,1024);

	strokes = new ArrayList();


 noLoop(); // Prevent draw() from running until we're ready

  Component canvas = (Component) surface.getNative();
  Window window = SwingUtilities.getWindowAncestor(canvas);

  if (window instanceof Frame) {
    frame = (Frame) window;

    frame.dispose();                // Must dispose BEFORE undecorating
    frame.setUndecorated(true);    // Now we can safely make it undecorated
    frame.setOpacity(0.5f);        // Half transparent
    frame.setVisible(true);        // Show it again
  }

  surface.setLocation(0, 0);       // Move window to (0, 0)
  surface.setResizable(false);

  initialized = true;
  loop(); // Now allow draw() to run
  	
}

void makeTransparentAndUndecorated() {
  Frame frame = (Frame) surface.getNative();
  frame.setUndecorated(true);        // Remove window decorations

  try {
    frame.setOpacity(0.5f);          // Set window opacity to 50%
  } catch (Exception e) {
    println("Opacity setting failed: " + e);
  }
}


void draw(){


  if (!initialized) return;
  
	background(0);

	stroke(255,127);

	for(int i = 0 ; i < strokes.size();i++){
		Stroke tmp = (Stroke)strokes.get(i);
		tmp.draw();
	}
	
}

void mousePressed(){
	strokes.add(new Stroke(mouseX,mouseY));
}

void mouseDragged(){
if(strokes.size()>0){
	Stroke last = (Stroke)strokes.get(strokes.size()-1);
	last.add(mouseX,mouseY);
	}
}

void mouseReleased(){
	strokes.add(new Stroke(0,0));
}

void keyPressed(){
	if(key==CODED)
	if(key==BACKSPACE)
	if(strokes.size()>0)
		strokes.remove(strokes.size()-1);
}

class Stroke{
	ArrayList pos;

	Stroke(int _x, int _y){
		pos = new ArrayList();
		add(_x,_y);
	}

	void add(int _x, int _y){
		pos.add(new PVector(_x,_y));
	}

	void draw(){
	noFill();
	beginShape();
		for(int i = 0 ;i<pos.size();i++){
			PVector tmp = (PVector)pos.get(i);
			vertex(tmp.x,tmp.y);
		}
		endShape();
	}

	
}
