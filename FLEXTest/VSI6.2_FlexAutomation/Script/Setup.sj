//====================Test Setup common function====================//

/*
 * Login the vSphere and redirect the page
 *
 * @param None
 * @return None
 */
function Login()
{
  SetBrowser();
  AcceptCertificate();
  var page =Aliases.browser.pageLogin
  var Obj=FindChildByID(page,"container_app");
  var UI=FindChildByID(Obj,"UI1");
  var loginform = UI.Form("loginForm");
  //loginform.TextInput("usernameTextInput").Keys(UserName);
  SendKeys(loginform.TextInput("usernameTextInput"),Config.UserName);
  //loginform.TextInput("passwordTextInput").Keys(Password); 
  SendKeys(loginform.TextInput("passwordTextInput"),Config.Password);
  loginform.Button("loginButton").Click();
  NoChildElement(UI,"loginForm"); // wait for loginform disappearing
}