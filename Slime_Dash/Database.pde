import de.bezier.data.sql.*;
MySQL msql;
// This is a data model class to reflect the content of the User entity from the database.
final int LOGIN_FADE_START = 255, 
  ACH_TEXT_SIZE = 30, 
  SCORE_TYPE = 1, 
  ENEMY_TYPE = 2, 
  HEART_TYPE = 3, 
  BLOCK_TYPE = 4, 
  ID_DJUMP = 1, 
  ID_HEALTH = 2, 
  ID_DASH = 3, 
  ID_COINS = 4;

final color ACH_COMPLETED_COLOR = color(0, 255, 0);

boolean wrongPassword = false;
String loginFailText;
int achRecordCount = 0, loginFade, heartCount = 0, blockBreakCount = 0;

void databaseSetup() {
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
    msql.query( "SELECT a.id, a.score_type, a.required_score, a.reward, ap.Users_id, ap.progres FROM Achievements a INNER JOIN Achievements_Progres ap ON ap.Achievements_id = a.id WHERE ap.Users_id = " + user.id );

    while ( msql.next() ) {
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

        if (dbAch.get(iAch).scoreType == SCORE_TYPE && dbAch.get(iAch).progress < int(interfaces.score)) {
          msql.query( "UPDATE Achievements_Progres SET progres = " + int(interfaces.score) + " WHERE Users_id = " + user.id + " AND Achievements_id = "+ dbAch.get(iAch).id );

          dbAch.get(iAch).progress = int(interfaces.score);
          if (dbAch.get(iAch).progress >= dbAch.get(iAch).requiredScore) {
            dbAch.get(iAch).progress = dbAch.get(iAch).requiredScore;
            coins += dbAch.get(iAch).reward;
            dbAch.get(iAch).completed = true;
          }
        }

        //updates enemie kill based achievements
        updateAch(killCount, ENEMY_TYPE, iAch);

        //updates heart pickup achievements
        updateAch(heartCount, HEART_TYPE, iAch);

        //updates block break achievement
        updateAch(blockBreakCount, BLOCK_TYPE, iAch);
      }
    }

    killCount = 0; //resets the enemie kills
    heartCount = 0;
    blockBreakCount = 0;
  }
}

void updateAch(int count, int scoretype, int index) {
  if (dbAch.get(index).scoreType == scoretype && dbAch.get(index).progress < dbAch.get(index).progress + count) {
    msql.query( "UPDATE Achievements_Progres SET progres = " + (dbAch.get(index).progress + count) + " WHERE Users_id = " + user.id + " AND Achievements_id = "+ dbAch.get(index).id );

    dbAch.get(index).progress += count;
    if (dbAch.get(index).progress >= dbAch.get(index).requiredScore) {
      dbAch.get(index).progress = dbAch.get(index).requiredScore;
      coins += dbAch.get(index).reward;
      dbAch.get(index).completed = true;
    }
  }
}

void drawAch() {
  if (offline) {
    textSize(ACH_TEXT_SIZE);
    fill(RED);
    text("Online mode required!", width / 8, height / 5);
  }

  for (int iAch = 0; iAch < achRecordCount; iAch++) {
    if (dbAch.get(iAch).completed) {
      fill(ACH_COMPLETED_COLOR);
    } else {
      fill(YELLOW);
    }
    textSize(ACH_TEXT_SIZE);
    if (dbAch.get(iAch).scoreType == SCORE_TYPE) {
      text("Get " + dbAch.get(iAch).requiredScore + " score: progres = " + dbAch.get(iAch).progress +"/" + dbAch.get(iAch).requiredScore, width / 8, height / 5 + globalScale * iAch);
    } else if (dbAch.get(iAch).scoreType == ENEMY_TYPE) {
      text("Dash through " + dbAch.get(iAch).requiredScore + " enemies: progres = " + dbAch.get(iAch).progress +"/" + dbAch.get(iAch).requiredScore, width / 8, height / 5 + globalScale * iAch);
    } else if (dbAch.get(iAch).scoreType == HEART_TYPE) {
      text("Pickup " + dbAch.get(iAch).requiredScore + " hearts: progres = " + dbAch.get(iAch).progress +"/" + dbAch.get(iAch).requiredScore, width / 8, height / 5 + globalScale * iAch);
    } else if (dbAch.get(iAch).scoreType == BLOCK_TYPE) {
      text("Break " + dbAch.get(iAch).requiredScore + " blocks: progres = " + dbAch.get(iAch).progress +"/" + dbAch.get(iAch).requiredScore, width / 8, height / 5 + globalScale * iAch);
    }
  }
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
        msql.query("UPDATE zlokhorc.Highscores SET score = " +currentScore+ " WHERE Users_id = "+ user.id );
        interfaces.newHighscore=" !!!";
      }
    }
  }
  return currentScore;
}

float getOnlineTempTime(int userId, float currentTime, int templateId) {
  if ( msql.connect()) {
    msql.query("SELECT * FROM zlokhorc.Template_Highscores WHERE Users_id = "+userId);
    //check of er al een score is
    if (msql.next()) {
      if (msql.getFloat("time") > currentTime) {
        currentTime = msql.getFloat("time");
      } else if (msql.getFloat("time") < currentTime ) {
        msql.query("UPDATE zlokhorc.Template_Highscores SET time = " +currentTime );
      }
    }
  }
  return currentTime;
}

class Highscores {
  public String name;
  public int id;
  public int score;
  public Highscores(String name, int id, float score) {
    this.score = int(score);
    this.id = id;
    this.name = name;
  }
}

ArrayList<Highscores> hScore;
int scorePos;

void getHighscores() {
  hScore = new ArrayList<Highscores>();
  hScore.clear();
  if ( msql.connect()) {
    msql.query("SELECT u.name, u.id, max(h.score) FROM Highscores h INNER JOIN Users u ON u.id = h.Users_id GROUP BY h.score desc, u.name, u.id;");
    while (msql.next()) {
      hScore.add(new Highscores(msql.getString("name"), msql.getInt("id"), msql.getFloat("max(h.score)")));
    }

    for (int iScore = 0; iScore < hScore.size(); iScore++) {      
      if (user.id == hScore.get(iScore).id) {
        scorePos = iScore+1;
        break;
      }
    }
  }
}

final int SCORE_LIST_AMOUNT = 10;

void drawHScores() {
  final float HIGHSCORE_X = width/4, 
    HIGHSCORE_Y = height/6;


  textSize(TEXT_NORMAL);
  if (!offline) {
    fill(0, 70);
    rect(0, 0, width, height);
    for (int iScore = 0; iScore < SCORE_LIST_AMOUNT; iScore++) {
      if (user.id == hScore.get(iScore).id) {
        fill(WHITE);
      } else
        fill(255-(iScore*10), 255-(iScore*25), iScore*10);
      text(iScore+1 +". " +hScore.get(iScore).name + ": "+ hScore.get(iScore).score, HIGHSCORE_X, HIGHSCORE_Y + (globalScale/1.5) * iScore);
    }
    fill(WHITE);
    text("Your position: "+ scorePos +"!", HIGHSCORE_X, height - (globalScale*3));
  } else {
    text("You need to be online!", HIGHSCORE_X, height - (globalScale*3));
  }
}

//upgrades
void getUpgrades() {
  if ( msql.connect() )
  {
    msql.query( "SELECT Upgrades_id, level FROM Player_Upgrades WHERE Users_id = " + user.id );

    while ( msql.next() ) {
      switch (msql.getInt("Upgrades_id")) {
      case ID_DJUMP:
        upgrade.perchTLState = msql.getInt("level");
        break;
      case ID_HEALTH:
        upgrade.perchBLState = msql.getInt("level");
        break;
      case ID_DASH:
        if (msql.getInt("level") == 0) {
          upgrade.perchTRState = 1;
        } else {
          upgrade.perchTRState = msql.getInt("level");
        }
        break;
      case ID_COINS:
        upgrade.perchBRState = msql.getInt("level");
        break;
      }
    }

    upgrade.dashPrice = DASH_PRICE * int((pow(2, float(upgrade.perchTRState))));
    upgrade.coinPrice = COIN_PRICE * int((pow(2, float(upgrade.perchBRState))));
    upgrade.healthPrice = HEALTH_PRICE * int((pow(2, float(upgrade.perchBLState))));
  }
}

void updateUpgrades(int upgradeIndex, int newLevel) {
  if (!offline) {
    if ( msql.connect() )
    {
      msql.query( "UPDATE Player_Upgrades SET level = "+newLevel+" WHERE Upgrades_id = "+upgradeIndex+" AND Users_id = "+user.id+";" );

      updateUser();

      upgrade.dashPrice = DASH_PRICE * int((pow(2, float(upgrade.perchTRState))));
      upgrade.coinPrice = COIN_PRICE * int((pow(2, float(upgrade.perchBRState))));
      upgrade.healthPrice = HEALTH_PRICE * int((pow(2, float(upgrade.perchBLState))));
    }
  }
}

final int UPGRADE_AMOUNT = 4;
void createUpgrades(int userID) {
  if ( msql.connect() ) {
    for (int iUpg = 1; iUpg <= UPGRADE_AMOUNT; iUpg++) {
      msql.query("INSERT INTO Player_Upgrades VALUES ("+ userID +", "+ iUpg +", 0); ");
    }
  }
}

//chris

class account {
  public int id;
  public String name;
  public String password;
  public float hoursPlayed;
  public int coins;
  public account(int id, String name, String password, float hoursPlayed, int coins) {
    this.id = id;
    this.name = name;
    this.password = password;
    this.hoursPlayed = hoursPlayed;
    this.coins = coins;
  }
}

account user;

void createUser(String userName, String password) {
  int userUsed; //looks id any user already has the name and password
  if ( msql.connect()) {
    msql.query("SELECT count(*) FROM Users WHERE name =  '" + userName +"';");
    msql.next();
    userUsed = msql.getInt("count(*)");

    if (userUsed == 0) {
      msql.query("INSERT INTO Users (name, password) VALUES ('" + userName + "', '" + password + "');");

      msql.query("SELECT * FROM Users WHERE name =  '" + userName +"' AND password = '"+ password +"';");
      msql.next();
      user = new account(msql.getInt("id"), msql.getString("name"), msql.getString("password"), msql.getFloat("hours_played"), msql.getInt("coins"));
      makeAchforUser(user.id);

      msql.query("INSERT INTO Highscores (Users_id, score, time) VALUES (" + user.id + ", 0, 0);");

      createUpgrades(user.id);
      GetAchievements();
      getHighscores();
      getUpgrades();

      offline = false;
      println("Welcome, " + userName + "!");
      wrongPassword = false;
      room = "mainM";
    } else {
      println("Account already exists!");
      wrongPassword = true;
      loginFade = LOGIN_FADE_START;
    }
  }
}

void loginUser(String userName, String password) {
  int userExists;
  if ( msql.connect()) {
    msql.query("SELECT count(*) FROM Users WHERE name =  '" + userName +"' AND password = '" + password +"';");
    msql.next();
    userExists = msql.getInt("count(*)");

    if (userExists > 0) {
      msql.query("SELECT * FROM Users WHERE name =  '" + userName +"' AND password = '"+ password +"';");
      msql.next();
      user = new account(msql.getInt("id"), msql.getString("name"), msql.getString("password"), msql.getFloat("hours_played"), msql.getInt("coins"));
      coins = user.coins;

      GetAchievements();
      getHighscores();
      getUpgrades();

      offline = false;
      println("Welcome, " + user.name + "!");
      wrongPassword = false;
      room = "mainM";
    } else {
      println("Wrong password or username!");
      wrongPassword = true;
      loginFade = LOGIN_FADE_START;
    }
  }
}

void updateUser() {
  final int SEC_P_HOUR = 3600;
  float hoursPlayed = secondsPlayed / SEC_P_HOUR;
  if ( msql.connect()) {
    if (coins > user.coins || hoursPlayed > user.hoursPlayed) {
      msql.query( "UPDATE Users SET coins = " + coins + ", hours_played = " + hoursPlayed + " WHERE id = " + user.id + ";");
    }
  }
}

//Mats
OnlineTemplates onlineTemplates = new OnlineTemplates();
class OnlineTemplates {
  String[] names;
  PImage[] bitmaps;
  PImage[] bitmapsView;
  int selected = 0;
  void setup() {
    //Get Amount of templates
    msql.query("SELECT count(*) FROM zlokhorc.Weekly_Templates;");
    msql.next();
    int templateCount = msql.getInt(1);
    println("templateCount:", templateCount);
    //Setting the arrays to the right size
    bitmaps = new PImage[templateCount];
    names = new String[templateCount];
    msql.query("SELECT * FROM zlokhorc.Weekly_Templates;");
    //Looping through all the online templates
    for (int i = 0; msql.next(); i++) {
      names[i] = msql.getString("name");
      String OnlineTemplateStrings = msql.getString("map_png");
      //Using the split function to cut the string into usable pieces
      String[] imgNumberClusters = OnlineTemplateStrings.split(";");
      String[] imgWidthAndHeight = imgNumberClusters[0].split(",");
      PImage bitmap = createImage(Integer.valueOf(imgWidthAndHeight[0]), Integer.valueOf(imgWidthAndHeight[1]), ARGB);
      bitmap.loadPixels();
      //Looping through Strings to create the image (bitmap)
      for (int Stringi = 0; Stringi < bitmap.pixels.length; Stringi++) {
        String[] rgba = imgNumberClusters[Stringi+1].split(",");
        float red = Float.valueOf(rgba[0]), 
          green = Float.valueOf(rgba[1]), 
          blue = Float.valueOf(rgba[2]), 
          alpha = Float.valueOf(rgba[3]);
        color col = color(red, green, blue, alpha);
        bitmap.pixels[Stringi] = col;
      }
      bitmaps[i] = bitmap;
    }
    //Making images to be displayed for debug
    bitmapsView = bitmaps;
    for (int i = 0; i < bitmapsView.length; i++) {
      bitmapsView[i].resize(width, width/bitmapsView[i].width*bitmapsView[i].height);
      if (bitmapsView[i].height > height) {
        bitmapsView[i].resize(height/bitmapsView[i].height*bitmapsView[i].width, height);
      }
    }
  }
}
