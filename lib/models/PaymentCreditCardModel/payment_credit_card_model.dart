class PaymentCreditCardModel {
  int id;
  String name;
  String card_no;
  String cvv;
  String expiry_date;
  PaymentCreditCardModel({
    required this.id,
    required this.name,
    required this.expiry_date,
    required this.cvv,
    required this.card_no,
  });
  PaymentCreditCardModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        id = json['id'] ?? 0,
        card_no = json['card_no'] ?? '',
        cvv = json['cvv'] ?? '',
        expiry_date = json['expiry_date'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'card_no': card_no,
      'cvv': cvv,
      'expiry_date': expiry_date,
    };
  }
}
