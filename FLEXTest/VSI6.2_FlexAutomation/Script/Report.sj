//USEUNIT ExcelAdapter
//USEUNIT Config


//var Excel = new ExcelClass(Config.ReportPath);
//var arrSheets = new Array("Automation","Manul");
//Excel.CreateFile(null, arrSheets);
//Excel.InitReport("Automation");
//Excel.InitReport("Manul");

function AddTestCases(sheet,type,list)
{
  var arr = GetCasesRow(sheet,type);//arr.contians the list?
  var row =arr.length+1;//next row to be added
  var col = GetCasesCol(type);
  aqString.ListSeparator=",";  
  for (var i = 0; i < aqString.GetListLength(list); i++)
  {
    Excel.Write(sheet,row+i,col,aqString.GetListItem(list, i));
  }
}


function AddTableValue (sheet,storage,type,val)
{
   var row = GetTableRow(storage);
   var col = GetTalbeCol(type);
   Excel.Write(sheet, row, col, val);
}



function GetTableRow(storage)
{
  var row;
   switch (storage)
   {
      case "VMAX":row=2;break;
      case "VNX":row=3;break;
      case "VIPR":row=4;break;
      case "XIO":row=5;break;
      default :row=2;break;   
   }
   return row;
}

function GetTalbeCol(type)
{
   var col;
   switch (type)
   {
      case "Exec":col='B';break;
      case "Pass":col='C';break;
      case "Fail":col='D';break;
      default :col='B';break;   
   } 
   return col;
}

function GetCasesCol(type)
{
   var col;
   switch (type)
   {
      case "Pass":col='G';break;
      case "Fail":col='H';break;
      default :col='I';break;   
   } 
   return col;
}

function GetCasesRow(sheet,type)
{
   var col = GetCasesCol(type);
   var arr= Excel.ReadCol(sheet,col,null);
   return arr;
}


function GetTableValue (sheet,storage,type)
{
   var row = GetTableRow(storage);
   var col = GetTalbeCol(type);
   var ret = Excel.Read(sheet, row, col);
   return ret;
}

function ReportAutomation(catagory,casename)
{
  if (Log.ErrCount!=0)
  {
    var fail = GetTableValue("Automation",catagory,"Fail");
    AddTableValue("Automation",catagory,"Fail",fail+1);
    AddTestCases("Automation","Fail",casename);
  }
  else
  {
    var pass = GetTableValue("Automation",catagory,"Pass");
    AddTableValue("Automation",catagory,"Pass",pass+1); 
    AddTestCases("Automation","Pass",casename);    
  } 
   var exec = GetTableValue("Automation",catagory,"Exec");
   AddTableValue("Automation",catagory,"Exec",exec+1);
}


function ReportManul(category,list,errCount)
{
  
  aqString.ListSeparator=",";
  var len = aqString.GetListLength(list)-1;// column name need to be removed
  if (errCount !=Log.ErrCount)
  {      
    errCount = Log.ErrCount;
    var fail = GetTableValue("Manul",category,"Fail");
    AddTableValue("Manul",category,"Fail",fail+len);
    AddTestCases("Manul","Fail",list);
  }
  else
  {
    var pass = GetTableValue("Manul",category,"Pass");
    AddTableValue("Manul",category,"Pass",pass+len);
    AddTestCases("Manul","Pass",list);
  } 
  var exec = GetTableValue("Manul",category,"Exec");
  AddTableValue("Manul",category,"Exec",exec+len); 
  
  return errCount
}
