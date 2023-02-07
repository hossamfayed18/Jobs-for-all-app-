class UserModel {

  String ?name ;
  String ?email ;
  String ?phone ;
  String ? uid ;
  String ? image ;
  String ? cover ;
  String ? bio ;

  UserModel({required this.email,required this.name,required this.phone,required this.uid,required this.image,required this.bio,required this.cover});


  UserModel.Fromjson(Map<String,dynamic>json)
  {
    name =json['name'];
    email =json['email'];
    phone =json['phone'];
    uid =json['uid'];
    image =json['image'];
    cover =json['cover'];
    bio =json['bio'];

  }


  Map<String,dynamic> toMap() {
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uid' : uid,
      'image': image,
      'cover' : cover,
        'bio':bio,
    } ;
  }

}