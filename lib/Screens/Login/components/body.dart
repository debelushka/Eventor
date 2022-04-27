import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/already_login_an_account.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_password_field.dart';
import '../../../components/rounded_textField.dart';
import '../../mainScreen/main_screen.dart';
import '../../SignUp/signUp_screen.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.1,
            ),
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SvgPicture.asset(
              "assets/images/login.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email/Login",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Eventor();
                    },
                  ),
                );
              },
            ),
            AlreadyHaveAnAccountCheck(
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
            )
          ],
        ),
      ),
    );
  }
}
