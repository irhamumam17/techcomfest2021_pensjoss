part of 'models.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.address,
    this.description,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.fcmToken,
    this.roles,
    this.currentTeamId,
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoUrl,
  });

  int id;
  String name;
  String address;
  String description;
  String email;
  String phone;
  dynamic emailVerifiedAt;
  String fcmToken;
  String roles;
  dynamic currentTeamId;
  String profilePhotoPath;
  DateTime createdAt;
  DateTime updatedAt;
  String profilePhotoUrl;

  User copyWith({
    int id,
    String name,
    String address,
    String description,
    String email,
    String phone,
    dynamic emailVerifiedAt,
    String fcmToken,
    String roles,
    dynamic currentTeamId,
    String profilePhotoPath,
    DateTime createdAt,
    DateTime updatedAt,
    String profilePhotoUrl,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        description: description ?? this.description,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        fcmToken: fcmToken ?? this.fcmToken,
        roles: roles ?? this.roles,
        currentTeamId: currentTeamId ?? this.currentTeamId,
        profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        description: json["description"] == null ? null : json["description"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        emailVerifiedAt: json["email_verified_at"],
        fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
        roles: json["roles"] == null ? null : json["roles"],
        currentTeamId: json["current_team_id"],
        profilePhotoPath: json["profile_photo_path"] == null
            ? null
            : json["profile_photo_path"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        profilePhotoUrl: json["profile_photo_url"] == null
            ? null
            : json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "description": description == null ? null : description,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "email_verified_at": emailVerifiedAt,
        "fcm_token": fcmToken == null ? null : fcmToken,
        "roles": roles == null ? null : roles,
        "current_team_id": currentTeamId,
        "profile_photo_path":
            profilePhotoPath == null ? null : profilePhotoPath,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "profile_photo_url": profilePhotoUrl == null ? null : profilePhotoUrl,
      };
}
