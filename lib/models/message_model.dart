class MessageModel {

  String ? text ;
  String ? dateTime ;
  String ?recieverId ;
  String ? senderId ;


  MessageModel({required this.text,required this.dateTime,required this.recieverId,required this.senderId,});


  MessageModel.Fromjson(Map<String,dynamic>json)
  {
    text =json['text'];
    dateTime =json['dateTime'];
    recieverId =json['recieverId'];
    senderId =json['senderId'];
  }


  Map<String,dynamic> toMap() {
    return {
      'text' : text,
      'dateTime' : dateTime,
      'recieverId' : recieverId,
      'senderId' : senderId,
    } ;
  }

}