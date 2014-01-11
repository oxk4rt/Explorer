/* 
 * Por:
 * Oscar Espada García
 * oscar.es.garci@gmail.com
 *
 */
 
class Simulator{
  private Universe universe; 
  
  private Explo28_pycam buffer;
  
  // For the double click
  private int counter=0;
  private float containerone;
  private float containertwo;
  private float clicktime;
  private float clickspeed = 200.0;
  
  private XYZ xyz;
  
  Simulator(Explo28_pycam buffer_){
    buffer = buffer_;
    camera = camera;
    universe = new Universe(g);
    XML universe_data;
    universe_data = loadXML("universe.xml");
    universe.load(universe_data);
  }
  
  public void draw(){
    
    universe.draw();
  
  }
  
  void mousePressed(float sx, float sy){
       universe.mousePressed(sx, sy);
  }
  
}
