//USEUNIT Config
//====================Basic UI Function====================//
//*****Basic UI function*****//
 /*
 * Start the Browser 
 *
 * @param None
 * @return None
 */
function SetBrowser()
{
  var Browser;
  switch (BrowserType)
  {
    case "IE": Browser=Browsers.Item(btIExplorer);break;
    case "FF":Browser=Browsers.Item(btFirefox);break;
    case "Chrome":Browser=Browsers.Item(btChrome);break;
    default:Browser=Browsers.Item(btIExplorer);break;
  }
  Browser.Run(Config.vSphere);
  Aliases.browser.BrowserWindow.Maximize();
}

 /*
 * Click accpet for IE 
 *
 * @param None
 * @return None
 */
function AcceptCertificate()
{
  if (BrowserType == "IE")
  {
    Aliases.browser.pageLogin.linkOverridelink.Click();
  }
  Delay(DelayBig+DeplyTime);
}

 /*
 * Wait for Element to show or hide
 *
 * @param element {Object} UI element
 * @param flag {Boolean} true-->visible, false--invisible
 * @return None
 */
function WaitForElement(element,flag)
{ 
  var count=0;
  for(var index=0;index<ReproExternal;index++)
  {
    var vis = element.Visible;
    if (flag && element.Visible)
    {
      count++;
      if (count>ReproInternal)
      { 
        break;  
      } 
      Delay(DeplyTime);       
    } 
    else
    {
      Delay(DelayBig);
    }   
  }
}

 /*
 * Wait to find Element disappeared
 *
 * @param Parent {Object} Parent Element
 * @param id {String} ObjectIdentifier value of Child element
 * @return None
 */
function NoChildElement(Parent,id)
{
    var find;
    for(var index=0;index<ReproExternal;index++)
    {
      find = Parent.FindChild("ObjectIdentifier",id);
      if (!find.Exists)
      {
        break;  
      } 
      Delay(DelayBig);
    }
}

 /*
 * Wait to find Element
 *
 * @param Parent {Object} Parent Element
 * @param value {String} value of the Child property 
 * @param property {String} property of Child 
 * @return find {Object} Child element
 */
function FindChildElement(Parent,value,property)
{
    var find;
    for(var index=0;index<ReproExternal;index++)
    {
      find = Parent.FindChild(property,value);
      if (find.Exists)
      {
        return find
      } 
      Delay(DelayBig);
    }
}

 /*
 * Wait to find Element
 *
 * @param Parent {Object} Parent Element
 * @param id {String} ObjectIdentifier value of Child element 
 * @return find {Object} Child element
 */
function FindChildByID(Parent,id)
{
    return FindChildElement(Parent,id,"ObjectIdentifier")    
}

 /*
 * Wait to find Element
 *
 * @param Parent {Object} Parent Element
 * @param name {String} Caption value of Child element 
 * @return find {Object} Child element
 */
function FindChildByName(Parent,name)
{
    return FindChildElement(Parent,name,"Caption")  
}

 /*
 * SendKeys and multiple check
 *
 * @param obj {Object} object to input
 * @param text {String} value to input 
 * @return None
 */
function SendKeys(obj,text,name)
{
    Click_Func(obj,name);
    Delay(DeplyTime);
    if (obj.Caption!="")
    {
      Keys_Func(obj,name,"^a[Del]");
      Delay(DeplyTime);
    }
    //var str = VarToStr(text);
    for(var index=0;index<ReproExternal;index++)
    {    
      //obj.Keys(text); 
      Keys_Func(obj,name,text);
      Delay(DeplyTime);    
      if (obj.Caption==text)    
      {
        break;        
      }    
      else
      {
        //obj.Click();
        //obj.Keys("^a[Del]");
        Click_Func(obj,name);
        Keys_Func(obj,name,"^a[Del]");
        obj.Parent.Refresh();
        Delay(DeplyTime);
      }
    }
}

 /*
 * Scroll the bar until the child is found
 *
 * @param scrollthumb {Object} object to check whether it is end
 * @param endbtn {Object} the scroll button to click 
 * @param flag {Boolean} true-->Height, false--Width
 * @param Parent {Object} Parent Element
 * @param name {String} Caption value of Child element 
 * @return find {Object} Child element
 */
function FindChildInScollBar(scrollthumb,endbtn,flag,Parent,name)
{
   var find;
   if (flag)// if true, it is a vertical scrollbar
   {
      Log.LockEvents();
      while (endbtn.Top>scrollthumb.Top+scrollthumb.Height)
      {
          endbtn.Click();
          find = Parent.FindChild("Caption",name);
          if (find.Exists&&find.VisibleOnScreen)
          {
            Log.UnlockEvents();
            Click_Func(endbtn,"ScollBar Button");
            return find;
          }
      }
   }
   else // it is a horizontal scrollbar
   {
      while (endbtn.Left>scrollthumb.Left+scrollthumb.Width)
      {
          endbtn.Click();
          find = Parent.FindChild("Caption",name);
          if (find.Exists&&find.VisibleOnScreen)
          {
            endbtn.Click();
            return find;
          }
      }
   }
}

 /*
 * Close the Browser
 *
 * @param None
 * @return None
 */
function CloseBrowser()
{
  Aliases.browser.BrowserWindow.Close();
}

 /*
 * Close the process
 *
 * @param name {String} the process name to end 
 * @return None
 */
function CloseProcess(name)
{
  var p = Sys.FindChild("ProcessName", name);
  while (p.Exists)
  {
    p.Close();
    var isClosed = p.WaitProperty("Exists",false,DeplyTime);
    if (! isClosed)
      p.Terminate();
    p = Sys.FindChild("ProcessName", name);
  }
}

 /*
 * Click action add log 
 *
 * @param obj {Object} object to click
 * @param name {String} object name to click 
 * @return None
 */
function Click_Func(obj,name)
{
  Log.Event("Click: "+name,LogFormat(obj,name),pmNormal,null, Sys.Desktop.FocusedWindow().Picture());
  //Log.AppendFolder("Click: "+ name,LogFormat(obj,name));
  Log.LockEvents();
  obj.Click();
  Log.UnlockEvents();
  //Log.PopLogFolder();    
} 

 /*
 * Right Click action add log 
 *
 * @param obj {Object} object to right click
 * @param name {String} object name to right click 
 * @return None
 */
function ClickR_Func(obj,name)
{
  Log.Event("Right click: "+name,LogFormat(obj,name),pmNormal,null,Sys.Desktop.FocusedWindow().Picture());
  //Log.AppendFolder("Right click: "+name,LogFormat(obj,name));
  Log.LockEvents();
  obj.ClickR();
  Log.UnlockEvents();
  //Log.PopLogFolder();  

}

 /*
 * Right Click action add log 
 *
 * @param obj {Object} object to right click
 * @param name {String} object name to right click 
 * @param text {String} value to send keys 
 * @return None
 */
function Keys_Func(obj,name,text)
{  
  Log.Event("Send keys: "+text+" To: "+ name,LogFormat(obj,name),pmNormal,null,Sys.Desktop.FocusedWindow().Picture());
  //Log.AppendFolder("Send keys: "+text+" To: "+ name,LogFormat(obj,name));
  Log.LockEvents();
  obj.Keys(text);
  Log.UnlockEvents();
  //Log.PopLogFolder();  
}

 /*
 * Log Format 
 *
 * @param obj {Object} object to log
 * @param name {String} name to log 
 * @return format string
 */
function LogFormat(obj,name)
{
    var str= "MappedName: "+(obj.MappedName==null)?"":obj.MappedName;
    str+="\r\nFullname: "+obj.Fullname;
    str+="\r\ObjectType: "+obj.ObjectType;
    str+="\r\Caption: "+(obj.Caption==null)?"":obj.Caption;
    return str
}

 /*
 * Summarize the log
 *
 * @param None
 * @return None
 */
function LogSummary()
{
  if (Log.ErrCount>0)
    Log.Warning("ErrorCount: "+Log.ErrCount,"",pmHighest); 
  else
    Log.Checkpoint("CheckpointCount: "+Log.CheckpointCount,"",pmHighest); 
}


