/*import de.bezier.data.sql.*;
 MySQL msql;
 // This is a data model class to reflect the content of the User entity from the database.
 class RecordUser {
 public int id;
 public String name;
 public RecordUser(int id, String name) {
 this.id = id;
 this.name = name;
 }
 }
 // This is a data model class to reflect the content of the Score entity from the database.
 class RecordScore {
 public int userId;
 public int gameId;
 public int score;
 public RecordScore(int userId, int gameId, int score) {
 this.userId = userId;
 this.gameId = gameId;
 this.score = score;
 }
 }
 ArrayList<RecordUser> dbUsers; 
 int positionYSpacing = 36;        // The spacing height between lines
 String dbHostID = "oege.ie.hva.nl:3306";    // ip address, domain or hostname such as localhost
 String dbUsername = "cnossel";
 String dbUserPass = "+D3D//pgPQDcs6h$";
 String dbSchema = "zcnossel";
 
 void CreateDatabaseConnection() {
 msql = new MySQL( this, dbHostID, dbSchema, dbUsername, dbUserPass );
 }
 void GetUsers() {
 if ( msql.connect() ) {
 msql.query( "SELECT * FROM User" );
 println( "Table \t id \t\t name \t\t " );
 println( "===========================================" );
 int recordCount = 0;
 while ( msql.next() ) {        
 println( "  \t " + msql.getInt("id") + " \t\t " + msql.getString("name") + " \t\t " );
 dbUsers.add(new RecordUser(msql.getInt("id"), msql.getString("name")));
 recordCount++;
 }
 println( " Number of records: " + recordCount );
 } else {
 // connection failed !
 // -check your login, password
 // -check that your server runs on localhost and that the port is set right
 // -try connecting through other means (terminal or console / MySQL workbench / ...)println( " Failed to create MYSQL connection." );
 }}
 */
