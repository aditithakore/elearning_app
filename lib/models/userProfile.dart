class UserProfile {
  String? sId;
  int? childage;
  String? childname;

  UserProfile({this.sId, this.childage, this.childname});

  UserProfile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    childage = json['childage'];
    childname = json['childname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['childage'] = this.childage;
    data['childname'] = this.childname;
    return data;
  }
}
