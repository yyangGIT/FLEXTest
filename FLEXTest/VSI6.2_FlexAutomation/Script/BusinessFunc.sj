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
function SelectVcenterItem()
{
  switch ( aqString.ToLower(Config.vCenterItem) )
  {
    case "host":UIAdapter.Click_Func(AliasesMapping.Labels_navi.Hosts,"Hosts Label");break;
    case "folder":UIAdapter.Click_Func(AliasesMapping.Labels_navi.Hosts,"Hosts Label");break;// folder?
    case "cluster":UIAdapter.Click_Func(AliasesMapping.Labels_navi.Clusters,"Clusters Label");break;
    case "datacenter":UIAdapter.Click_Func(AliasesMapping.Labels_navi.Datacenters,"Datacenters Label");break;  
  } 
  UIAdapter.WaitForElement(CtrRefresh,true); 
  var item = FindChildByName(Objectlist,Config.vCenterItemValue)
  UIAdapter.ClickR_Func(host,Config.vCenterItem+Config.vCenterItemValue);
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
 * Create DataStore preparation for DSName, DSType
 *
 * @param None
 * @return None
 */
function Create_DataStore()
{
  Config.DSName = DateTimeToFormatStr(aqDateTime.Now(),"AutoDS%m%d_%H%M");
  Log.AppendFolder("Create Datastore: "+Config.DSName);
  Click_Func(Menu_plugin.NewDataStore,"Create Datastore");
  UIAdapter.WaitForElement(CtrRefresh,true);
  
  SendKeys(Ctr_panel_newDS.TextInputDatastoreName,Config.DSName,"DatastoreNameTextBox");
  VerifyPanelButton(Ctr_btn_newDS,false,true,false,true);
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton"); 
  
  FindChildByID(Ctr_panel_newDS,Ctr_panel_newDS.radiobuttonVmfs.ObjectIdentifier);
  if (aqString.Find(Config.DSType,"VMFS",0,false)>-1) 
    Click_Func(Ctr_panel_newDS.RadiobuttonVmfs, "VMFS");
  if (aqString.Find(Config.DSType,"NFS",0,false)>-1)
    Click_Func(Ctr_panel_newDS.RadiobuttonVmfs, "NFS");
  VerifyPanelButton(Ctr_btn_newDS,true,true,false,true);
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton");
  
}

 /*
 * Create VMAC Datastore Action for array, pool, maskview, capacity
 *
 * @param None
 * @return None
 */
function CreateVMAX_DataStore()
{
  Create_DataStore();
  
  //select VMAX Storage    
  FindChildByID(Ctr_panel_newDS,Ctr_panel_newDS.StoragegridView.ObjectIdentifier);  
  var storage = FindChildByName(Ctr_panel_newDS.StoragegridView.StoragegridContent.StoragegridContainer,Config.VmaxStorage);
  Click_Func(storage, "select storage "+storage.Caption);
  VerifyPanelButton(Ctr_btn_newDS,true,true,false,true);
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton");
   
  //select VMAX Pool
  FindChildByID(Ctr_panel_newDS,Ctr_panel_newDS.PoolgridView.ObjectIdentifier);  
  var poolid = FindChildByName(Ctr_panel_newDS.PoolgridView.PoolgridContent.PoolgridContainer,Config.VmaxPool);
  Click_Func(poolid, "select pool "+poolid.Caption);
  VerifyPanelButton(Ctr_btn_newDS,true,true,false,true);
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton");
  
  //select VMAX MaskView
  FindChildByID(Ctr_panel_newDS,Ctr_panel_newDS.MaskingViewgridView.ObjectIdentifier); 
  var maskview = FindChildByName(Ctr_panel_newDS.MaskingViewgridView.MaskingViewgridContent.MaskingViewgridContainer,Config.VmaxMaskView);
  Click_Func(maskview, "select maskingview "+maskview.Caption);
  VerifyPanelButton(Ctr_btn_newDS,true,true,false,true);
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton");
 
  //select VMFS Version
  if (aqString.Find(Config.DSType,"VMFS",0,false)>-1)
  {
    FindChildByID(Ctr_panel_newDS,Ctr_panel_newDS.radiobuttonVmfs_5.ObjectIdentifier);
    if (Config.DSType=="VMFS5") 
    {
       Click_Func(Ctr_panel_newDS.RadiobuttonVmfs_5, Config.DSType);//vmfs_5
       CheckProperty(Ctr_panel_newDS.DropdownlistMaxFileSize,"Enabled", cmpEqual, "False");
    }     
    if (Config.DSType=="VMFS3")
    {
      Click_Func(Ctr_panel_newDS.RadiobuttonVmfs_3, Config.DSType);//vmfs_3
      CheckProperty(Ctr_panel_newDS.DropdownlistMaxFileSize,"Enabled", cmpEqual, "True");
    }
  }
  if (Config.DSBlockSize !=null)// !!!!!if blank
  {
    Click_Func(Ctr_panel_newDS.DropdownlistMaxFileSize,"Maximum File Size");
    var blocksize = FindChildByName(DropDownList,"*"+Config.DSBlockSize); //!!!!!!  * find
    Click_Func(blocksize,"Choose BlockSize"+Config.DSBlockSize);  
  }
  VerifyPanelButton(Ctr_btn_newDS,true,true,false,true); 
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton");

  //select VMAX Capacity  
  FindChildByID(Ctr_panel_newDS,Ctr_panel_newDS.TextInputVmfscapacity.ObjectIdentifier); 
  SendKeys(Ctr_panel_newDS.TextInputVmfscapacity,Config.DSCapacity,"CapacityTextBox");   
  Click_Func(Ctr_panel_newDS.DropdownlistVmfsCapacity,"Capacity Unit");
  var unit = FindChildByName(DropDownList,Config.DSUnit); 
  Click_Func(unit,"Choose Capacity Unit"); 
  if (aqString.Find(Config.DSMetaType,"Concatenated",0,false)>-1)
  {
     Click_Func(Ctr_panel_newDS.RadiobuttonConcatenated,"Concatenated"); 
  
  }
  if (aqString.Find(Config.DSMetaType,"Striped",0,false)>-1)
  {
    Click_Func(Ctr_panel_newDS.RadiobuttonStriped,"Striped"); 
  }
  VerifyPanelButton(Ctr_btn_newDS,true,true,false,true);
  Click_Func(Ctr_btn_newDS.ButtonNext, "NextButton");
  
  
  //DSUnit,DSBlockSize,DSMetaType;//////////// 
  //add verify
  
  var dsname  = FindChildByName(Ctr_panel_newDS,Config.DSName);
  var dstype  = FindChildByName(Ctr_panel_newDS,Config.DSType);
  var dsstorage  = FindChildByName(Ctr_panel_newDS,Config.VmaxStorage);
  var dsmaskview = FindChildByName(Ctr_panel_newDS,Config.VmaxMaskView);
  var dspool  = FindChildByName(Ctr_panel_newDS,Config.VmaxPool);
  var dsmeta  = FindChildByName(Ctr_panel_newDS,Config.DSMetaType);
  var dsname  = FindChildByName(Ctr_panel_newDS,Config.DSName);
  
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

/*
 * Goto host page
 *
 * @param None
 * @return None
 */
function SelectVirtualMachine()
{
  UIAdapter.Click_Func(AliasesMapping.Labels_navi.VirtualMachines,"Virtual machines Label");
  UIAdapter.WaitForElement(CtrRefresh,true); 
  var VM = FindChildByName(Objectlist,Config.VMName)
  UIAdapter.ClickR_Func(VM,"VM"+VM.Caption);
  UIAdapter.WaitForElement(CtrRefresh,true);
}



 /*
 * Create RDM in the new datastore panel
 *
 * @param None
 * @return None
 */
function CreateRDM()
{
 // Config.DSName = DateTimeToFormatStr(aqDateTime.Now(),"AutoDS%m%d_%H%M");
  //Log.AppendFolder("Create Datastore: "+Config.DSName);
  Click_Func(Menu_plugin.NewRDM,"Create RDM");
  UIAdapter.WaitForElement(CtrRefresh,true);

}

