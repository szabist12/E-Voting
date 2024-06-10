class Voters {
  final String Id_;
  late final String First_Name;
  late final String Last_Name;
  late final String E_Mail;
  late final String Password;
  late final String Cnic;
  late final String Phone_No;
  late final String img;

  Voters(
      {required this.Id_,
        required this.First_Name,
        required this.Last_Name,
        required this.E_Mail,
        required this.Password,
        required this.Cnic,
        required this.Phone_No,
        required this.img});

  Map<String, dynamic> toMap(Voters voters) {
    return {
      "Id_": voters.Id_,
      "First_Name": voters.First_Name,
      "Last_Name": voters.Last_Name,
      "E_Mail": voters.E_Mail,
      "Password": voters.Password,
      "Cnic": voters.Cnic,
      "Phone_No": voters.Phone_No,
      "img": voters.img
    };
  }

  factory Voters.fromJson(Map<String, dynamic> json) {
    return Voters(
      First_Name: json['First_Name'],
      Last_Name: json['Last_Name'],
      Cnic: json['Cnic'],
      Phone_No: json['Phone_No'],
      E_Mail: json['E_Mail'],
      Password: json['Password'],
      Id_: json['_id'],
      img: json['img'],
    );
  }
}
//to convert data from json to variable , and variable to json
// mongodb and vs code send data in json form to flutter
// this class converts json form into varaible bac to mongoDB