
class RecoveryInfo {
  String? id;
  String? propertyName;
  String? phoneClient;
  String? latClient;
  String? longClient;
  String? locationClient;
  String? locationSeller;
  String? phoneSeller;
  String? latSeller;
  String? longSeller;
  String? palisClient='';
  String? palisSeller='';
  String? productPrice;
  String? reasonReturn;
  bool agree=false;
  bool agreeClient=false;
  dynamic time;
  bool sendRecovery=false;



  RecoveryInfo({
    this.id,
    this.propertyName,
    this.locationClient,
    this.locationSeller,
    this.longClient,
    this.latClient,
    this.longSeller,
    this.latSeller,
    this.phoneClient,
    this.phoneSeller,
    this.palisClient,
    this.palisSeller,
    this.productPrice,
    this.reasonReturn,
    this.agree=false,
    this.agreeClient=false,
    this.time,
    this.sendRecovery=false
  });

  RecoveryInfo.fromJson(data) {
    var json = data ;
    id = json['id']??'';
    propertyName = json['propertyName']??'';
    locationClient = json['locationClient']??'';
    locationSeller = json['locationSeller']??'';
    longClient = json['longClient']??'';
    latClient = json['latClient']??'';
    longSeller = json['longSeller']??'';
    latSeller = json['latSeller']??'';
    phoneClient = json['phoneClient']??'';
    phoneSeller = json['phoneSeller']??'';
    palisClient = json['palisClient']??'';
    palisSeller = json['palisSeller']??'';
    productPrice = json['productPrice']??'';
    reasonReturn=json['reasonReturn']??'';
    agree=json['agree']??false;
    agreeClient=json['agreeClient']??false;
    time=json['time'];
    sendRecovery=json['sendRecovery']??false;

  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'propertyName': propertyName,
      'locationClient': locationClient,
      'locationSeller': locationSeller,
      'longClient': longClient,
      'latClient': latClient,
      'longSeller': longSeller,
      'latSeller': latSeller,
      'phoneClient': phoneClient,
      'phoneSeller': phoneSeller,
      'palisClient':palisClient,
      'palisSeller': palisSeller,
      'productPrice': productPrice,
      'reasonReturn':reasonReturn,
      'agree':agree,
      'agreeClient':agreeClient,

      'time':time,
      'sendRecovery':sendRecovery
    };
  }
}
