class MeezaWalletModel {
  final Data data;

  MeezaWalletModel({required this.data});

  factory MeezaWalletModel.fromJson(Map<String, dynamic> json) {
    return MeezaWalletModel(
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final int invoiceId;
  final String invoiceKey;
  final PaymentData paymentData;

  Data({
    required this.invoiceId,
    required this.invoiceKey,
    required this.paymentData,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      invoiceId: json['invoice_id'],
      invoiceKey: json['invoice_key'],
      paymentData: PaymentData.fromJson(json['payment_data']),
    );
  }
}

class PaymentData {
  final int meezaReference;
  final String meezaQrCode;

  PaymentData({
    required this.meezaReference,
    required this.meezaQrCode,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      meezaReference: json['meezaReference'],
      meezaQrCode: json['meezaQrCode'],
    );
  }
}