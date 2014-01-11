/* 
 * Por:
 * Oscar Espada García
 * oscar.es.garci@gmail.com
 *
 */
 
 class XYZ{
  
  public XYZ(){}
  
  public void draw(){
    pushMatrix();
    stroke(255, 0, 0);
    strokeWeight(0.5);
    line(350, 0, 0, -350, 0, 0);
    stroke(0, 255, 0);
    line(0, 350, 0, 0, -350, 0);
    stroke(0, 0, 255);
    line(0, 0, 350, 0, 0, -350);
    popMatrix();
    strokeWeight(1);
  }
  
}
