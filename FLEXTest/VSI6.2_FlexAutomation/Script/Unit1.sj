function cmdTestPowerCLI()
{
  //var cmdline="powershell.exe";
  var cmdline="C:\\Test\\PsAgent.exe  C:\\Test\\Temp\\test.txt C:\\Test\\Temp\\conf.txt";
  var WScriptObj = Sys.OleObject("WScript.Shell");
  var Exec = WScriptObj.Exec(cmdline);
  var result = WaitForExecution(Exec,5000);
  
}

function cmdTestNaviCLI()
{
  var cmdline="C:\\Test\\PsAgent.exe  C:\\Test\\Temp\\Navitest.txt C:\\Test\\Temp\\Naviconf.txt";
  var WScriptObj = Sys.OleObject("WScript.Shell");
  var Exec = WScriptObj.Exec(cmdline);
  var result = WaitForExecution(Exec,5000);
  
}


function cmdTestRest()
{
  var cmdline="C:\\Test\\PsAgent.exe  C:\\Test\\Temp\\Resttest.txt C:\\Test\\Temp\\Restconf.txt";
  var WScriptObj = Sys.OleObject("WScript.Shell");
  var Exec = WScriptObj.Exec(cmdline);
  var result = WaitForExecution(Exec,5000);
  
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

