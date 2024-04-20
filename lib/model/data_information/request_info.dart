
class RequestInfo {
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
  String? productPrice;
  String? deliveryCharge;
  String? valueAddedTax;
  String? descriptionRequest;
  String? deleteTime;
  bool agreeSeller=false;
  bool agreeAdmin=false;
  bool agreeClient=false;

  dynamic time;

  RequestInfo({
    this.id,
    this.propertyName,
    this.phoneClient,
    this.phoneSeller,
    this.locationSeller,
    this.locationClient,
    this.latSeller,
    this.longSeller,
    this.latClient,
    this.longClient,
    this.productPrice,
    this.deliveryCharge,
    this.valueAddedTax,
    this.descriptionRequest,
    this.deleteTime,
    this.agreeAdmin=false,
    this.agreeSeller=false,
    this.agreeClient=false,
    this.time,
  });

  RequestInfo.fromJson(data) {
    var json = data ;
    id=json['id'] ??'';
    propertyName = json['propertyName']??'';
    phoneClient = json['phoneClient']??'';
    phoneSeller = json['phoneSeller']??'';
    locationSeller=json['locationSeller']??'';
    locationClient=json['locationClient']??'';
    latSeller=json['latSeller']??'';
    longSeller=json['longSeller']??'';
    latClient=json['latClient']??'';
    longClient=json['longClient']??'';
    productPrice=json['productPrice']??'';
    deliveryCharge=json['deliveryCharge']??'';
    valueAddedTax=json['valueAddedTax']??'';
    descriptionRequest = json['descriptionProperty']??'';
    agreeAdmin=json['agreeAdmin'];
    agreeSeller=json['agreeSeller'];
    agreeClient=json['agreeClient']?? false;
    deleteTime=json['deleteTime'];
    time=json['time']??'';
  }

  Map<String, dynamic> toMap() {
    return {
   ' id': id,
    'propertyName': propertyName,
    'locationSeller':locationSeller,
    'locationClient':locationClient,
     'phoneSeller':phoneSeller,
     'phoneClient':phoneClient,
     'latSeller':latSeller,
    'longSeller':longSeller,
    'latClient':latClient,
    'longClient':longClient,
    'productPrice':productPrice,
    'deliveryCharge':deliveryCharge,
    'valueAddedTax':valueAddedTax,
    'descriptionProperty': descriptionRequest,
    'deleteTime': deleteTime,
    'agreeAdmin': agreeAdmin,
    'agreeSeller': agreeSeller,
    'agreeClient':agreeClient,
    'time':time
    };
  }
}
