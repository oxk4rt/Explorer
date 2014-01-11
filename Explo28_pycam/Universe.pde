/* 
 * Por:
 * Oscar Espada García
 * oscar.es.garci@gmail.com
 *
 */
 
class Universe{

  private final String LOOKUP_GALAXYS = "galaxys";
  private final String LOOKUP_SEPARATOR = "/";
  private final String LOOKUP_FILE_EXTENSION = ".xml";
  
  private PGraphics buffer;
  
  private String name;
  private String lookup;
  private Galaxy galaxy[];
  private int recognized;
  
  Universe(PGraphics buffer_){
    buffer = buffer_;
    name = "Universe";
    lookup = "universe" + LOOKUP_FILE_EXTENSION;
    recognized = 0;
  }
  
  public void refresh(PGraphics buffer_){
    this.buffer = buffer_;
  }
  
  public void load(XML universe){
    print(name+" {\n");
    XML[] galaxys = universe.getChildren("galaxy");
    recognized = galaxys.length;
    this.galaxy = new Galaxy[recognized];
    
    for (int i = 0; i < galaxys.length; i++) {
      int id = galaxys[i].getInt("id");
      String galaxy_name = galaxys[i].getString("name");
      String galaxy_lookup = this.LOOKUP_GALAXYS +
                             this.LOOKUP_SEPARATOR +
                             galaxys[i].getString("lookup") +
                             this.LOOKUP_SEPARATOR;
      String galaxy_file = galaxys[i].getString("lookup") +
                             this.LOOKUP_FILE_EXTENSION;
      println("Load Galaxy["+i+"]: "+galaxy_name+" {");
      this.galaxy[i] = new Galaxy(buffer, galaxy_name);
      this.galaxy[i].load(galaxy_lookup, galaxy_file);
      println("} "+galaxy_name+": end");
    } 
    print("} "+name+": end\n"); 
  }
  
  public void draw(){ 
    noStroke();
    for(int i=0; i<recognized; i++)
      galaxy[i].draw();
  }
  
  void mousePressed(float sx, float sy) {
    for (int i = 0; i < galaxy.length; i++)
      galaxy[i].mousePressed(sx, sy);
  }

  public void println(String s){
    print("\n\t"+s+"\n");
  }

}
