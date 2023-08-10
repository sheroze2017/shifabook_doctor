class UserModel {
  bool? status;
  String? message;
  Null? error;
  Data? data;

  UserModel({this.status, this.message, this.error, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String? accessToken;
  String? refreshToken;
  String? expiresIn;
  String? refreshExpiresIn;

  Data(
      {this.user,
      this.accessToken,
      this.refreshToken,
      this.expiresIn,
      this.refreshExpiresIn});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expires_in'];
    refreshExpiresIn = json['refresh_expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['expires_in'] = this.expiresIn;
    data['refresh_expires_in'] = this.refreshExpiresIn;
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  Null? email;
  String? mobile;
  bool? isActive;
  bool? isVerify;
  String? createdAt;
  String? updatedAt;
  DoctorUser? doctorUser;
  Null? userPatient;
  Role? role;
  bool? isProfileCreated;

  User(
      {this.id,
      this.fullName,
      this.email,
      this.mobile,
      this.isActive,
      this.isVerify,
      this.createdAt,
      this.updatedAt,
      this.doctorUser,
      this.userPatient,
      this.role,
      this.isProfileCreated});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    mobile = json['mobile'];
    isActive = json['is_active'];
    isVerify = json['is_verify'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctorUser = json['doctor_user'] != null
        ? new DoctorUser.fromJson(json['doctor_user'])
        : null;
    userPatient = json['user_patient'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    isProfileCreated = json['is_profile_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['is_active'] = this.isActive;
    data['is_verify'] = this.isVerify;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.doctorUser != null) {
      data['doctor_user'] = this.doctorUser!.toJson();
    }
    data['user_patient'] = this.userPatient;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['is_profile_created'] = this.isProfileCreated;
    return data;
  }
}

class DoctorUser {
  int? id;

  DoctorUser({this.id});

  DoctorUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Role {
  int? id;
  String? name;

  Role({this.id, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
