
class doctorProfile {
  bool? status;
  String? message;
  Null? error;
  Data? data;

  doctorProfile({this.status, this.message, this.error, this.data});

  doctorProfile.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? fullName;
  String? mobile;
  Null? email;
  String? gender;
  String? age;
  String? dob;
  bool? isActive;
  Null? image;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Null? deactivatedAt;
  bool? isDeactivated;
  List<Cities>? cities;
  DoctorUser? doctorUser;
  List<Categories>? categories;
  DoctorAvailability? doctorAvailability;

  Data(
      {this.id,
      this.fullName,
      this.mobile,
      this.email,
      this.gender,
      this.age,
      this.dob,
      this.isActive,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.deactivatedAt,
      this.isDeactivated,
      this.cities,
      this.doctorUser,
      this.categories,
      this.doctorAvailability});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    mobile = json['mobile'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    dob = json['dob'];
    isActive = json['is_active'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    deactivatedAt = json['deactivated_at'];
    isDeactivated = json['is_deactivated'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
    doctorUser = json['doctor_user'] != null
        ? new DoctorUser.fromJson(json['doctor_user'])
        : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    doctorAvailability = json['doctor_availability'] != null
        ? new DoctorAvailability.fromJson(json['doctor_availability'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['dob'] = this.dob;
    data['is_active'] = this.isActive;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['deactivated_at'] = this.deactivatedAt;
    data['is_deactivated'] = this.isDeactivated;
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    if (this.doctorUser != null) {
      data['doctor_user'] = this.doctorUser!.toJson();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.doctorAvailability != null) {
      data['doctor_availability'] = this.doctorAvailability!.toJson();
    }
    return data;
  }
}

class Cities {
  int? id;
  String? name;

  Cities({this.id, this.name});

  Cities.fromJson(Map<String, dynamic> json) {
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

class DoctorUser {
  int? userId;
  String? licenseNumber;
  Null? availability;
  List<String>? affilation;
  List<String>? qualification;
  int? yearsOfExperience;
  int? onsiteConsultationFee;
  int? onlineConsultationFee;

  DoctorUser(
      {this.userId,
      this.licenseNumber,
      this.availability,
      this.affilation,
      this.qualification,
      this.yearsOfExperience,
      this.onsiteConsultationFee,
      this.onlineConsultationFee});

  DoctorUser.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    licenseNumber = json['license_number'];
    availability = json['availability'];
    affilation = json['affilation'].cast<String>();
    qualification = json['qualification'].cast<String>();
    yearsOfExperience = json['years_of_experience'];
    onsiteConsultationFee = json['onsite_consultation_fee'];
    onlineConsultationFee = json['online_consultation_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['license_number'] = this.licenseNumber;
    data['availability'] = this.availability;
    data['affilation'] = this.affilation;
    data['qualification'] = this.qualification;
    data['years_of_experience'] = this.yearsOfExperience;
    data['onsite_consultation_fee'] = this.onsiteConsultationFee;
    data['online_consultation_fee'] = this.onlineConsultationFee;
    return data;
  }
}

class DoctorAvailability {
  List<Availability>? availability;
  bool? isBusy;
  bool? onLeave;

  DoctorAvailability({this.availability, this.isBusy, this.onLeave});

  DoctorAvailability.fromJson(Map<String, dynamic> json) {
    if (json['availability'] != null) {
      availability = <Availability>[];
      json['availability'].forEach((v) {
        availability!.add(new Availability.fromJson(v));
      });
    }
    isBusy = json['is_busy'];
    onLeave = json['on_leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.availability != null) {
      data['availability'] = this.availability!.map((v) => v.toJson()).toList();
    }
    data['is_busy'] = this.isBusy;
    data['on_leave'] = this.onLeave;
    return data;
  }
}

class Availability {
  String? day;
  List<Times>? times;
  int? landmarkId;

  Availability({this.day, this.times, this.landmarkId});

  Availability.fromJson(Map<String, dynamic> json) {
    day = json['Day'];
    if (json['times'] != null) {
      times = <Times>[];
      json['times'].forEach((v) {
        times!.add(new Times.fromJson(v));
      });
    }
    landmarkId = json['landmark_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Day'] = this.day;
    if (this.times != null) {
      data['times'] = this.times!.map((v) => v.toJson()).toList();
    }
    data['landmark_id'] = this.landmarkId;
    return data;
  }
}

class Categories {
  int? id;
  String? name;

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
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

class Times {
  String? endTime;
  String? startTime;

  Times({this.endTime, this.startTime});

  Times.fromJson(Map<String, dynamic> json) {
    endTime = json['end_time'];
    startTime = json['start_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end_time'] = this.endTime;
    data['start_time'] = this.startTime;
    return data;
  }
}
