//USEUNIT CallFunc
function cmdTest()
{
  //var cmdline="powershell.exe";

  
  
}

function WaitForExecution(Exec,sleep)
{
  for(var index=0;index<10;index++)
  {
    if (Exec.Status ==1)
    { 
      var ret = Exec.StdOut.ReadAll();
      return ret;
    } 
    Delay(sleep);       
  }
}
function aaa()
{
  Log.Event("event aaa");
}

function callaa(bbb)
{
 var b =  GetMethods(bbb).Name;
Log.error(bbb.Name);
}



function Record1()
{
  //Opens the specified URL in a running instance of the specified browser.
  Browsers.Item(btIExplorer).Navigate("https://10.110.44.146:9443/vsphere-client/#extensionId=vsphere.core.viHosts.domainView");
  //Clicks at point (65, 9) of the 'labelLabeldisplay' object.
  Aliases.browser.pageVsphere.objectContainerApp.groupDropdown2.scroller.labelLabeldisplay.Click(65, 9);
  //Clicks at point (74, 4) of the 'labelLabeldisplay2' object.
  Aliases.browser.pageVsphere.objectContainerApp.groupDropdown2.scroller.labelLabeldisplay2.Click(74, 4);
  //Clicks at point (56, 7) of the 'DropdownlistMaxFileSize' object.
  Aliases.browser.pageVsphere.objectContainerApp.newDatastorePanel.BodyPanel.BodyContainer.DropdownlistMaxFileSize.Click(56, 7);
  //Clicks at point (58, 4) of the 'labelLabeldisplay3' object.
  Aliases.browser.pageVsphere.objectContainerApp.groupDropdown2.scroller.labelLabeldisplay3.Click(58, 4);
}