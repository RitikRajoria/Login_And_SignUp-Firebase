class SignUpModel {
  String? uid;
  String? email;
  String? name;

  SignUpModel({this.uid, this.email, this.name});

  //data from server

  factory SignUpModel.fromMap(map) {
    return SignUpModel(uid: map['uid'], email: map['email'], name: map['name']);
  }

  //sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}
