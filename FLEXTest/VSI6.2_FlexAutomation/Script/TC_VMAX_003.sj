//USEUNIT AliasesMapping
//USEUNIT BusinessFunc
//USEUNIT CallFunc
//USEUNIT Config
//USEUNIT UIAdapter
//====================TC_VMAX_002 VMAX VMFS Datastore Provision – DataDriven ====================//

//Test23






function Operation_RDM()
{
  BusinessFunc.Login();
  BusinessFunc.GotoVcenterHome();
  BusinessFunc.SelectVirtualMachine();
  BusinessFunc.ClickVsiPlugin();
  BusinessFunc.CreateRDM();
}