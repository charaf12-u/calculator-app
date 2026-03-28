import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:tp/compend/TextFormFaild.dart';
import 'package:tp/compend/customButton.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future signInWithGoogle() async {
    try {
      // بدء عملية تسجيل الدخول باستخدام Google
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId:
            "613189428281-rq3dpuhapn3hheh9tdo3f8uaskorruk9.apps.googleusercontent.com",
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        debugPrint('تم إلغاء تسجيل الدخول من قبل المستخدم');
        return; // المستخدم ألغى تسجيل الدخول
      }

      // الحصول على تفاصيل المصادقة من الطلب
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // إنشاء بيانات الاعتماد
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // تسجيل الدخول باستخدام بيانات الاعتماد
      await FirebaseAuth.instance.signInWithCredential(credential);

      // التوجيه إلى صفحة "الصفحة الرئيسية" بعد تسجيل الدخول
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil("homePage", (route) => false);
    } catch (error) {
      debugPrint('حدث خطأ أثناء تسجيل الدخول باستخدام Google: $error');
    }
  }

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
                "Login",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(height: 20),
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
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.topRight,
              child: Text("Forget Password ?", style: TextStyle(fontSize: 14)),
            ),
            Container(height: 6),
            CustomButton(
              text: "Login",
              onPressed: () async {
                if (email.text.isNotEmpty || password.text.isNotEmpty) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                    if (credential.user!.emailVerified) {
                      Navigator.of(context).pushReplacementNamed("homePage");
                    } else {
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                      toastification.show(
                        context:
                            context, // optional if you use ToastificationWrapper
                        title: Text('please verifier email'),
                        autoCloseDuration: const Duration(seconds: 5),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      toastification.show(
                        context:
                            context, // optional if you use ToastificationWrapper
                        title: Text('No user found for that email.'),
                        autoCloseDuration: const Duration(seconds: 5),
                      );
                    } else if (e.code == 'wrong-password') {
                      toastification.show(
                        context:
                            context, // optional if you use ToastificationWrapper
                        title: Text('Wrong password provided for that user.'),
                        autoCloseDuration: const Duration(seconds: 5),
                      );
                    }
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

            Container(height: 66),

            Text("or login", textAlign: TextAlign.center),
            Container(height: 16),

            CustomButton(
              text: "Login with google",
              onPressed: () {
                debugPrint("Login button pressed");
                signInWithGoogle();
              },
            ),

            Container(height: 36),

            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("signup");
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "dont have acount ?"),
                    TextSpan(
                      text: "register",
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
