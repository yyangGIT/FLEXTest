//USEUNIT AliasesMapping
//USEUNIT BusinessFunc
//USEUNIT Config
//USEUNIT UIAdapter
//====================Demo for DataStore Creating ,Verifying and Deleting====================//

function TC000_Demo()
{
  DDTFun(ReadFromDataStore,Operation_DataStore);
}

function DDTFun(Reader,Operation)
{
 var Interator =Reader()
 while (! DDT.CurrentDriver.EOF())
 {
  Interator()
  Log.AppendFolder("Start log\r\n", "");
  Operation()
  Log.PopLogFolder();
  DDT.CurrentDriver.Next();
 }
 DDT.CloseDriver(DDT.CurrentDriver.Name);
}

function ReadFromDataStore()
{
    var Driver = DDT.ExcelDriver("C:\\FileFormat.xls", "Sheet1");
    return ReadFromDataStoreInterator;
}

function ReadFromDataStoreInterator()
{
  Config.DSType=DDT.CurrentDriver.Value(2);
  Config.UserName=DDT.CurrentDriver.Value(0);
  Config.Password=DDT.CurrentDriver.Value(1);
  Config.DSCapacity=aqConvert.VarToStr(DDT.CurrentDriver.Value(3));
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
  //ds.Click();  
  UIAdapter.Click_Func(ds,Config.DSName);

  UIAdapter.WaitForElement(CtrRefresh,true);
  //AliasesMapping.LabelSummary.Click(); 
  UIAdapter.Click_Func(AliasesMapping.LabelSummary,"Summary"); 
  Delay(60000);
  UIAdapter.WaitForElement(CtrRefresh,true);

  CheckProperty(Ctr_Summary_newDS.portDetails.textDStype,"Caption", cmpEqual, Config.DSType);
  CheckProperty(Ctr_Summary_newDS.portSystem.textStorageName, "Caption", cmpEqual, Config.StorageName);
  CheckProperty(Ctr_Summary_newDS.portDevice.textTotalCapacity, "Caption", cmpContains, Config.DSCapacity);  
  CheckProperty(Ctr_Summary_newDS.portDevice.textTotalCapacity, "Caption", cmpContains, "GB"); 
  
  BusinessFunc.DeleteDataStore(ds);
  CheckTaskState(40000);
  
  //BusinessFunc.BacktoDataStorePage();
  //ds = FindChildInScollBar(ObjScrollBar.scrollthumb,ObjScrollBar.buttonDown,true,Objectlist,Config.DSName);  
  
  UIAdapter.CloseBrowser();
  UIAdapter.LogSummary();
  Delay(DelayBig);
   
} 