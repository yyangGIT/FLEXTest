//====================Config====================//
//==========Parameter==========//
var BrowserType = "IE"; //IE,FF,Chrome
var DeplyTime = 1500; 
var DelayBig = DeplyTime*10;
var ReproExternal = 20;
var ReproInternal = 3;
var ExcelPath = "C:\\DDT_VSI.xls";

//==========Login==========//
var vSphere = "https://10.110.44.146:9443/vsphere-client/";
var UserName="pie\\myuan";
var Password="myuan";

//==========DataStore==========//
var HostIP="10.110.43.191";
var StorageName="000195900806";
var DSName = DateTimeToFormatStr(aqDateTime.Now(),"AutoDS%m%d_%H%M");//DataStore Name
var DSType,DSCapacity;
var DSCapacityUnit,DSMaxFile,DSVolumeType,StorageType,Pool,MaskView;


//var DSType,StorageType,StorageName,Pool,MaskView,MaxFile,Capacity,CapacityUnit,VolumeType
