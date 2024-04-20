class AccountRegistrationInfo {
  String? phone;
  List? favorites;
  List? requests;
  List? recovery;

  AccountRegistrationInfo(
      {this.phone
        , this.favorites,
        this.requests,
        this.recovery});

  AccountRegistrationInfo.fromJson(data) {
    Map<String, dynamic> json = data as Map<String, dynamic>;
    phone = json['phone'];
    favorites = json['favorites']??[];
    requests = json['requests']??[];
    recovery = json['recovery']??[];
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'favorites': favorites,
      'requests': requests,
      'recovery': recovery,
    };
  }
}
