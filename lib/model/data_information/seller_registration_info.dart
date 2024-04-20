class SellerRegistrationInfo {
  String? phone;
  String? fullName;
  String? location;
  String? latSeller;
  String? longSeller;
  String statement = 'statement';
  String? iban;
  List? order;
  List? request;
  List? products;
  String stock='0';
  bool available=false;
  bool allow = false;
  dynamic time;

  SellerRegistrationInfo(
      {this.phone,
      this.fullName,
      this.location,
      this.latSeller,
      this.longSeller,
      this.statement = 'statement',
      this.iban,
      this.order,
      this.products,
      this.request,
      this.stock='0',
      this.available=false,
      this.allow = false,
      this.time});

  SellerRegistrationInfo.fromJson(data) {
    var json = data ;
    phone = json['phone'] ?? '';
    fullName = json['fullName'] ?? '';
    location = json['location'] ?? '';
    latSeller = json['latSeller'] ?? '';
    longSeller = json['longSeller'] ?? '';

    statement = json['statement'] ?? '';
    iban = json['iban'] ?? '00000000000000';
    order = json['order'] ?? [];
    request = json['request'] ?? [];
    products = json['products'] ?? [];
    stock=json['stock']??'0';
    available=json['available'];
    allow = json['allow'];
    time = json['time'] ?? '';
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'fullName': fullName,
      'location': location,
      'latSeller': latSeller,
      'longSeller': longSeller,
      'statement': statement,
      'iban': iban,
      'order': order,
      'request': request,
      'products': products,
      'stock':stock,
      'available':available,
      'allow': allow,
      'time': time
    };
  }
}
