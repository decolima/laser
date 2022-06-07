class User {
  String firstName = "";
  String lastName = "";
  String mail = "";
  String role = "";
  String token = "";
  String? link = "";
  int userid = 0;

  User(
      {required this.firstName,
      required this.lastName,
      required this.mail,
      required this.role,
      required this.token,
      required this.userid});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    mail = json['mail'];
    role = json['role'];
    token = json['token'];
    userid = json['userid'];
  }

  User.fromJsonSlice(Map<String, dynamic> json) {
    firstName = json['first_name'];
    link = json['link'];
  }

  /*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mail'] = this.mail;
    data['role'] = this.role;
    data['token'] = this.token;
    data['userid'] = this.userid;
    return data;
  }
  */

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mail'] = mail;
    data['role'] = role;
    data['token'] = token;
    data['userid'] = userid;
    return data;
  }
}
