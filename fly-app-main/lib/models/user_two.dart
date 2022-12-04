class User_two {
  String? atcid;
  String? name;
  String? imageURL;
  String? tower;
  String? contactNo;
  String? userName;
  String? password;
  String? conpassword;

  User_two(
      {this.atcid,
      this.name,
      this.imageURL = 'assets/images/profile-picture.png',
      this.tower,
      this.contactNo,
      this.userName,
      this.password,
      this.conpassword});

  User_two.fromJson(Map<String, dynamic> json) {
    atcid = json['atcid'];
    name = json['name'];
    imageURL = json['imageURL'];
    tower = json['tower'];
    contactNo = json['contactNo'];
    userName = json['userName'];
    password = json['password'];
    conpassword = json['conpassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['atcid'] = atcid;
    data['name'] = name;
    data['imageURL'] = imageURL;
    data['tower'] = tower;
    data['contactNo'] = contactNo;
    data['userName'] = userName;
    data['password'] = password;
    data['conpassword'] = conpassword;
    return data;
  }
}
