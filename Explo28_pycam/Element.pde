/* 
 * Por:
 * Oscar Espada García
 * oscar.es.garci@gmail.com
 *
 */
 
abstract class Element{
  
  protected PGraphics buffer;
  
  protected boolean picked;

  protected PVector reference; // (x,y,z) of system

  protected int id;
  protected String lookup;
  protected String file;
  protected String name;
  protected PVector center;
  protected float radius;
  protected int grade;
  protected float radius_orbit;
  protected float inclination_orbit;
  protected float module;
  protected PVector orbit[];
  protected String mass;
  protected float volume;
  protected float inclination;
  protected color background;
  protected float speed;
  protected int r, g, b, a;
  
  protected int sr=20, sg=80, sb=80, sa=250;
  
  protected PFont font;
  
  Element(PGraphics buffer_, PVector reference_system){
    buffer = buffer_;
    picked = false;
    reference = reference_system;
    id = 0;
    lookup = file = "";
    name = "";
    center = new PVector();
    radius = 0.0;
    background = color(0, 0, 0, 0);
    r = g = b = a = 0;
    orbit = null;
    font = loadFont("URWGothicL-Book-18.vlw");
  }
  
  public void load(String lookup_, String file_){
    this.lookup = lookup_;
    this.file = file_;
    println("URI: " + this.lookup + this.file);
    XML element = loadXML(this.lookup + this.file);
    XML[] data = element.getChildren("data");
    storingData(data);
  }
  
  abstract protected void storingData(XML[] data);

  abstract public void draw();
  
  protected void refresh(PGraphics buffer_){
    this.buffer = buffer_;
  };
  
  protected void newOrbit(){
    orbit = new PVector[360];
  }
  
  protected void activeOrbitalLine(){
    this.newOrbit();
    for(int i=0; i<360; i++)
        this.orbit[i] = new PVector(cos(radians(i)) * this.radius_orbit,
                                    sin(radians(i)) * this.radius_orbit,
                                    cos(radians(i)) * tan(radians(this.inclination_orbit)) * this.radius_orbit); 
  }  
  
  protected void showName(){
    textFont(font, 30);
    textAlign(CENTER);
    textMode(MODEL);  
    fill(250,250,255);
    text(this.name, this.center.x, this.center.y, this.center.z);
  }  

  protected PVector orbital_space;
  public void refreshOrbitalSpace(PVector orbital_space_center){
    orbital_space = orbital_space_center;
  }
  
  protected void mousePressed(float xp, float yp){
  }
  
  protected void display(){
    if(picked==true)
      fill(this.sr, this.sg, this.sb, this.sa);
    else
      fill(this.r, this.g, this.b, this.a);
    sphere(this.radius);
  }
  
  public void println(String s){
    print("\t\t\t\t"+s+"\n");
  }
  
  public void println(int i){
    print("\t\t\t\t"+i+"\n");
  }

}
