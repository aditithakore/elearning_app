class UserProfile {
  String? sId;
  int? childage;
  String? childname;

  UserProfile({this.sId, this.childage, this.childname});

  UserProfile.fromJson(Map<String, dynamic> json) {
    print(json);
    sId = json['user_details']['_id'];
    childage = json['user_details']['childage'];
    childname = json['user_details']['childname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['childage'] = this.childage;
    data['childname'] = this.childname;
    return data;
  }
}
