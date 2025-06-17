class FawryResponseModel {
  final FawryData data;

  FawryResponseModel({required this.data});

  factory FawryResponseModel.fromJson(Map<String, dynamic> json) {
    return FawryResponseModel(
      data: FawryData.fromJson(json['data']),
    );
  }
}

class FawryData {
  final int invoiceId;
  final String invoiceKey;
  final FawryPaymentData paymentData;

  FawryData({
    required this.invoiceId,
    required this.invoiceKey,
    required this.paymentData,
  });

  factory FawryData.fromJson(Map<String, dynamic> json) {
    return FawryData(
      invoiceId: json['invoice_id'] is int ? json['invoice_id'] : int.tryParse(json['invoice_id'].toString()) ?? 0,
      invoiceKey: json['invoice_key'].toString(),
      paymentData: FawryPaymentData.fromJson(json['payment_data']),
    );
  }
}

class FawryPaymentData {
  final String fawryCode;  // Changed from int to String
  final String expireDate;

  FawryPaymentData({
    required this.fawryCode,
    required this.expireDate,
  });

  factory FawryPaymentData.fromJson(Map<String, dynamic> json) {
    return FawryPaymentData(
      fawryCode: json['fawryCode'].toString(),  // Ensure string conversion
      expireDate: json['expireDate'].toString(),
    );
  }
}