class ProductInfo {
  String? phone;
  String? id;
  String? location;
  String? latSeller;
  String? longSeller;
  String? propertyName;
  String? productClassification;
  String? productPrice;
  String? deliveryCharge;
  String? valueAddedTax;
  String? productDiscount ;
  String? descriptionProperty;
  String? imageProduct;
  int numberRequests = 0;
  String? rival;
  String? titleType;
  List? typeProduct;
  String? amountProduct;
  double assess = 0;
  List? comments;
  bool agree = false;
  bool retrievability=false;
  ProductInfo({
    this.phone,
    this.id,
    this.location,
    this.latSeller,
    this.longSeller,
    this.propertyName,
    this.productClassification,
    this.productPrice,
    this.deliveryCharge,
    this.valueAddedTax,
    this.productDiscount,
    this.descriptionProperty,
    this.imageProduct,
    this.typeProduct,
    this.rival,
    this.titleType,
    this.amountProduct,
    this.assess=0,
    this.comments,
    this.agree = false,
    this.retrievability=false,

  });

  ProductInfo.fromJson(data) {
    dynamic json = data ;
    phone = json['phone']??'';
    id = json['id'] ?? '';
    location = json['location'] ?? '';
    latSeller = json['location'] ?? '';
    longSeller = json['longSeller'] ?? '';
    propertyName = json['propertyName'] ?? '';
    productClassification = json['productClassification'] ?? '';
    productPrice = json['productPrice'];
     deliveryCharge = json['deliveryCharge'];
     valueAddedTax =json['valueAddedTax'];
     productDiscount = json['productDiscount'];
    descriptionProperty = json['descriptionProperty'] ?? '';
    imageProduct = json['imageProduct'] ?? '';
    numberRequests = json['numberRequests'];
    rival = json['rival'] ?? '';
    titleType = json['titleType'] ?? '';
    typeProduct = json['typeProduct'] ?? [];
    amountProduct = json['amountProduct'] ?? '';
    assess = double.parse(json['assess'].toString()) ;
    comments = json['comments'] ?? [];
    agree = json['agree'];
    retrievability=json['retrievability'];
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'id': id,
      'location': location,
      'latSeller': latSeller,
      'longSeller': longSeller,
      'propertyName': propertyName,
      'productClassification': productClassification,
      'productPrice': productPrice,
    'deliveryCharge' : deliveryCharge,
    'valueAddedTax' :valueAddedTax,
    'productDiscount' :productDiscount,
      'descriptionProperty': descriptionProperty,
      'imageProduct': imageProduct,
      'numberRequests': numberRequests,
      'rival': rival,
      'titleType': titleType,
      'typeProduct': typeProduct,
      'amountProduct': amountProduct,
      'comments': comments,
      'assess': assess,
      'agree': agree,
      'retrievability':retrievability
    };
  }
}
