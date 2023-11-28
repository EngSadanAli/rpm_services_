class UserModel {
  String? uid;
  String? phone;
  String? profileImage;
  String? userName;
  String? email;
  String? role;

  UserModel({
    this.uid,
    this.phone,
    this.profileImage,
    this.userName,
    this.email,
    this.role,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? '';
    phone = json['phone'] ?? '';
    profileImage = json['profileImage'] ?? '';
    userName = json['userName'] ?? '';
    email = json['email'] ?? '';
    role = json['role'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['phone'] = phone;
    data['profileImage'] = profileImage;
    data['userName'] = userName;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}
