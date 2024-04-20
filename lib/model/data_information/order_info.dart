
class OrderInfo {
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
  String? typeProduct;
  String? productPrice;
  String? amountProduct;
  bool retrievability=false;
  bool agreeSeller=false;
  bool agreeAdmin=false;
  dynamic time;
  dynamic timeDelete;
  bool sendOrder=false;



  OrderInfo({
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

    this.productPrice,
    this.amountProduct,
    this.typeProduct,
    this.retrievability=false,
    this.agreeSeller=false,
    this.agreeAdmin=false,
    this.time,
    this.timeDelete,
    this.sendOrder=false
  });

  OrderInfo.fromJson(data) {
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
    productPrice = json['productPrice']??'';
    amountProduct= json['amountProduct']??'';
    retrievability=json['retrievability']??false;
    typeProduct = json['typeProduct']??'';
    agreeSeller=json['agreeSeller']??false;
    agreeAdmin=json['agreeAdmin']??false;
    time=json['time'];
    timeDelete =json['timeDelete'];
    sendOrder=json['sendOrder']??false;


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
      'productPrice': productPrice,
      'amountProduct':amountProduct,
      'typeProduct': typeProduct,

      'retrievability': retrievability,
      'agreeSeller': agreeSeller,
      'agreeAdmin':agreeAdmin,
      'time':time,
      'timeDelete':timeDelete,
      'sendOrder':sendOrder
    };
  }
}
