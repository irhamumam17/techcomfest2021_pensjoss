part of 'models.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.name,
    this.description,
    this.category,
    this.targetFunding,
    this.targetEnd,
    this.photoPath,
    this.videoPath,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.totalDonation,
    this.donator,
    this.urlPhoto,
    this.user,
  });

  int id;
  String name;
  String description;
  String category;
  int targetFunding;
  DateTime targetEnd;
  String photoPath;
  String videoPath;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int totalDonation;
  List<Donator> donator;
  String urlPhoto;
  User user;

  Product copyWith({
    int id,
    String name,
    String description,
    String category,
    int targetFunding,
    DateTime targetEnd,
    String photoPath,
    String videoPath,
    dynamic deletedAt,
    DateTime createdAt,
    DateTime updatedAt,
    int totalDonation,
    List<Donator> donator,
    String urlPhoto,
    User user,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        category: category ?? this.category,
        targetFunding: targetFunding ?? this.targetFunding,
        targetEnd: targetEnd ?? this.targetEnd,
        photoPath: photoPath ?? this.photoPath,
        videoPath: videoPath ?? this.videoPath,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        totalDonation: totalDonation ?? this.totalDonation,
        donator: donator ?? this.donator,
        urlPhoto: urlPhoto ?? this.urlPhoto,
        user: user ?? this.user,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        category: json["category"] == null ? null : json["category"],
        targetFunding:
            json["target_funding"] == null ? null :int.parse(json["target_funding"].toString()),
        targetEnd: json["target_end"] == null
            ? null
            : DateTime.parse(json["target_end"]),
        photoPath: json["photo_path"] == null ? null : json["photo_path"],
        videoPath: json["video_path"] == null ? null : json["video_path"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        totalDonation:
            json["total_donation"] == null ? null : json["total_donation"],
        donator: json["donator"] == null
            ? null
            : List<Donator>.from(
                json["donator"].map((x) => Donator.fromJson(x))),
        urlPhoto: json["url_photo"] == null ? null : json["url_photo"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "category": category == null ? null : category,
        "target_funding": targetFunding == null ? null : targetFunding,
        "target_end": targetEnd == null ? null : targetEnd.toIso8601String(),
        "photo_path": photoPath == null ? null : photoPath,
        "video_path": videoPath == null ? null : videoPath,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "total_donation": totalDonation == null ? null : totalDonation,
        "donator": donator == null
            ? null
            : List<dynamic>.from(donator.map((x) => x.toJson())),
        "url_photo": urlPhoto == null ? null : urlPhoto,
        "user": user == null ? null : user.toJson(),
      };
}

class Donator {
  Donator({
    this.message,
    this.total,
    this.createdAt,
    this.userId,
    this.user,
  });

  String message;
  int total;
  DateTime createdAt;
  int userId;
  DonatorUser user;

  Donator copyWith({
    String message,
    int total,
    DateTime createdAt,
    int userId,
    DonatorUser user,
  }) =>
      Donator(
        message: message ?? this.message,
        total: total ?? this.total,
        createdAt: createdAt ?? this.createdAt,
        userId: userId ?? this.userId,
        user: user ?? this.user,
      );

  factory Donator.fromJson(Map<String, dynamic> json) => Donator(
        message: json["message"] == null ? null : json["message"],
        total: json["total"] == null ? null : json["total"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : DonatorUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "total": total == null ? null : total,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user.toJson(),
      };
}

class DonatorUser {
  DonatorUser({
    this.id,
    this.name,
    this.profilePhotoPath,
    this.profilePhotoUrl,
  });

  int id;
  String name;
  String profilePhotoPath;
  String profilePhotoUrl;

  DonatorUser copyWith({
    int id,
    String name,
    String profilePhotoPath,
    String profilePhotoUrl,
  }) =>
      DonatorUser(
        id: id ?? this.id,
        name: name ?? this.name,
        profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
        profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      );

  factory DonatorUser.fromJson(Map<String, dynamic> json) => DonatorUser(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        profilePhotoPath: json["profile_photo_path"] == null
            ? null
            : json["profile_photo_path"],
        profilePhotoUrl: json["profile_photo_url"] == null
            ? null
            : json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "profile_photo_path":
            profilePhotoPath == null ? null : profilePhotoPath,
        "profile_photo_url": profilePhotoUrl == null ? null : profilePhotoUrl,
      };
}
