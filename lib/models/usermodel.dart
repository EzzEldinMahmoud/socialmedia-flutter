class UserModel{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? bio;


  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.image,
    required this.bio,

  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    email = json['email']?? '';
    phone = json['phone']?? '';
    uId = json['uId']?? '';
    image = json['image']?? '';
    bio = json['bio']?? '';

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'bio': bio,

    };
  }
}