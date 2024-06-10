class Candidates {
  late final String Id_;
  late final String First_Name;
  late final String Last_Name;
  late final String E_Mail;
  late final String Password;
  late final String Cnic;
  late final String Phone_No;
  late final String img;

  Candidates(
      {required this.Id_,
        required this.First_Name,
        required this.Last_Name,
        required this.E_Mail,
        required this.Password,
        required this.Cnic,
        required this.Phone_No,
        required this.img});

  Map<String, dynamic> toMap(Candidates candidates) {
    return {
      "Id_": candidates.Id_,
      "First_Name": candidates.First_Name,
      "Last_Name": candidates.Last_Name,
      "E_Mail": candidates.E_Mail,
      "Password": candidates.Password,
      "Cnic": candidates.Cnic,
      "Phone_No": candidates.Phone_No,
      "img": candidates.img
    };
  }

  factory Candidates.fromJson(Map<String, dynamic> json) {
    return Candidates(
      First_Name: json['First_Name'],
      Last_Name: json['Last_Name'],
      Cnic: json['Cnic'],
      Phone_No: json['Phone_No'],
      E_Mail: json['E_Mail'],
      Password: json['Password'],
      Id_: json['_id'],
      img: json['img']??"",
    );
  }
}
