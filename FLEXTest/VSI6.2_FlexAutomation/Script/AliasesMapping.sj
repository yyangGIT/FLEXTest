//====================Aliases for NameMapping====================//
//==========Basic==========//
var ObjVsphere = Aliases.browser.pageVsphere.objectContainerApp;
var CtrvSphere = ObjVsphere.iContainerApp.homecontainer;
var DropDownList = ObjVsphere.groupDropdown.scroller; //Global Dropdown list
var ButtonBack = CtrvSphere.homenavigator.ButtonBack; //return button
var CtrRefresh = ObjVsphere.iContainerApp.refreshbuttoncontainer; // if auto login,use pageLogin
//var CtrRefresh = Aliases.browser.pageLogin.objectContainerApp.iContainerApp.refreshbuttoncontainer; // if manul login,use pageVsphere

//==========Left List content==========//
var LabelvCenter = CtrvSphere.homenavigator.homeobjectnavigator.slidingviewstack.homeListview.scrollerContentscroller.vCenter; //vCenter label
var Labels_navi = CtrvSphere.homenavigator.homeobjectnavigator.slidingviewstack.inventoryListview.scrollerContentscroller.inventoryListLabels //vCenter page labels
var Objectlist = CtrvSphere.homenavigator.homeobjectnavigator.slidingviewstack.objectListView.selectedGrid.contentholder.objectlist;
var ObjScrollBar = CtrvSphere.homenavigator.homeobjectnavigator.slidingviewstack.objectListView.selectedGrid.scrollbar;

//==========Menu==========//
var Menu_action = ObjVsphere.actionMenu;      //vmware menu
var Menu_plugin = ObjVsphere.vsiPluginActions;  //plugin menu
var Menu_vcenter = ObjVsphere.vCenterActions // vcenter menu
var Menu_mytasks = ObjVsphere.menuMyTasks.MyTasks; // my tasks menu
var DialogYes = ObjVsphere.alertDialog.alertform.buttonYes;  // Dialog Yes Button

//==========Panel==========//
var Ctr_btn_newDS = ObjVsphere.newDatastorePanel.FooterPanel.FooterContainer; // new dateastore button
var Ctr_panel_newDS = ObjVsphere.newDatastorePanel.BodyPanel.BodyContainer; // new datastore container

//==========My Recent Tasks==========//
var TabRunning = CtrvSphere.appsidebar.portletRightSide.portletRecentTasks.tabbarState.tabRunning; //tab ruuning
var TabFail = CtrvSphere.appsidebar.portletRightSide.portletRecentTasks.tabbarState.tabFailed; //tab ruuning
var ButtonMyTasks = CtrvSphere.appsidebar.portletRightSide.portletRecentTasks.ButtonMyTasks; //mytaks button
var RecentTaskList = CtrvSphere.appsidebar.portletRightSide.portletRecentTasks.listRecentTasks;  // running task list

//==========DataStore Summary Page==========//
var LabelSummary = CtrvSphere.skinnablecontainer.tabbarContainer.tabbar.tabSummary; // summary label
var Ctr_Summary_newDS=CtrvSphere.skinnablecontainer.tabbarContainer.boxDatastoreSummary; // summary container




