import 'package:eventor_two/Screens/Login/login_screen.dart';
import 'package:eventor_two/Screens/SignUp/signUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:eventor_two/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eventor_two/components/rounded_button.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.15,
            ),
            const Text(
              "WELCOME TO EVENTOR",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SvgPicture.asset(
              "assets/images/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
                text: "LOGIN",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                }),
            RoundedButton(
              text: "SIGN UP",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpScreen();
                    },
                  ),
                );
              },
              textColor: Colors.black,
              color: kPrimaryLightColor,
            )
          ],
        ),
      ),
    );
  }
}
