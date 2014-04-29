//USEUNIT AliasesMapping
//USEUNIT Config
//USEUNIT UIAdapter
//====================Business common function====================//
//*****Basic business logic function*****//

 /*
 * Login the vSphere and redirect the page
 *
 * @param None
 * @return None
 */
function Login()
{
  UIAdapter.CloseProcess("iexplore");
  SetBrowser();
  AcceptCertificate();
  Log.AppendFolder("Login: "+Config.UserName);
  var UI = Aliases.browser.pageLogin.objectContainerApp.iContainerApp;
  SendKeys(UI.Loginform.TextInput("usernameTextInput"),Config.UserName,"UsernameTextBox");
  SendKeys(UI.Loginform.TextInput("passwordTextInput"),Config.Password,"PasswordTextBox");
  UIAdapter.Click_Func(UI.loginform.Button("loginButton"),"loginButton");  
  NoChildElement(UI,"loginForm"); // wait for loginform disappearing
  Log.PopLogFolder();
}

/*
 * Goto vCenter Home
 *
 * @param None
 * @return None
 */
function GotoVcenterHome()
{
  UIAdapter.Click_Func(AliasesMapping.LabelvCenter,"vCenter Label");
  UIAdapter.WaitForElement(CtrRefresh,true);
}

/*
 * Goto host page
 *
 * @param None
 * @return None
 */
function SelectHost()
{
  UIAdapter.Click_Func(AliasesMapping.Labels_navi.Hosts,"Hosts Label");
  UIAdapter.WaitForElement(CtrRefresh,true); 
  var host = FindChildByName(Objectlist,Config.HostIP)
  UIAdapter.ClickR_Func(host,"host"+host.Caption);
  UIAdapter.WaitForElement(CtrRefresh,true);
}

/*
 * Right Click Host and choose VSI Plugin
 *
 * @param None
 * @return None
 */
function ClickVsiPlugin()
{ 
  if (!Menu_action.Exists)
  {
    Delay(DelayBig);  
  }
  FindChildByName(Menu_action,"All EMC VSI Plugin Actions");
  UIAdapter.Click_Func(Menu_action.menuVsiPlugin,"menu vsiPlugin");
}

 /*
 * Delete Datastore 
 *
 * @param ds {object} datastore to remove
 * @return None
 */
function DeleteDataStore(ds)
{
  Log.AppendFolder("Delete Datastore: "+ds.Caption);
  UIAdapter.ClickR_Func(ds,ds.Caption);
  UIAdapter.WaitForElement(CtrRefresh,true);
  UIAdapter.Click_Func(Menu_action.menuVcenter,"menu vCenter");
  UIAdapter.Click_Func(Menu_vcenter.DeleteDatastore,"Delete Datastore");
  WaitForElement(CtrRefresh,true);
  UIAdapter.Click_Func(DialogYes,"Dialog Yes");
  UIAdapter.WaitForElement(CtrRefresh,true);
  Log.PopLogFolder();
} 


 /*
 * Create Datastore in the new datastore panel
 *
 * @param None
 * @return None
 */
function CreateDataStore()
{
  Config.DSName = DateTimeToFormatStr(aqDateTime.Now(),"AutoDS%m%d_%H%M");
  Log.AppendFolder("Create Datastore: "+Config.DSName);
  Click_Func(Menu_plugin.NewDataStore,"Create Datastore");
  UIAdapter.WaitForElement(CtrRefresh,true);
  
  SendKeys(Ctr_panel_newDS.TextInputDatastoreName,Config.DSName,"DatastoreNameTextBox");
  VerifyPanelButton(Ctr_btn_newDS,false,true,false,true);
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton");
  
  
  FindChildByID(Ctr_panel_newDS,Ctr_panel_newDS.radiobuttonVmfs.ObjectIdentifier);
  if (aqString.Contains(Config.DSType,"VMFS",0,false)>-1) 
    Click_Func(Ctr_panel_newDS.RadiobuttonVmfs, "VMFS");
  if (aqString.Contains(Config.DSType,"NFS",0,false)>-1)
    Click_Func(Ctr_panel_newDS.RadiobuttonVmfs, "NFS");
  VerifyPanelButton(Ctr_btn_newDS,true,true,false,true);
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton");
    
  FindChildByID(Ctr_panel_newDS,Ctr_panel_newDS.StoragegridView.ObjectIdentifier);  
  var storage = FindChildByName(Ctr_panel_newDS.StoragegridView.StoragegridContent.StoragegridContainer,Config.StorageName);
  Click_Func(storage, "select storage "+storage.Caption);
  VerifyPanelButton(Ctr_btn_newDS,true,true,false,true);
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton");
   
  FindChildByID(Ctr_panel_newDS,Ctr_panel_newDS.PoolgridView.ObjectIdentifier);  
  var poolid = FindChildByName(Ctr_panel_newDS.PoolgridView.PoolgridContent.PoolgridContainer,"VDI");//this is vmax pool grid!!!
  Click_Func(poolid, "select pool "+poolid.Caption);
  VerifyPanelButton(Ctr_btn_newDS,true,true,false,true);
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton");
  
  FindChildByID(Ctr_panel_newDS,Ctr_panel_newDS.MaskingViewgridView.ObjectIdentifier); 
  var maskview = FindChildByName(Ctr_panel_newDS.MaskingViewgridView.MaskingViewgridContent.MaskingViewgridContainer,"vpi_3191_3165");//mask view select
  Click_Func(maskview, "select maskingview "+maskview.Caption);
  VerifyPanelButton(Ctr_btn_newDS,true,true,false,true);
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton");
  
  if (aqString.Contains(Config.DSType,"VMFS",0,false)>-1)
  {
    FindChildByID(Ctr_panel_newDS,Ctr_panel_newDS.radiobuttonVmfs_5.ObjectIdentifier);
    if (Config.DSType=="VMFS5") 
      Click_Func(Ctr_panel_newDS.RadiobuttonVmfs_5, Config.DSType);//vmfs_5
    if (Config.DSType=="VMFS3")
      Click_Func(Ctr_panel_newDS.RadiobuttonVmfs_3, Config.DSType);//vmfs_3
  } 
  VerifyPanelButton(Ctr_btn_newDS,true,true,false,true); 
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton");
  
  FindChildByID(Ctr_panel_newDS,Ctr_panel_newDS.TextInputVmfscapacity.ObjectIdentifier); 
  SendKeys(Ctr_panel_newDS.TextInputVmfscapacity,Config.DSCapacity,"CapacityTextBox"); 
  VerifyPanelButton(Ctr_btn_newDS,true,true,false,true);
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton");
  
  //Ctr_btn_newDS.ButtonNext.Click();
  //add verify
  VerifyPanelButton(Ctr_btn_newDS,true,false,true,true); 
  Click_Func(Ctr_btn_newDS.buttonFinish, "FinishButton");
  UIAdapter.WaitForElement(CtrRefresh,true);
  Log.PopLogFolder();
}

 /*
 * Check the running tast state 
 *
 * @param sleep {int} delay time
 * @return None
 */
function CheckTaskState(sleep)
{
  Log.AppendFolder("Check Task State ");
  Click_Func(TabRunning, "Running Tab");
  Click_Func(ButtonMyTasks, "mytaskButton");
  Click_Func(Menu_mytasks, "my tasks menu"); 
  Delay(DelayBig);  
  var count=0;
  for(var index=0;index<ReproExternal;index++)
  {
    Delay(DeplyTime);  
    if (RecentTaskList.ItemCount==0)
    {
      count++;
      if (count>ReproInternal)
      {         
         Click_Func(TabFail, "Fail Tab");
         Click_Func(ButtonMyTasks, "mytaskButton");
         Click_Func(Menu_mytasks, "my tasks menu"); 
         if (RecentTaskList.ItemCount!=0)
         {
          Log.Error("Error in Task","",pmHigher,null,Sys.Desktop.FocusedWindow().Picture());
         }
         break;  
      }    
    } 
    else
    {
      Delay(sleep);
      Click_Func(ButtonMyTasks, "mytaskButton");
      Click_Func(Menu_mytasks, "my tasks menu"); 
      
    } 
  }
  Log.PopLogFolder();
}

 /*
 * Return and goback to the Datastore Page 
 *
 * @param None
 * @return None
 */
function BacktoDataStorePage()
{ 
  Click_Func(AliasesMapping.ButtonBack, "BackButton");
  Click_Func(AliasesMapping.Labels_navi.Datastores, "DataStores Label");
  WaitForElement(CtrRefresh,true);
}


 /*
 * Verify panel button Enable property
 *
 * @footer {Object} the container of the buttons
 * @back {Boolen} enabled property of back button
 * @next {Boolen} enabled property of next button
 * @finish {Boolen} enabled property of finish button
 * @cancel {Boolen} enabled property of cancel button
 * @return None
 */
function VerifyPanelButton(footer,back,next,finish,cancel)
{
  Log.AppendFolder("Check Enabled property of Buttons");
  var BtnBack =FindChildByName(footer,"Back");
  var BtnNext =FindChildByName(footer,"Next");
  var BtnFinish =FindChildByName(footer,"Finish");
  var BtnCancel =FindChildByName(footer,"Cancel");
  
  CheckProperty(BackBtn,"Enabled",cmpEqual,back); 
  CheckProperty(BtnNext,"Enabled",cmpEqual,next);  
  CheckProperty(BtnFinish,"Enabled",cmpEqual,finish);
  CheckProperty(BtnCancel,"Enabled",cmpEqual,cancel);
  Log.PopLogFolder();
}


