class PurchaseOrderParams{
  final String name;
  final int carId;
  final String phone;
  final String payType;

  PurchaseOrderParams({required this.name,required this.carId,required this.phone,required this.payType});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "brand_id": carId,
      "phone": phone,
      "payment_type": payType,
    };
  }
}