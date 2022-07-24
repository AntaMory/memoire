import 'dart:io';

class User {
  int id;

  String username;

  String email;

  String firstName;

  String lastName;

  String password;

  String phoneNumber;

  String adresse;


  User(this.id, this.username, this.email, this.firstName, this.lastName,
      this.password, this.phoneNumber, this.adresse);

  // User.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   username = json['username'];
  //   password = json['password'];
  //   firstName = json['firstName'];
  //   lastName = json['lastName'];
  //   email = json['email'];
  //   phoneNumber = json['phoneNumber'];
  //   adresse = json['adresse'];
  // }

  Map<String, dynamic> toJson() =>{
    "id": id,
    "username": username,
    "password": password,
    "firstName":firstName,
    "lastName": lastName,
    "email":email,
    "phoneNumber": phoneNumber,
    "adresse": adresse,

  };

  

  static fromMap(Map<String, dynamic> user) {
      // id = map['id'];
      // username = map['username'];
      // password = map['password'];
      //  firstName = map['firstName'];
      //  lastName = map['lastName'];
      //  email = map['email'];
      //  phoneNumber = map['phoneNumber'];
      //  adresse = map['adresse'];
      //
  }
}