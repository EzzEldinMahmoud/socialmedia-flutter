import 'package:chatapp/models/comment_model.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/models/user_model.dart';

import '../../models/post_model.dart';

abstract class socialappstate {}
//...........................................................................................
//home screen
class SocialappHOMEinitialstate extends socialappstate {}

class SocialappHOMEloadingstate extends socialappstate {}

class SocialappHOMEsuccessstate extends socialappstate {}
//...........................................................................................
//settings
class SocialappSETTINGinitialstate extends socialappstate {}

class SocialappSETTINGloadingstate extends socialappstate {}

class SocialappSETTINGsuccessstate extends socialappstate {}

class Socialappbottomnavstate extends socialappstate {}
//...........................................................................................
//get user
class SocialappGETUSERinitialstate extends socialappstate {}

class SocialappGETUSERloadingstate extends socialappstate {}

class SocialappGETUSERsuccessstate extends socialappstate {
  UserModel? usermodel;
  SocialappGETUSERsuccessstate(this.usermodel);
}

class SocialappGETUSERERRORstate extends socialappstate {
  String? error;
  SocialappGETUSERERRORstate(this.error);
}
//...........................................................................................
//get ALL users
class SocialappGETALLUSERinitialstate extends socialappstate {}

class SocialappGETALLUSERloadingstate extends socialappstate {}

class SocialappGETALLUSERsuccessstate extends socialappstate {
  List<UserModel> users;
  SocialappGETALLUSERsuccessstate(this.users);
}

class SocialappGETALLUSERERRORstate extends socialappstate {
  String? error;
  SocialappGETALLUSERERRORstate(this.error);
}
//...........................................................................................
//UPDATE USER
class SocialappUPDATEUSERinitialstate extends socialappstate {}

class SocialappUPDATEUSERLoadingstate extends socialappstate {}

class SocialappUPDATEUSERsuccessstate extends socialappstate {}

class SocialappUPDATEUSERERRORstate extends socialappstate {
  String? error;
  SocialappUPDATEUSERERRORstate(this.error);
}
//...........................................................................................
//like post
class SocialappLIKEPOSTsuccessstate extends socialappstate {}

class SocialappLIKEPOSTERRORstate extends socialappstate {
  String? error;
  SocialappLIKEPOSTERRORstate(this.error);
}
//...........................................................................................
//UPLOAD PROFILE IMAGE
class SocialappUPLOADPROFILEIMAGELOADINGstate extends socialappstate {}

class SocialappUPLOADPROFILEIMAGESuccessstate extends socialappstate {}

class SocialappUPLOADPROFILEIMAGEERRORstate extends socialappstate {
  String? error;
  SocialappUPLOADPROFILEIMAGEERRORstate(this.error);
}
//...........................................................................................
//GET PROFILE IMAGE
class SocialappGETPROFILEIMAGELOADINGstate extends socialappstate {}

class SocialappGETPROFILEIMAGESuccessstate extends socialappstate {}

class SocialappGETPROFILEIMAGEERRORstate extends socialappstate {
  String? error;
  SocialappGETPROFILEIMAGEERRORstate(this.error);
}
//...........................................................................................
//CREATE POST
class SocialappCreatePostinitialstate extends socialappstate {}

class SocialappCreatePostloadingstate extends socialappstate {}

class SocialappCreatePostsuccessstate extends socialappstate {}

class SocialappCreatePostERRORstate extends socialappstate {
  String? error;
  SocialappCreatePostERRORstate(this.error);
}
//...........................................................................................
//getcomments
class SocialappGETCOMMENTSSLOADINGstate extends socialappstate {}

class SocialappGETCOMMENTSSuccessstate extends socialappstate {
  List<CommentModel> commentmodel;
  SocialappGETCOMMENTSSuccessstate(this.commentmodel);
}

class SocialappGETCOMMENTSSERRORstate extends socialappstate {
  String? error;
  SocialappGETCOMMENTSSERRORstate(this.error);
}
//...........................................................................................
//get likes
class SocialappGETLIKESLOADINGstate extends socialappstate {}

class SocialappGETLIKESSuccessstate extends socialappstate {}

class SocialappLIKESERRORstate extends socialappstate {
  String? error;
  SocialappLIKESERRORstate(this.error);
}
//...........................................................................................
//post comment

class SocialappCREATECOMMENTinitialstate extends socialappstate {}

class SocialappCREATECOMMENTloadingstate extends socialappstate {}

class SocialappCREATECOMMENTsuccessstate extends socialappstate {}

class SocialappCREATECOMMENTERRORstate extends socialappstate {
  String? error;
  SocialappCREATECOMMENTERRORstate(this.error);
}
//...........................................................................................
//GET POST IMAGE
class SocialappGETPostIMAGELOADINGstate extends socialappstate {}

class SocialappGETPostIIMAGESuccessstate extends socialappstate {}

class SocialappGETPostIIMAGEERRORstate extends socialappstate {
  String? error;
  SocialappGETPostIIMAGEERRORstate(this.error);
}
//...........................................................................................
//CREATE POST IMAGE
class SocialappCreatePostImageLOADINGstate extends socialappstate {}

class SocialappCreatePostImageSuccessstate extends socialappstate {}

class SocialappCreatePostImageERRORstate extends socialappstate {
  String? error;
  SocialappCreatePostImageERRORstate(this.error);
}
//...........................................................................................
//GET POSTS
class SocialappGETPOSTSinitialstate extends socialappstate {}

class SocialappGETPOSTSLOADINGstate extends socialappstate {}

class SocialappGETPOSTSSuccessstate extends socialappstate {
  List<PostModel> postmodel;
  SocialappGETPOSTSSuccessstate(this.postmodel);
}

class SocialappGETPOSTSERRORstate extends socialappstate {
  String? error;
  SocialappGETPOSTSERRORstate(this.error);
}
//...........................................................................................
//REMOVE POST IMAGE
class SocialappRemovePostImagestate extends socialappstate {}

//...........................................................................................
//get messages
class SocialappGETMessagesSLOADINGstate extends socialappstate {}

class SocialappGETMessagesSSuccessstate extends socialappstate {

}

class SocialappGETMessagesSERRORstate extends socialappstate {
  String? error;
  SocialappGETMessagesSERRORstate(this.error);
}

//...........................................................................................
//get messages
class SocialappGETLastMessagesSLOADINGstate extends socialappstate {}

class SocialappGETLastMessagesSSuccessstate extends socialappstate {
  SocialappGETLastMessagesSSuccessstate(MessageModel lastmessage);

}

class SocialappGETLastMessagesSERRORstate extends socialappstate {
  String? error;
  SocialappGETLastMessagesSERRORstate(this.error);
}
//...........................................................................................
//send messages
class SocialappSENDMessagesSLOADINGstate extends socialappstate {}

class SocialappSENDMessagesSSuccessstate extends socialappstate {

}

class SocialappSENDMessagesSERRORstate extends socialappstate {
  String? error;
  SocialappSENDMessagesSERRORstate(this.error);
}
//...........................................................................................
//edit post
class SocialappEditUserPostLOADINGstate extends socialappstate {}

class SocialappEditUserPostSuccessstate extends socialappstate {

}

class SocialappEditUserPostSERRORstate extends socialappstate {
  String? error;
  SocialappEditUserPostSERRORstate(this.error);
}
//...........................................................................................
// get user posts
class SocialappUSERPOSTSinitialstate extends socialappstate {}

class SocialappUSERPOSTSloadingstate extends socialappstate {}

class SocialappUSERPOSTSsuccessstate extends socialappstate {
  SocialappUSERPOSTSsuccessstate(List userposts);
}

class SocialappUSERPOSTSerrorstate extends socialappstate {
  SocialappUSERPOSTSerrorstate(String string);
}
//...........................................................................................
//send  reports
class SocialappSendEmailSuccessState extends socialappstate {

}

class SocialappSendEmailerrorstate extends socialappstate {
  SocialappSendEmailerrorstate(String string);
}
//...........................................................................................
//send  reports
class SocialappSendResetEmailSuccessState extends socialappstate {

}

class SocialappSendResetEmailerrorstate extends socialappstate {
  SocialappSendResetEmailerrorstate(String string);
}
//...........................................................................................
//delete posts
class SocialappDeletePostLOADINGstate extends socialappstate {}

class SocialappDeletePostSuccessstate extends socialappstate {

}

class SocialappDeletePostERRORstate extends socialappstate {
  String? error;
  SocialappDeletePostERRORstate(this.error);
}