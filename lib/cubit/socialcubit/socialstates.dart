abstract class socialappstate {}

//home screen
class SocialappHOMEinitialstate extends socialappstate {}

class SocialappHOMEloadingstate extends socialappstate {}

class SocialappHOMEsuccessstate extends socialappstate {

}
//settings
class SocialappSETTINGinitialstate extends socialappstate {}

class SocialappSETTINGloadingstate extends socialappstate {}

class SocialappSETTINGsuccessstate extends socialappstate {

}

class Socialappbottomnavstate extends socialappstate {

}
//get user
class SocialappGETUSERinitialstate extends socialappstate {}

class SocialappGETUSERloadingstate extends socialappstate {}

class SocialappGETUSERsuccessstate extends socialappstate {

}
class SocialappGETUSERERRORstate extends socialappstate {
  String? error;
  SocialappGETUSERERRORstate( this.error);

}
//UPDATE USER
class SocialappUPDATEUSERinitialstate extends socialappstate {}
class SocialappUPDATEUSERLoadingstate extends socialappstate {}
class SocialappUPDATEUSERsuccessstate extends socialappstate {}
class SocialappUPDATEUSERERRORstate extends socialappstate {
  String? error;
  SocialappUPDATEUSERERRORstate( this.error);

}
//like post
class SocialappLIKEPOSTsuccessstate extends socialappstate {}
class SocialappLIKEPOSTERRORstate extends socialappstate {
  String? error;
  SocialappLIKEPOSTERRORstate( this.error);

}
//UPLOAD PROFILE IMAGE
class SocialappUPLOADPROFILEIMAGELOADINGstate extends socialappstate {}

class SocialappUPLOADPROFILEIMAGESuccessstate extends socialappstate {}
class SocialappUPLOADPROFILEIMAGEERRORstate extends socialappstate {
  String? error;
  SocialappUPLOADPROFILEIMAGEERRORstate( this.error);

}
//GET PROFILE IMAGE
class SocialappGETPROFILEIMAGELOADINGstate extends socialappstate {}

class SocialappGETPROFILEIMAGESuccessstate extends socialappstate {}
class SocialappGETPROFILEIMAGEERRORstate extends socialappstate {
  String? error;
  SocialappGETPROFILEIMAGEERRORstate( this.error);

}
//CREATE POST
class SocialappCreatePostinitialstate extends socialappstate {}

class SocialappCreatePostloadingstate extends socialappstate {}

class SocialappCreatePostsuccessstate extends socialappstate {

}
class SocialappCreatePostERRORstate extends socialappstate {
  String? error;
  SocialappCreatePostERRORstate( this.error);

}
//getcomments


class SocialappGETCOMMENTSSLOADINGstate extends socialappstate {}

class SocialappGETCOMMENTSSuccessstate extends socialappstate {

}
class SocialappGETCOMMENTSSERRORstate extends socialappstate {
  String? error;
  SocialappGETCOMMENTSSERRORstate( this.error);

}
//post comment

class SocialappCREATECOMMENTinitialstate extends socialappstate {}

class SocialappCREATECOMMENTloadingstate extends socialappstate {}

class SocialappCREATECOMMENTsuccessstate extends socialappstate {

}
class SocialappCREATECOMMENTERRORstate extends socialappstate {
  String? error;
  SocialappCREATECOMMENTERRORstate( this.error);

}

//GET POST IMAGE
class SocialappGETPostIMAGELOADINGstate extends socialappstate {}

class SocialappGETPostIIMAGESuccessstate extends socialappstate {}
class SocialappGETPostIIMAGEERRORstate extends socialappstate {
  String? error;
  SocialappGETPostIIMAGEERRORstate( this.error);

}
//CREATE POST IMAGE
class SocialappCreatePostImageLOADINGstate extends socialappstate {}

class SocialappCreatePostImageSuccessstate extends socialappstate {}
class SocialappCreatePostImageERRORstate extends socialappstate {
  String? error;
  SocialappCreatePostImageERRORstate( this.error);

}
//GET POSTS
class SocialappGETPOSTSinitialstate extends socialappstate {}

class SocialappGETPOSTSLOADINGstate extends socialappstate {}

class SocialappGETPOSTSSuccessstate extends socialappstate {}
class SocialappGETPOSTSERRORstate extends socialappstate {
  String? error;
  SocialappGETPOSTSERRORstate( this.error);

}
class SocialappRemovePostImagestate extends socialappstate {}