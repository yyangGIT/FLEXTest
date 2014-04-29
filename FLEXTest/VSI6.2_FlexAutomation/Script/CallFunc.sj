//USEUNIT Config
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
  DDT.ExcelDriver(Config.ExcelPath,sheetName);
  var num=0;
  while (! DDT.CurrentDriver.EOF() ) 
   {
    LoadData();
    Log.AppendFolder("Log "+DDT.CurrentDriver.Value(0)+num);
    Operation()
    Log.PopLogFolder();
    DDT.CurrentDriver.Next();
    num++;
    Delay(DelayBig);
  }
  DDT.CloseDriver(DDT.CurrentDriver.Name);
}
