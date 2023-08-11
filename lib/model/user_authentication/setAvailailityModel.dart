class availabiltyModel {
  List<Availability>? availability;

  availabiltyModel({this.availability});

  availabiltyModel.fromJson(Map<String, dynamic> json) {
    if (json['availability'] != null) {
      availability = <Availability>[];
      json['availability'].forEach((v) {
        availability!.add(new Availability.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.availability != null) {
      data['availability'] = this.availability!.map((v) => v.toJson()).toList();
    }
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

class Times {
  String? startTime;
  String? endTime;

  Times({this.startTime, this.endTime});

  Times.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}
