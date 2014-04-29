//USEUNIT AliasesMapping
//USEUNIT BusinessFunc
//USEUNIT CallFunc
//USEUNIT Config
//USEUNIT UIAdapter
//====================TC_VMAX_002 VMAX VMFS Datastore Provision – DataDriven ====================//

function TC_VMAX_002()
{   
  CallFunc.DDTFun("DataStore",LoadData,Operation_DataStore); 
}


function LoadData()
{
  Config.DSType=DDT.CurrentDriver.Value(1);
  Config.DSCapacity=aqConvert.VarToStr(DDT.CurrentDriver.Value(2));
  //return DDT.CurrentDriver.Value(0);
}


function Operation_DataStore()
{
  BusinessFunc.Login();
  BusinessFunc.GotoVcenterHome();
  BusinessFunc.SelectHost();
  BusinessFunc.ClickVsiPlugin();
  BusinessFunc.CreateDataStore();  
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
  
  CheckProperty(Ctr_Summary_newDS.portContainer.portSystem.textStorageName, "Caption", cmpEqual, Config.StorageName);
  CheckProperty(Ctr_Summary_newDS.portContainer.portDevice.textTotalCapacity, "Caption", cmpContains, Config.DSCapacity);  
  CheckProperty(Ctr_Summary_newDS.portContainerportDevice.textTotalCapacity, "Caption", cmpContains, "GB"); 
  
  BusinessFunc.DeleteDataStore(ds);
  CheckTaskState(40000);
  
  //BusinessFunc.BacktoDataStorePage();
  //ds = FindChildInScollBar(ObjScrollBar.scrollthumb,ObjScrollBar.buttonDown,true,Objectlist,Config.DSName);  
  
  UIAdapter.CloseBrowser();
  UIAdapter.LogSummary();
   
} 