part of 'models.dart';

class Transaction {
  Transaction({
    this.id,
    this.userId,
    this.productId,
    this.message,
    this.total,
    this.status,
    this.paymentUrl,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.user,
  });

  int id;
  int userId;
  int productId;
  String message;
  int total;
  String status;
  String paymentUrl;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  Product product;
  User user;

  Transaction copyWith({
    int id,
    int userId,
    int productId,
    String message,
    int total,
    String status,
    String paymentUrl,
    dynamic deletedAt,
    DateTime createdAt,
    DateTime updatedAt,
    Product product,
    User user,
  }) =>
      Transaction(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        productId: productId ?? this.productId,
        message: message ?? this.message,
        total: total ?? this.total,
        status: status ?? this.status,
        paymentUrl: paymentUrl ?? this.paymentUrl,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        product: product ?? this.product,
        user: user ?? this.user,
      );

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        message: json["message"] == null ? null : json["message"],
        total: json["total"] == null ? null : json["total"],
        status: json["status"] == null ? null : json["status"],
        paymentUrl: json["payment_url"] == null ? null : json["payment_url"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "product_id": productId == null ? null : productId,
        "message": message == null ? null : message,
        "total": total == null ? null : total,
        "status": status == null ? null : status,
        "payment_url": paymentUrl == null ? null : paymentUrl,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "product": product == null ? null : product.toJson(),
        "user": user == null ? null : user.toJson(),
      };
}
