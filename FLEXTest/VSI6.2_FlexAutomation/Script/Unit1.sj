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



