//USEUNIT Config
//USEUNIT Report
//====================DDT and Cmd Function====================//
/*
 * DDT Driver
 *
 * @sheetName {String} sheet name of excel
 * @LoadData {Function} load the data
 * @Operation {Function} do the test operation
 * @return None
 */
function DDTFun(sheetName,LoadData,Operation)
{
  aqString.ListSeparator="_";
  var category= aqString.GetListItem(sheetName,1);
  var num=0;
  var errCount = Log.ErrCount;
  DDT.ExcelDriver(Config.DataPath,sheetName,true);
  while (! DDT.CurrentDriver.EOF() ) 
   {
    LoadData();
    Log.AppendFolder("Log ["+sheetName+"] DataDriven "+num);
    //DDT.CurrentDriver.DriveMethod(this.Operation);
    Operation();
    errCount = Report.ReportManul(category,Config.ManulCases,errCount);
    
    Log.PopLogFolder();
    DDT.CurrentDriver.Next();
    num++;
    //Delay(DelayBig);
  }
  DDT.CloseDriver(DDT.CurrentDriver.Name);
}
