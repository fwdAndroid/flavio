import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flavio/main_pages/main_sub_zonal_page.dart';
import 'package:flavio/status/blockuser.dart';
import 'package:flavio/widgets/text_form_field_widget.dart';
import 'package:flavio/widgets/utils.dart';
import 'package:flavio/zonals/main_zonal_page.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({
    Key? key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _isLoading = false;
  bool _isHidden = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    passController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    bool wrongEmail = false; // to check if email entered exists
    bool wrongPassword = false; // to check if password entered is correct
    bool emailDisabled = false; // to check if the user is disabled
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/splash.png",
                height: 200,
              ),
              Text(
                "Login Platform",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormInputField(
                hintText: 'Enter youe email',
                textInputType: TextInputType.emailAddress,
                controller: emailController,
              ),
              SizedBox(
                height: 23,
              ),
              TextField(
                controller: passController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _isHidden,
                decoration: InputDecoration(
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                  fillColor: Colors.white,
                  hintText: 'Password',
                  suffix: InkWell(
                    onTap: _togglePasswordView,
                    child: Icon(
                      _isHidden ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 23,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    fixedSize: Size(300, 50),
                    shape: StadiumBorder()),
                onPressed: () async {
                  if (emailController.text.isEmpty &&
                      passController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("email and password is missing"),
                      duration: Duration(seconds: 2),
                    ));
                  } else if (emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("email is required"),
                      duration: Duration(seconds: 2),
                    ));
                  } else if (passController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("password is required"),
                      duration: Duration(seconds: 2),
                    ));
                  } else {
                    loginUser();
                  }
                  print("Print");
                },
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
              SizedBox(
                height: 13,
              ),
            ],
          ),
        )));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void checckstatus() async {
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection('usersmanagers')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final DocumentSnapshot userSnapshot = await userRef.get();
    Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;

    ;
    final isBlocked = data['blocked'];
    if (isBlocked == true) {
      // User is blocked
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => BlockUser()));
    } else if (data['type'] == "Zone Manager") {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => MainZonalPage()));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login Complete")));
    } else if (data['type'] == "Sub Zone Manager") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) => MainSubZonelPage(
                    area: data['area'],
                    name: data['name'],
                  )));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login Complete")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No User Found")));
    }
  }

  void loginUser() async {
    try {
      await FirebaseFirestore.instance
          .collection("usersmanagers")
          .get()
          .then((QuerySnapshot snapshot) {
        print("sad");
        snapshot.docs.forEach((element) {
          if (element['password'] == passController.text &&
              element['email'] == emailController.text) {
            FirebaseAuth.instance
                .signInWithEmailAndPassword(
              email: emailController.text,
              password: passController.text,
            )
                .then((value) {
              checckstatus();
            });
          } else {
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text("w")));
          }
        });
      });
    } catch (e) {
      Customdialog().showInSnackBar(e.toString(), context);
    }
  }
}
