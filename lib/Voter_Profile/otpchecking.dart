import 'package:app/apiController.dart';
import 'package:flutter/material.dart';

class otpchecking extends StatefulWidget {
  otpchecking(
      {super.key,
        required this.otp,
        required this.candidateid,
        required this.userid,
        required this.electionid});
  String otp, candidateid, electionid,userid;

  @override
  State<otpchecking> createState() => _otpcheckingState();
}

class _otpcheckingState extends State<otpchecking> {
  TextEditingController otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "OTP",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text(
                "The First 3 digits of otp is send to your email and last 3 digits to yours mobile number",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: otp,
                maxLength: 6,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide:
                    const BorderSide(color: Colors.black45, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.add_card),
                  hintText: "Enter your OTP",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (otp.text == widget.otp) {
                      bool c = await Apihelper.castvote(widget.userid,
                          widget.electionid, widget.candidateid,context);
                      if (c) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Try Again"),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Invalid OTP"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
