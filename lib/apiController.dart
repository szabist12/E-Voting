import 'package:app/Admin_Profile/Admin_home.dart';
import 'package:app/Admin_Profile/admin_profile.dart';
import 'package:app/Admins.dart';
import 'package:app/Candidate_Profile/Candidate_home.dart';
import 'package:app/Candidate_Profile/candidate_profile.dart';
import 'package:app/Candidates.dart';
import 'package:app/Voter_Profile/Profile.dart';
import 'package:app/Voters.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Voter_Profile/NextPage.dart';

class Apihelper {
  static String baseurl = "http://192.168.43.152:5000/";

  static Future<bool> sendotp(String number1, String number2, String email,
      String number, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}sendotp"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "number1": number1,
            "number2": number2,
            "email": email,
            "number": number
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> castvote(
      String uid, String id, String cid, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}castvote"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"uid": uid, "id": id, "cid": cid}));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> registration(String type, String startdate,
      String enddate, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}createelction"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "type": type,
            "startdate": startdate,
            "enddate": enddate,
            "users": [],
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<List> getallelction() async {
    try {
      var response = await http.post(Uri.parse("${baseurl}getelection"),
          headers: {"Content-Type": "application/json"});
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> registercandidatetoelection(
      String id, Map dataa, BuildContext context) async {
    try {
      var response =
      await http.post(Uri.parse("${baseurl}registercandidatetoelection"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "data": dataa,
            "id": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> deletecandidatetoelection(
      String id, String dataa, BuildContext context) async {
    try {
      var response =
      await http.post(Uri.parse("${baseurl}deletecandidatetoelection"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "data": dataa,
            "id": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<Map> findcandidatebyid(String id, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}findcandidatebyid"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      return {};
    }
  }

  static Future<Map> getonecandidate(String Cnic, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}getonecandidate"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "Cnic": Cnic,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      return {};
    }
  }

  static Future<Map> getonevoter(String Cnic, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}getonevoter"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "Cnic": Cnic,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      return {};
    }
  }

  static Future<bool> updatepasswordvoter(
      String Cnic, String Password, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}updatepasswordvoter"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "Cnic": Cnic,
            "Password": Password,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updatepasswordcandidate(
      String Cnic, String Password, BuildContext context) async {
    try {
      var response =
      await http.post(Uri.parse("${baseurl}updatepasswordcandidate"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "Cnic": Cnic,
            "Password": Password,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updatestatuslist(
      String id, List dataa, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}updatestatuslist"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "data": dataa,
            "id": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updatevoterimg(
      String id, String img, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}updatevoterimg"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "img": img,
            "id": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updatecandiateimg(
      String id, String img, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}updatecandiateimg"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "img": img,
            "id": id,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deletecandiate(String Cnic, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}deletecandiate"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "Cnic": Cnic,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deletevoter(String Cnic, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}deletevoter"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "Cnic": Cnic,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['status'] as bool;
    } catch (e) {
      return false;
    }
  }

  static Future<Map> voterimage(String Cnic, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}voterimage"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "Cnic": Cnic,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['data'] as Map;
    } catch (e) {
      return {};
    }
  }

  static Future<Map> candidateimage(String Cnic, BuildContext context) async {
    try {
      var response = await http.post(Uri.parse("${baseurl}candidateimage"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "Cnic": Cnic,
          }));
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['data'] as Map;
    } catch (e) {
      return {};
    }
  }
}





















class apiController {
 // static String localhost = '10.0.2.2';
  static String localhost = '192.168.43.152';

  final BuildContext? context;

  apiController({this.context});

  Future<void> insertVoterData(String firstName, String lastName, String cnic,
      String phoneNo, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://$localhost:5000/api/insertVoter'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'First_Name': firstName,
        'Last_Name': lastName,
        'Cnic': cnic,
        'Phone_No': phoneNo,
        'E_Mail': email,
        'Password': password,
        "img": ""
      }),
    );

    if (response.statusCode == 201) {
      print('Voter data inserted successfully');
    } else if (response.statusCode == 400) {
      print('CNIC already exists');
    } else {
      print('Failed to insert voter data. Error: ${response.body}');
    }
  }

  Future<void> insertCandidateData(String firstName, String lastName,
      String cnic, String phoneNo, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://$localhost:5000/api/insertCandidate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'First_Name': firstName,
        'Last_Name': lastName,
        'Cnic': cnic,
        'Phone_No': phoneNo,
        'E_Mail': email,
        'Password': password,
        "img": ""
      }),
    );
    if (response.statusCode == 201) {
      print('Candidate data inserted successfully');
    } else if (response.statusCode == 400) {
      print('CNIC already exists');
    } else {
      print('Failed to insert candidate data. Error: ${response.body}');
    }
  }

  Future<void> insertAdminData(String firstName, String lastName, String cnic,
      String phoneNo, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://$localhost:5000/api/insertAdmin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'First_Name': firstName,
        'Last_Name': lastName,
        'Cnic': cnic,
        'Phone_No': phoneNo,
        'E_Mail': email,
        'Password': password,
      }),
    );

    if (response.statusCode == 201) {
      print('Admin data inserted successfully');
    } else if (response.statusCode == 400) {
      print('CNIC already exists');
    } else {
      print('Failed to insert admin data. Error: ${response.body}');
    }
  }

  Future<void> deleteVoterData(String cnic) async {
    final response = await http.delete(
      Uri.parse('http://$localhost:5000/api/deleteVoter/$cnic'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print('Voter data deleted successfully');
    } else if (response.statusCode == 404) {
      print('Voter not found with the provided CNIC');
    } else {
      print('Failed to delete voter data. Error: ${response.body}');
    }
  }

  Future<void> deleteCandidateData(String cnic) async {
    final response = await http.delete(
      Uri.parse('http://$localhost:5000/api/deleteCandidate/$cnic'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print('Candidate data deleted successfully');
    } else if (response.statusCode == 404) {
      print('Voter not found with the provided CNIC');
    } else {
      print('Failed to delete candidate data. Error: ${response.body}');
    }
  }

  Future<void> deleteAdminData(String cnic) async {
    final response = await http.delete(
      Uri.parse('http://$localhost:5000/api/deleteAdmin/$cnic'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print('Admin data deleted successfully');
    } else if (response.statusCode == 404) {
      print('Voter not found with the provided CNIC');
    } else {
      print('Failed to delete admin data. Error: ${response.body}');
    }
  }

  static Future<List<Map<String, dynamic>>> getAllVoters() async {
    final response = await http.get(
      Uri.parse('http://$localhost:5000/api/getAllVoters'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load voter data. Error: ${response.body}');
    }
  }

  static Future<List<Map<String, dynamic>>> getAllCandidates() async {
    final response = await http.get(
      Uri.parse('http://$localhost:5000/api/getAllCandidates'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load candidate data. Error: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> getAllAdmins() async {
    final response = await http.get(
      Uri.parse('http://$localhost:5000/api/getAllAdmins'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load admin data. Error: ${response.body}');
    }
  }

  Future<void> loginVoters(
      String cnic, String password, BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://$localhost:5000/api/loginVoters'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'Cnic': cnic,
        'Password': password,
      }),
    );
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Voters user = Voters.fromJson(data['voter']);

        print('Login successful: ${data['message']}');
        print(user.First_Name);
        print(user.Last_Name);
        print(user.Cnic);
        print(user.Phone_No);
        print(user.E_Mail);
        print(user.img);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NextPage(user)),
        );
      } else if (response.statusCode == 401) {
        print('Invalid credentials');
      } else {
        print('Failed to login. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> loginAdmins(
      String cnic, String email, String password, BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://$localhost:5000/api/loginAdmins'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'Cnic': cnic,
        'E_Mail': email,
        'Password': password,
      }),
    );

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Admins user = Admins.fromJson(data['voter']);

        print('Login successful: ${data['message']}');
        print(user.First_Name);
        print(user.Last_Name);
        print(user.Cnic);
        print(user.Phone_No);
        print(user.E_Mail);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Admin_Home(user)),
        );
      } else if (response.statusCode == 401) {
        print('Invalid credentials');
      } else {
        print('Failed to login. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> loginCandidates(
      String cnic, String email, String password, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://$localhost:5000/api/loginCandidates'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'Cnic': cnic,
          'Password': password,
        }),
      );
      try {
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          final Candidates user = Candidates.fromJson(data['voter']);
          print('Login successful: ${data['voter']}');
          print(user.First_Name);
          print(user.Last_Name);
          print(user.Cnic);
          print(user.Phone_No);
          print(user.E_Mail);
          print(user.Id_);
          print(user.img);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Candidate_Home(user)),
          );
        } else if (response.statusCode == 401) {
          print('Invalid credentials');
        } else {
          print('Failed to login. Error: ${response.body}');
        }
      } catch (error) {
        print(error);
      }
    } catch (error) {
      print("api is not working " + error.toString());
    }
  }

  Future<void> updatePhoneNoVoter(
      String cnic, String newPhoneNo, BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse('http://$localhost:5000/api/updatePhoneNoVoter'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'cnic': cnic,
          'newPhoneNo': newPhoneNo,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data =
        json.decode(response.body); // Use nullable type

        if (data != null) {
          // Check if data is not null
          final message =
          data['message']; // Access properties using null-aware operators
          final result = data['result'];
          print(message);
          print(result);

          final Voters user = Voters.fromJson(result);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(user),
            ),
          );
          // Handle the response accordingly
        }
      } else if (response.statusCode == 404) {
        print('Voter not found with the provided CNIC');
      } else {
        print('Failed to update Phone_No. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateEMailVoter(
      String cnic, String newEMail, BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse('http://$localhost:5000/api/updateEMailVoter'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'cnic': cnic,
          'newEMail': newEMail,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data =
        json.decode(response.body); // Use nullable type

        if (data != null) {
          // Check if data is not null
          final message =
          data['message']; // Access properties using null-aware operators
          final result = data['result'];
          print(message);
          print(result);

          final Voters user = Voters.fromJson(result);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(user),
            ),
          );
          // Handle the response accordingly
        }
      } else if (response.statusCode == 404) {
        print('Voter not found with the provided CNIC');
      } else {
        print('Failed to update E-Mail. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateFirstNameVoter(
      String cnic, String newFirstName, BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse('http://$localhost:5000/api/updateFirstNameVoter'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'cnic': cnic,
          'newFirstName': newFirstName,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data =
        json.decode(response.body); // Use nullable type

        if (data != null) {
          // Check if data is not null
          final message =
          data['message']; // Access properties using null-aware operators
          final result = data['result'];
          print(message);
          print(result);

          final Voters user = Voters.fromJson(result);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(user),
            ),
          );
          // Handle the response accordingly
        }
      } else if (response.statusCode == 404) {
        print('Voter not found with the provided CNIC');
      } else {
        print('Failed to update First_Name. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateLastNameVoter(
      String cnic, String newLastName, BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse('http://$localhost:5000/api/updateLastNameVoter'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'cnic': cnic,
          'newLastName': newLastName,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data =
        json.decode(response.body); // Use nullable type

        if (data != null) {
          // Check if data is not null
          final message =
          data['message']; // Access properties using null-aware operators
          final result = data['result'];
          print(message);
          print(result);

          final Voters user = Voters.fromJson(result);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(user),
            ),
          );
          // Handle the response accordingly
        }
      } else if (response.statusCode == 404) {
        print('Voter not found with the provided CNIC');
      } else {
        print('Failed to update Last_Name. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateFirstNameAdmin(
      String cnic, String newFirstName, BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse('http://$localhost:5000/api/updateFirstNameAdmin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'cnic': cnic,
          'newFirstName': newFirstName,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data =
        json.decode(response.body); // Use nullable type

        if (data != null) {
          // Check if data is not null
          final message =
          data['message']; // Access properties using null-aware operators
          final result = data['result'];
          print(message);
          print(result);

          final Admins user = Admins.fromJson(result);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => admin_ProfilePage(user),
            ),
          );
          // Handle the response accordingly
        }
      } else if (response.statusCode == 404) {
        print('Admin not found with the provided CNIC');
      } else {
        print('Failed to update First_Name. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateLastNameAdmin(
      String cnic, String newLastName, BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse('http://$localhost:5000/api/updateLastNameAdmin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'cnic': cnic,
          'newLastName': newLastName,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data =
        json.decode(response.body); // Use nullable type

        if (data != null) {
          // Check if data is not null
          final message =
          data['message']; // Access properties using null-aware operators
          final result = data['result'];
          print(message);
          print(result);

          final Admins user = Admins.fromJson(result);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => admin_ProfilePage(user),
            ),
          );
          // Handle the response accordingly
        }
      } else if (response.statusCode == 404) {
        print('Admin not found with the provided CNIC');
      } else {
        print('Failed to update Last_Name. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updatePhoneNoAdmin(
      String cnic, String newPhoneNo, BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse('http://$localhost:5000/api/updatePhoneNoAdmin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'cnic': cnic,
          'newPhoneNo': newPhoneNo,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data =
        json.decode(response.body); // Use nullable type

        if (data != null) {
          // Check if data is not null
          final message =
          data['message']; // Access properties using null-aware operators
          final result = data['result'];
          print(message);
          print(result);

          final Admins user = Admins.fromJson(result);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => admin_ProfilePage(user),
            ),
          );
          // Handle the response accordingly
        }
      } else if (response.statusCode == 404) {
        print('Admin not found with the provided CNIC');
      } else {
        print('Failed to update Phone_No. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateEMailAdmin(
      String cnic, String newEMail, BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse('http://$localhost:5000/api/updateEMailAdmin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'cnic': cnic,
          'newEMail': newEMail,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data =
        json.decode(response.body); // Use nullable type

        if (data != null) {
          // Check if data is not null
          final message =
          data['message']; // Access properties using null-aware operators
          final result = data['result'];
          print(message);
          print(result);

          final Admins user = Admins.fromJson(result);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => admin_ProfilePage(user),
            ),
          );
          // Handle the response accordingly
        }
      } else if (response.statusCode == 404) {
        print('Admin not found with the provided CNIC');
      } else {
        print('Failed to update E-Mail. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateFirstNameCandidate(
      String cnic, String newFirstName, BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse('http://$localhost:5000/api/updateFirstNameCandidate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'cnic': cnic,
          'newFirstName': newFirstName,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data =
        json.decode(response.body); // Use nullable type

        if (data != null) {
          // Check if data is not null
          final message =
          data['message']; // Access properties using null-aware operators
          final result = data['result'];
          print(message);
          print(result);

          final Candidates user = Candidates.fromJson(result);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => candidate_ProfilePage(user),
            ),
          );
          // Handle the response accordingly
        }
      } else if (response.statusCode == 404) {
        print('Candidate not found with the provided CNIC');
      } else {
        print('Failed to update First_Name. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateLastNameCandidate(
      String cnic, String newLastName, BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse('http://$localhost:5000/api/updateLastNameCandidate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'cnic': cnic,
          'newLastName': newLastName,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data =
        json.decode(response.body); // Use nullable type

        if (data != null) {
          // Check if data is not null
          final message =
          data['message']; // Access properties using null-aware operators
          final result = data['result'];
          print(message);
          print(result);

          final Candidates user = Candidates.fromJson(result);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => candidate_ProfilePage(user),
            ),
          );
          // Handle the response accordingly
        }
      } else if (response.statusCode == 404) {
        print('Candidate not found with the provided CNIC');
      } else {
        print('Failed to update Last_Name. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updatePhoneNoCandidate(
      String cnic, String newPhoneNo, BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse('http://$localhost:5000/api/updatePhoneNoCandidate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'cnic': cnic,
          'newPhoneNo': newPhoneNo,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data =
        json.decode(response.body); // Use nullable type

        if (data != null) {
          // Check if data is not null
          final message =
          data['message']; // Access properties using null-aware operators
          final result = data['result'];
          print(message);
          print(result);

          final Candidates user = Candidates.fromJson(result);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => candidate_ProfilePage(user),
            ),
          );
          // Handle the response accordingly
        }
      } else if (response.statusCode == 404) {
        print('Candidate not found with the provided CNIC');
      } else {
        print('Failed to update Phone_No. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateEMailCandidate(
      String cnic, String newEMail, BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse('http://$localhost:5000/api/updateEMailCandidate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'cnic': cnic,
          'newEMail': newEMail,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data =
        json.decode(response.body); // Use nullable type

        if (data != null) {
          // Check if data is not null
          final message =
          data['message']; // Access properties using null-aware operators
          final result = data['result'];
          print(message);
          print(result);

          final Candidates user = Candidates.fromJson(result);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => candidate_ProfilePage(user),
            ),
          );
          // Handle the response accordingly
        }
      } else if (response.statusCode == 404) {
        print('Candidate not found with the provided CNIC');
      } else {
        print('Failed to update E-Mail. Error: ${response.body}');
      }
    } catch (error) {
      print(error);
    }
  }
}
