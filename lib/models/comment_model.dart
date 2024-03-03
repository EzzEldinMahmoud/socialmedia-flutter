class CommentModel{
  String? name;
  String? uId;
  String? image;
  String? datetime;
  String? text;



  CommentModel({
    required this.name,
    required this.datetime,
    required this.uId,
    required this.image,
    required this.text,

  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    datetime = json['datetime']?? '';
    uId = json['uId']?? '';
    image = json['image']?? '';
    text = json['text']?? '';

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'datetime': datetime,
      'uId': uId,
      'text': text,

    };
  }
}