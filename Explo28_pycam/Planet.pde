/* 
 * Por:
 * Oscar Espada García
 * oscar.es.garci@gmail.com
 *
 */
 
class Planet extends Element{
  
  private final String LOOKUP_SEPARATOR = "/";
  private final String LOOKUP_FILE_EXTENSION = ".xml";
  
  private boolean view_orbital_line;
  protected Element orbital_element[];
  protected int orbital_element_recognized;
  
  Planet(PGraphics buffer_, String name_, PVector reference_system){
    super(buffer_,reference_system);
    this.name = name_;
    grade = 0;
    module = 0.0;
    view_orbital_line = false;
    orbital_element = null;
    orbital_element_recognized = 0;
  }
  
  public void storingData(XML[] data){
      println("Load data number: "+data.length+".");
      for(int i=0; i<data.length; i++){ 
        if(data[i].getString("type").equals("pvector")){
             this.center.x = data[i].getChild("x").getInt("value");
             this.center.y = data[i].getChild("y").getInt("value");
             this.center.z = data[i].getChild("z").getInt("value");
        }else if(data[i].getString("type").equals("grade")){
             this.grade = data[i].getInt("value");
        }else if(data[i].getString("type").equals("color")){
             this.r = data[i].getChild("r").getInt("value");
             this.g = data[i].getChild("g").getInt("value");
             this.b = data[i].getChild("b").getInt("value");
             this.a = data[i].getChild("a").getInt("value");
        }else if(data[i].getString("type").equals("diameter")){
             this.radius = data[i].getFloat("value")/2;
             this.volume = (4/3) * PI * pow(this.radius,3);
        }else if(data[i].getString("type").equals("radiusorbit")){
             this.radius_orbit = data[i].getFloat("value");
        }else if(data[i].getString("type").equals("module")){
             this.module = data[i].getFloat("value");
        }else if(data[i].getString("type").equals("mass")){
             this.mass = data[i].getString("value");
        }else if(data[i].getString("type").equals("inclination")){
             this.inclination = data[i].getFloat("value");  
        }else if(data[i].getString("type").equals("inclinationorbit")){
             this.inclination_orbit = data[i].getFloat("value");
        }else if(data[i].getString("type").equals("speed")){
             this.speed = data[i].getFloat("value");
        }else if(data[i].getString("type").equals("orbitalelements")){
             XML[] orbitalelements = data[i].getChildren("element");
             this.orbital_element_recognized = orbitalelements.length;
             this.orbital_element = new Element[this.orbital_element_recognized];
             for(int j=0; j<this.orbital_element_recognized; j++){
               String element_name = orbitalelements[j].getString("name");
               String element_class = orbitalelements[j].getString("class");
               String element_lookup = this.lookup +
                                       element_class +
                                       this.LOOKUP_SEPARATOR;
               String element_file   = orbitalelements[j].getString("file") +
                                       this.LOOKUP_FILE_EXTENSION;
               if(element_class.equals("moons"))
                 this.orbital_element[j] = new Moon(this.buffer, element_name, this.reference);
               orbital_element[j].load(element_lookup, element_file);
               orbital_element[j].refreshOrbitalSpace(this.center);
             }
        }
      }   
  }
  
  public void refresh(PGraphics buffer_){
    super.refresh(buffer_);
    this.grade++;
    if(this.grade/this.module>359.99) this.grade=0;
    this.center.x = cos(radians(this.grade/this.module)) * this.radius_orbit;
    this.center.y = sin(radians(this.grade/this.module)) * this.radius_orbit; 
    this.center.z = cos(radians(this.grade/this.module)) * tan(radians(this.inclination_orbit)) * this.radius_orbit;
    if(this.orbital_element_recognized > 0) 
      for(int i=0; i<this.orbital_element_recognized; i++)
        orbital_element[i].refreshOrbitalSpace(this.center);
  }
  
  public void activeOrbitalLine(){
    super.activeOrbitalLine();
    view_orbital_line = true;
  }
  
  private void desactiveOrbitalLine(){
    this.newOrbit();
  }
  
  private void theOrbitalLine(){
    stroke(255,255,255);
    noFill();
    strokeWeight(0.5);
    strokeJoin(ROUND); 
    pushMatrix();
    beginShape();
    for(int i=0; i<360; i++)
      curveVertex(this.orbit[i].x, this.orbit[i].y, this.orbit[i].z);
    endShape(CLOSE);
    popMatrix();
    noStroke();
  }
  
  private void theOrbitElements(){
    if(this.orbital_element_recognized > 0) 
      for(int i=0; i<this.orbital_element_recognized; i++)
        orbital_element[i].draw();
  }
  
  public void draw(){ 
    this.refresh(this.buffer);
    if(view_orbital_line) this.theOrbitalLine(); 
    pushMatrix();
    translate(this.center.x, this.center.y, this.center.z);
    this.display();
    this.theOrbitElements();
    popMatrix();
  }

}
