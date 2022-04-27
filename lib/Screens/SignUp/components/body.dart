import 'package:eventor_two/Screens/Login/login_screen.dart';
import 'package:eventor_two/components/already_login_an_account.dart';
import 'package:eventor_two/components/rounded_button.dart';
import 'package:eventor_two/components/rounded_password_field.dart';
import 'package:eventor_two/components/rounded_textField.dart';
import 'package:eventor_two/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            SvgPicture.asset(
              "assets/images/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Username",
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(onChanged: (value) {}),
            RoundedButton(
              press: () {},
              text: "SIGN UP",
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              login: false,
            ),
          ],
        ),
      ),
    );
  }
}
