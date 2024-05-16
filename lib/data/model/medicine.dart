class Medicine {
  final int id;
  final String medName;
  final int itemCode;
  final String description;
  final int stockCount;

  Medicine(
      {required this.id,
      required this.medName,
      required this.itemCode,
      required this.description,
      required this.stockCount});

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['med_stocks_id'] as int,
      medName: json['med_name'] as String,
      itemCode: json['item_code'] as int,
      description: json['description'].toString(), // Convert to String
      stockCount: json['stock_count'] as int,
    );
  }
}
