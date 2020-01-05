import de.bezier.data.sql.*;
MySQL msql;
// This is a data model class to reflect the content of the User entity from the database.

int User = 1; //temporary testing user
int achRecordCount = 0;

int totalCoins = 0;
char userLetter;
String userName;
boolean userNameActive;
char passwordLetter;
String password;
boolean passwordActive;
char emailLetter;
String email;
boolean emailActive;
boolean uploadAccount;

void databaseSetup() {
  CreateDatabaseConnection();
  println(msql.connect());
}

void CreateDatabaseConnection() {
  String dbHostID = "oege.ie.hva.nl";    // ip address, domain or hostname such as localhost
  String dbUsername = "lokhorc";
  String dbUserPass = "dw5dZKtaln1AHIK2";
  String dbSchema = "zlokhorc";
  msql = new MySQL( this, dbHostID, dbSchema, dbUsername, dbUserPass );
}


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
  public float score;
  public RecordScore(int userId, int gameId, int score) {
    this.userId = userId;
    this.gameId = gameId;
    this.score = score;
  }
}

class recordAchievements {
  public int id;
  public int scoreType;
  public int requiredScore;
  public int reward;
  public int progress;
  public boolean completed;
  public recordAchievements(int id, int scoreType, int requiredScore, int reward, int progress) {
    this.id = id;
    this.scoreType = scoreType;
    this.requiredScore = requiredScore;
    this.reward = reward;
    this.progress = progress;
  }
}

ArrayList<recordAchievements> dbAch;
ArrayList<RecordUser> dbUsers;
int positionYSpacing = 36;        // The spacing height between lines

///Achievements//////////////////

void GetAchievements() {
  dbAch = new ArrayList<recordAchievements>();

  if ( msql.connect() )
  {
    msql.query( "SELECT a.id, a.score_type, a.required_score, a.reward, ap.Users_id, ap.progres FROM Achievements a INNER JOIN Achievements_Progres ap ON ap.Achievements_id = a.id WHERE ap.Users_id = " + User );

    while ( msql.next() ) {
      //println( " \t " + msql.getInt("id") + " \t\t " + msql.getInt("score_type") + " \t\t " + msql.getInt("required_score") + " \t\t " + msql.getInt("reward") + " \t\t " + msql.getInt("progres") + " \t\t ");
      dbAch.add(new recordAchievements(msql.getInt("id"), msql.getInt("score_type"), msql.getInt("required_score"), msql.getInt("reward"), msql.getInt("progres")));

      if (dbAch.get(achRecordCount).progress >= dbAch.get(achRecordCount).requiredScore) {
        dbAch.get(achRecordCount).completed = true;
      }

      achRecordCount ++;
    }
  }
}

void makeAchforUser(int user) { //when making a new account, use this function to fill achievements for that person
  IntList achId = new IntList();

  msql.query( "SELECT id FROM Achievements;");
  while (msql.next()) {
    achId.append(msql.getInt("id"));
  }

  for (int iAch = 0; iAch < achId.size(); iAch++) {
    msql.query( "INSERT INTO Achievements_Progres (Users_id, Achievements_id) VALUES (" + user + ", " + achId.get(iAch) + ");");
  }
}

void updateAchievements() { //make sure to run this function once and not several times in a row to prevent lag/crashes
  if ( msql.connect() )
  {
    for (int iAch = 0; iAch < achRecordCount; iAch++) {
      if (!dbAch.get(iAch).completed) {

        //updates score based achievements, checks if ach has new progress, is correct scoretype and if its already completed
        if (dbAch.get(iAch).scoreType == 1 && dbAch.get(iAch).progress < int(interfaces.score)) {
          msql.query( "UPDATE Achievements_Progres SET progres = " + int(interfaces.score) + " WHERE Users_id = " + User + " AND Achievements_id = "+ dbAch.get(iAch).id );

          dbAch.get(iAch).progress = int(interfaces.score);
          if (dbAch.get(iAch).progress >= dbAch.get(iAch).requiredScore) {
            coins += dbAch.get(iAch).reward;
            dbAch.get(achRecordCount).completed = true;
          }
        }

        //updates enemie kill based achievements
        if (dbAch.get(iAch).scoreType == 2 && dbAch.get(iAch).progress < dbAch.get(iAch).progress + killCount) {
          msql.query( "UPDATE Achievements_Progres SET progres = " + (dbAch.get(iAch).progress + killCount) + " WHERE Users_id = " + User + " AND Achievements_id = "+ dbAch.get(iAch).id );

          dbAch.get(iAch).progress += killCount;
          if (dbAch.get(iAch).progress >= dbAch.get(iAch).requiredScore) {
            coins += dbAch.get(iAch).reward;
            dbAch.get(achRecordCount).completed = true;
          }
        }
      }
    }

    killCount = 0; //resets the enemie kills
  }
}


void drawAch() {
  for (int iAch = 0; iAch < achRecordCount; iAch++) {
    fill(RED);
    textSize(30);
    if (dbAch.get(iAch).scoreType == 1) {
      text("Get " + dbAch.get(iAch).requiredScore + " score: progres = " + dbAch.get(iAch).progress +"/" + dbAch.get(iAch).requiredScore, width / 8, height / 6 + globalScale * iAch);
    } else if (dbAch.get(iAch).scoreType == 2) {
      text("Dash through " + dbAch.get(iAch).requiredScore + " enemies: progres = " + dbAch.get(iAch).progress +"/" + dbAch.get(iAch).requiredScore, width / 8, height / 6 + globalScale * iAch);
    }
  }

  //for testing
  /*if (mousePressed) {
   updateAchievements();
   }*/
}

//Laurens

float getScore(int userId, float currentScore) {
  if ( msql.connect()) {
    msql.query("SELECT * FROM zlokhorc.Highscores WHERE Users_id = "+userId);
    //check of er al een score is
    if (msql.next()) {
      if (msql.getFloat("score") > currentScore) {
        currentScore = msql.getFloat("score");
      } else if (msql.getFloat("score") < currentScore ) {
        msql.query("UPDATE zlokhorc.Highscores SET score = " +currentScore );
      }
    }
  }  
  return currentScore;
}


//collin

class account {
  public int id;
  public String name;
  public String password;
  public String email;
  public int coins;
  public account(int id, String name, String password) {
    this.id = id;
    this.name = name;
    this.password = password;
  }
}




void addUser () {



  if ((inputs.hasValue(40))&& userNameActive==true) {
    userNameActive=false;
    passwordActive=true;
  }
  if ((inputs.hasValue(40))&& passwordActive==true) {
    passwordActive=false;
    emailActive=true;
  }
  if ((inputs.hasValue(40))&& emailActive==true) {
    emailActive=false;
    uploadAccount=true;
  }
  if ((inputs.hasValue(38))&& uploadAccount==true) {
    uploadAccount=false;
    emailActive=true;
  }
  if ((inputs.hasValue(38))&& emailActive==true) {
    emailActive=false;
    passwordActive=true;
  }
  if (inputs.hasValue(38)&& passwordActive==true) {
    passwordActive=false;
    userNameActive=true;
  }


  if ((key >= 'A' && key <= 'z')&& userNameActive==true) {
    userLetter = key;
    userName = userName + key;
  }
  if ((key >= 'A' && key <= 'z')&& userNameActive==true) {
    userLetter = key;
    userName = userName + key;
  }

  if ((key >= 'A' && key <= 'z')&& passwordActive==true) {
    passwordLetter = key;
    password = password + key;
  }

  if ((key >= 'A' && key <= 'z')&& emailActive==true) {
    emailLetter = key;
    email = email + key;
  }

  if (inputs.hasValue(13) == true&& uploadAccount==true) {

    uploadAccount=false;
    msql.query("INSERT INTO Users (name, password, email, coins) VALUES ('String', 'String', 'String', 'int')", userName, password, email, totalCoins);
  }
}

void createUser(String userName, String password) {
  int userUsed; //looks id any user already has the name and password
  if ( msql.connect()) {
    msql.query("SELECT count(*) FROM Users WHERE name =  '" + userName +"' AND password = '"+ password +"';");
    msql.next();
    userUsed = msql.getInt("count(*)");

    if (userUsed == 0) {
      msql.query("INSERT INTO Users (name, password) VALUES ('" + userName + "', '" + password + "');");

      msql.query("SELECT id FROM Users WHERE name = '" + userName +"' AND password = '"+ password +"';");
      msql.next();
      makeAchforUser(msql.getInt("id"));
      println("Welcome, " + userName + "!");
    } else
      println("Account already exists!");
  }
}
