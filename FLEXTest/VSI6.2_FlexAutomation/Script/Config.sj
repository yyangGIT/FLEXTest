//====================Config====================//
//==========Parameter==========//
var BrowserType = "IE"; //IE,FF,Chrome
var DeplyTime = 1500; //1s
var DelayBig = 5*DeplyTime; //5s
var ReproExternal = 10;
var ReproInternal = 3;

//==========Login==========//
var vSphere = "https://10.110.44.146:9443/vsphere-client/";
var UserName="pie\\myuan";
var Password="myuan";

//==========DataStore==========//
var HostIP="10.110.43.191";
var StorageName="000195900806";
var DSName = DateTimeToFormatStr(aqDateTime.Now(),"AutoDS%m%d_%H%M");//DataStore Name
var DSType = "VMFS5";
var DSCapacity = "1";