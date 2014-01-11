/* 
 * Por:
 * Oscar Espada García
 * oscar.es.garci@gmail.com
 *
 */
 
class System{

  private final String LOOKUP_SEPARATOR = "/";
  private final String LOOKUP_FILE_EXTENSION = ".xml";
  
  private PGraphics buffer;
  
  private int id;
  private String name;
  private String lookup;
  private String file;
  private int recognized;
  private Element element[]; // usually element[0] is the start
  
  private int spacex, spacey, spacez; // Position in the galaxy
  
  System(PGraphics buffer_, String name_, int x, int y, int z){
    this.buffer = buffer_;
    this.spacex = x;
    this.spacey = y;
    this.spacez = z;
    recognized = 0;
    name = name_;
    lookup = file = "";
  }
  
  public void load(String lookup_, String file_){
    this.lookup = lookup_;
    this.file = file_;
    println(this.lookup + this.file);
    XML system = loadXML(this.lookup + this.file);
    XML[] elements = system.getChildren("element");
    this.recognized = elements.length;
    this.element = new Element[this.recognized];
    for (int i = 0; i < this.recognized; i++) {
      int id = elements[i].getInt("id");
      String element_name = elements[i].getString("name");
      String element_class = elements[i].getString("class");
      String element_lookup = this.lookup +
                              element_class +
                              this.LOOKUP_SEPARATOR +
                              elements[i].getString("lookup") +
                              this.LOOKUP_SEPARATOR;
      String element_file   = elements[i].getString("lookup") +
                              this.LOOKUP_FILE_EXTENSION;
      println("Load "+element_class+"["+i+"]: "+element_name+" {");
      this.element[i] = (element_class.equals("starts"))? 
                        new Start(buffer, element_name, new PVector(this.spacex, this. spacey, this.spacez)) : 
                        new Planet(buffer, element_name, new PVector(this.spacex, this. spacey, this.spacez)) ;
      this.element[i].load(element_lookup, element_file);
      println("} "+element_name+": end");
    }  
  }
  
  public void refresh(PGraphics buffer_){
    this.buffer = buffer_;
  }
  
  public void draw(){
    pushMatrix();
    translate(spacex, spacey, spacez);
    for(int i=0; i<recognized; i++){
      element[i].refresh(buffer);
      element[i].draw();
    }
    popMatrix();
  }
  
  void mousePressed(float sx, float sy) {
    for (int i = 0; i < this.recognized; i++)
      element[i].mousePressed(sx, sy);
  }

  public void println(String s){
    print("\n\t\t\t"+s+"\n");
  }

}
