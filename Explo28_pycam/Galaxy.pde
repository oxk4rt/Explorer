/* 
 * Por:
 * Oscar Espada García
 * oscar.es.garci@gmail.com
 *
 */
 
class Galaxy{
  
  private final String LOOKUP_SYSTEMS = "systems";
  private final String LOOKUP_SEPARATOR = "/";
  private final String LOOKUP_FILE_EXTENSION = ".xml";

  private PGraphics buffer;
  
  private int id;
  private String name;
  private String lookup;
  private String file;
  private int recognized;
  private System system[];
  
  Galaxy(PGraphics buffer_, String name_){
    buffer = buffer_;
    id = 0;
    name = name_;
    lookup = file = "";
    recognized = 0;
  }
  
  public void refresh(PGraphics buffer_){
    this.buffer = buffer_;
  }
  
  public void load(String lookup_, String file_){
    this.lookup = lookup_;
    this.file = file_; println(this.lookup + this.file);
    XML galaxy = loadXML(this.lookup + this.file);
    XML[] systems = galaxy.getChildren("system");
    this.recognized = systems.length;
    this.system = new System[recognized];
    for (int i = 0; i < this.recognized; i++) {
      id = systems[i].getInt("id");
      int spacex = parseInt(systems[i].getString("x"));
      int spacey = parseInt(systems[i].getString("y"));
      int spacez = parseInt(systems[i].getString("z"));
      String system_name = systems[i].getString("name");
      String system_lookup = this.lookup +
                             this.LOOKUP_SYSTEMS + 
                             this.LOOKUP_SEPARATOR +
                             systems[i].getString("lookup") +
                             this.LOOKUP_SEPARATOR;
      String system_file   = systems[i].getString("lookup") +
                             this.LOOKUP_FILE_EXTENSION;
      println("Load System["+i+"]: "+system_name+" {");
      this.system[i] = new System(buffer, system_name, spacex, spacey, spacez);
      this.system[i].load(system_lookup, system_file);
      println("} "+system_name+": end");
    }  
  }
  
  public void draw(){
    for(int i=0; i<recognized; i++)
      system[i].draw();
  }
  
  void mousePressed(float sx, float sy) {
    for (int i = 0; i < this.recognized; i++)
      system[i].mousePressed(sx, sy);
  }

  public void println(String s){
    print("\n\t\t"+s+"\n");
  }

}
