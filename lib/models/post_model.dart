class PostModel {
  String ?name ;
  String ? uid ;
  String ? profileImage;
  String ? image ;
  String ? description ;
  String ? dateTime ;
  String ? jobCategory ;
  String ? phoneOrEmail;
  String ? place;
  String ? requirements;
  String ? notes ;


  PostModel({required this.name,required this.uid,required this.image,required this.description,required this.dateTime,required this.jobCategory,required this.profileImage,this.phoneOrEmail,this.notes,this.place,this.requirements});


  PostModel.Fromjson(Map<String,dynamic>json)
  {
    name =json['name'];
    uid =json['uid'];
    image =json['image'];
    dateTime =json['dateTime'];
    description =json['description'];
    jobCategory = json['jobCategory'];
    profileImage =json['profileImage'];
    place =json['place'];
    requirements=json['requirements'];
    notes=json['notes'];
    phoneOrEmail=json['phoneOrEmail'];
  }


  Map<String,dynamic> toMap() {
    return {
      'name' : name,
      'uid' : uid,
      'image': image,
      'dateTime' : dateTime,
      'description':description,
      'jobCategory':jobCategory,
      'profileImage':profileImage,
      'phoneOrEmail':phoneOrEmail,
      'place':place,
      'notes':notes,
      'requirements':requirements,

    } ;
  }

}