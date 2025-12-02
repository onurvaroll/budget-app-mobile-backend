class Transaction {
  final String? id;
  final double? amount;
  final String? type;
  final String? description;
  final DateTime? date;
  final String? categoryId;
  final String? userId;

  Transaction({
    this.id,
    this.amount,
    this.type,
    this.description,
    this.date,
    this.categoryId,
    this.userId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    amount: json["amount"],
    type: json["type"],
    description: json["description"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    categoryId: json["category_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() {
    final val = int.tryParse(categoryId ?? '') ?? categoryId;
    return {
      if (id != null && id!.isNotEmpty) "id": id,
      "amount": amount,
      "type": type,
      "description": description,
      "date":
          "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
      "category_id": val,
      "categoryId": val, // Try sending camelCase as well
      if (userId != null && userId!.isNotEmpty) "user_id": userId,
    };
  }
}
