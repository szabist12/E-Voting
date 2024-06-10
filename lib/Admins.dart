class Admins {
  late final int Id_;
  late final String First_Name;
  late final String Last_Name;
  late final String E_Mail;
  late final String Password;
  late final String Cnic;
  late final String Phone_No;

  Admins(
      {required this.Id_,
        required this.First_Name,
        required this.Last_Name,
        required this.E_Mail,
        required this.Password,
        required this.Cnic,
        required this.Phone_No});

  Map<String, dynamic> toMap(Admins admins) {
    return {
      "Id_": admins.Id_,
      "First_Name": admins.First_Name,
      "Last_Name": admins.Last_Name,
      "E_Mail": admins.E_Mail,
      "Password": admins.Password,
      "Cnic": admins.Cnic,
      "Phone_No": admins.Phone_No
    };
  }

  factory Admins.fromJson(Map<String, dynamic> json) {
    return Admins(
      First_Name: json['First_Name'],
      Last_Name: json['Last_Name'],
      Cnic: json['Cnic'],
      Phone_No: json['Phone_No'],
      E_Mail: json['E_Mail'],
      Password: json['Password'],
      Id_: 0,
    );
  }
}
