import 'package:eventor_two/Screens/Login/login_screen.dart';
import 'package:eventor_two/Screens/Welcome/welcome_screen.dart';
import 'package:eventor_two/components/already_login_an_account.dart';
import 'package:eventor_two/components/rounded_button.dart';
import 'package:eventor_two/components/rounded_password_field.dart';
import 'package:eventor_two/components/rounded_textField.dart';
import 'package:eventor_two/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';

import '../../../components/rounded_number_field.dart';
import '../../../data_models/user.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController? numController = TextEditingController();
  final TextEditingController? passController = TextEditingController();
  final TextEditingController? usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errorText = "Введите верные данные";
  bool error = true;
  void initState() {
    super.initState();
    usernameController!.addListener(_printLatestValue);
    numController!.addListener(_printLatestValue);
    passController!.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    usernameController!.dispose();
    passController!.dispose();
    numController!.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print(
        'Second text field password: ${passController!.text}\t Second text field number: ${numController!.text}\t${usernameController!.text}');
  }

  late final User user;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGN UP",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(
                "assets/images/signup.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Your username",
                usernameController: usernameController,
                onChanged: (value) {},
              ),
              RoundedNumberInputField(
                numController: numController,
                hintText: "Your Phone Number",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                passController: passController,
                onChanged: (value) {},
              ),
              RoundedButton(
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    user = await usersAdd(usernameController!.text,
                        numController!.text, passController!.text);
                    if (user.username == 'error') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: kPrimaryColor,
                          content: Text('Сервер недоступен'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: kPrimaryColor,
                          content:
                              Text('Данные успешно занесены в базу данных'),
                        ),
                      );
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const WelcomeScreen()),
                          (Route<dynamic> route) => false);
                    }
                  } else {}
                },
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
      ),
    );
  }

  final String userAddURL = "http://194.87.248.41:8080/userAdd.php";
  Future<User> usersAdd(String username, String nphone, String pass) async {
    Response res = await post(Uri.parse(userAddURL),
        body: {'username': username, 'nphone': nphone, 'pass': pass});
    if (res.statusCode == 200) {
      return User(username: "okay");
    } else {
      return User(username: "error");
    }
  }
}
