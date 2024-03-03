class PostModel{
  String? name;
  String? uId;
  String? image;
  String? datetime;
  String? postimage;
  String? text;
  String? bio;



  PostModel({
    required this.name,
    required this.datetime,
    required this.postimage,
    required this.uId,
    required this.image,
    required this.text,
    required this.bio

  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    datetime = json['datetime']?? '';
    postimage = json['postimage']?? '';
    uId = json['uId']?? '';
    image = json['image']?? '';
    text = json['text']?? '';
    bio = json['bio']?? '';

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'datetime': datetime,
      'uId': uId,
      'postimage': postimage,
      'text': text,
      'bio':bio

    };
  }
}