abstract class appstate {}

class appinitialstate extends appstate {}

class apploadingstate extends appstate {}

class appsuccessstate extends appstate {

}
//...........................................................................................
//login
class appLOGINinitialstate extends appstate {}

class appLOGINloadingstate extends appstate {}

class appLOGINsuccessstate extends appstate {
  final String? uid;
  appLOGINsuccessstate(  this.uid);

}
class appLOGINerrorstate extends appstate {
  String? onerror;
  appLOGINerrorstate( onerror);

}
//...........................................................................................
//register
class appREGISTERinitialstate extends appstate {}

class appREGISTERloadingstate extends appstate {}

class appREGISTERsuccessstate extends appstate {

}
class appREGISTERerrorstate extends appstate {
  String? onerror;
  appREGISTERerrorstate(onerror);



}
//...........................................................................................
//create user
class appCREATEUSERinitialstate extends appstate {}

class appCREATEUSERloadingstate extends appstate {}

class appCREATEUSERsuccessstate extends appstate {

}
class appCREATEUSERerrorstate extends appstate {
  String? onerror;
  appCREATEUSERerrorstate(onerror);



}
//...........................................................................................
//Home screen
class appHOMEinitialstate extends appstate {}

class appHOMEloadingstate extends appstate {}

class appHOMEsuccessstate extends appstate {

}
//...........................................................................................
//settings page
class appSETTINGinitialstate extends appstate {}

class appSETTINGloadingstate extends appstate {}

class appSETTINGsuccessstate extends appstate {

}
//...........................................................................................
//bottom nav state
class appbottomnavstate extends appstate {

}