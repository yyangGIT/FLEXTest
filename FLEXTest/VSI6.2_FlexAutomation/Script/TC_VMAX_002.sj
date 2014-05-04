//USEUNIT AliasesMapping
//USEUNIT BusinessFunc
//USEUNIT CallFunc
//USEUNIT Config
//USEUNIT UIAdapter
//USEUNIT Report
//====================TC_VMAX_002 VMAX VMFS Datastore Provision – DataDriven ====================//

function TC_VMAX_002()
{   
  CallFunc.DDTFun("TC_VMAX_002",LoadData,Operation_DataStore);
  Report.ReportAutomation("VMAX","TC_VMAX_002");
}

function TC_VMAX_003()
{   
  CallFunc.DDTFun("TC_VMAX_003",LoadData,Operation_DataStore);
  Report.ReportAutomation("VMAX","TC_VMAX_003");
}


function LoadData()
{
  Config.DSType=DDT.CurrentDriver.Value(1);
  Config.DSCapacity=aqConvert.VarToStr(DDT.CurrentDriver.Value(2));
  
  
  
  var c = DDT.CurrentDriver.ColumnCount; 
  Config.ManulCases = DDT.CurrentDriver.Value(c-1);
  if  (Config.ManulCases == null)
    Config.ManulCases="";
}


function Operation_DataStore()
{
  return;
  BusinessFunc.Login();
  BusinessFunc.GotoVcenterHome();
  BusinessFunc.SelectVcenterItem();
  BusinessFunc.ClickVsiPlugin();
  BusinessFunc.CreateVMAX_DataStore();  
  BusinessFunc.CheckTaskState(60000);  
  BusinessFunc.BacktoDataStorePage();
    
  var ds;
  if (AliasesMapping.ObjScrollBar!=null&&AliasesMapping.ObjScrollBar.Visible)
  {
    ds = FindChildInScollBar(ObjScrollBar.scrollthumb,ObjScrollBar.buttonDown,true,Objectlist,Config.DSName);
  }
  else
  {
    ds = Objectlist.FindChild("Caption",Config.DSName);
  }
    
  CheckProperty(ds, "Caption", cmpEqual, Config.DSName);  
  UIAdapter.Click_Func(ds,Config.DSName);
  UIAdapter.WaitForElement(CtrRefresh,true);
  
  UIAdapter.Click_Func(AliasesMapping.LabelSummary,"Summary"); 
  UIAdapter.WaitForElement(CtrRefresh,true);

  CheckProperty(Ctr_Summary_newDS.labelDSName,"Caption", cmpEqual, Config.DSName);
  CheckProperty(Ctr_Summary_newDS.labelDSType,"Caption", cmpEqual, Config.DSType);
  CheckProperty(Ctr_Summary_newDS.portDetails.textDStype,"Caption", cmpEqual, Config.DSType);
  
  CheckProperty(Ctr_Summary_newDS.portContainer.portSystem.textStorageName, "Caption", cmpEqual, Config.VmaxStorage);
  CheckProperty(Ctr_Summary_newDS.portContainer.portDevice.textTotalCapacity, "Caption", cmpContains, Config.DSCapacity);  
  CheckProperty(Ctr_Summary_newDS.portContainerportDevice.textTotalCapacity, "Caption", cmpContains, Config.DSUnit); 
  
  BusinessFunc.DeleteDataStore(ds);
  CheckTaskState(40000);
  
  //BusinessFunc.BacktoDataStorePage();
  //ds = FindChildInScollBar(ObjScrollBar.scrollthumb,ObjScrollBar.buttonDown,true,Objectlist,Config.DSName);  
  
  UIAdapter.CloseBrowser();
  UIAdapter.LogSummary();
   
} 