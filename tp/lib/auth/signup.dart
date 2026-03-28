import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:tp/compend/TextFormFaild.dart';
import 'package:tp/compend/customButton.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController user = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(height: 5),

            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                "Sign UP",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(height: 20),
            CustomTextFaild(
              TextHint: "entrer user name",
              myController: user,
              validator: (val) {
                if (val == "") {
                  return "Can't To be empty";
                }
              },
            ),
            Container(height: 6),
            CustomTextFaild(
              TextHint: "entrer email",
              myController: email,
              validator: (val) {
                if (val == "") {
                  return "Can't To be empty";
                }
              },
            ),
            Container(height: 6),
            CustomTextFaild(
              TextHint: "entrer password",
              myController: password,
              validator: (val) {
                if (val == "") {
                  return "Can't To be empty";
                }
              },
            ),
            Container(height: 36),
            CustomButton(
              text: "Sign UP",
              onPressed: () async {
                if (email.text.isNotEmpty ||
                    password.text.isNotEmpty ||
                    user.text.isNotEmpty) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    Navigator.of(context).pushReplacementNamed("login");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      toastification.show(
                        context:
                            context, // optional if you use ToastificationWrapper
                        title: Text("The password provided is too weak."),
                        autoCloseDuration: const Duration(seconds: 5),
                      );
                    } else if (e.code == 'email-already-in-use') {
                      toastification.show(
                        context:
                            context, // optional if you use ToastificationWrapper
                        title: Text(
                          "The account already exists for that email.",
                        ),
                        autoCloseDuration: const Duration(seconds: 5),
                      );
                    }
                  } catch (e) {
                    toastification.show(
                      context:
                          context, // optional if you use ToastificationWrapper
                      title: Text("$e"),
                      autoCloseDuration: const Duration(seconds: 5),
                    );
                  }
                } else {
                  toastification.show(
                    context:
                        context, // optional if you use ToastificationWrapper
                    title: Text("entrer tout les champ"),
                    autoCloseDuration: const Duration(seconds: 5),
                  );
                }
              },
            ),

            Container(height: 46),

            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("login");
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "have acount ?"),
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
