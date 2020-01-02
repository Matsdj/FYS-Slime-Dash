//collin

int totalCoins = 0;
char userLetter;
String userName;
int User_Id;
boolean userNameActive;
char passwordLetter;
String password;
boolean passwordActive;
char emailLetter;
String email;
boolean emailActive;
boolean uploadAccount;



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
    msql.query("INSERT INTO Users (Id, name, password, email, coins) VALUES ('int', 'String', 'String', 'String', 'int')", User_Id, userName, password, email, totalCoins);
  }
}
