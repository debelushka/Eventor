import 'dart:convert';

import 'package:eventor_two/Screens/mainScreen/main_screen.dart';
import 'package:eventor_two/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';

import '../../../components/already_login_an_account.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_number_field.dart';
import '../../../components/rounded_password_field.dart';
import '../../../data_models/user.dart';
import '../../SignUp/signUp_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController? passController = TextEditingController();
  final TextEditingController? numController = TextEditingController();

  String errorText = "Введите верные данные";
  bool error = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    numController!.addListener(_printLatestValue);
    passController!.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    passController!.dispose();
    numController!.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print(
        'Second text field password: ${passController!.text}\t Second text field number: ${numController!.text}');
  }

  late final User user;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
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
                text: "LOGIN",
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          backgroundColor: kPrimaryColor,
                          content: Text('Ошибок в валидации не найдено')),
                    );
                    user =
                        await users(numController!.text, passController!.text);
                    if (user.username == 'error') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: kPrimaryColor,
                          content:
                              Text('Проверьте правильность введенных данных'),
                        ),
                      );
                    } else {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => Eventor(user: user)),
                          (Route<dynamic> route) => false);
                    }
                  }
                  if (_formKey.currentState == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Error 404")),
                    );
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.02,
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
              ),
              // Container(
              //   child: error
              //       ? Text("$errorText")
              //       : LoginBuilder(
              //           httpService: httpService,
              //           numController: numController,
              //           passController: passController),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  final String userURL = "http://194.87.248.41:8080/userLogin.php";
  users(String nphone, String pass) async {
    Response res =
        await post(Uri.parse(userURL), body: {'nphone': nphone, 'pass': pass});
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      if (!body.isEmpty) {
        return User.fromJson(body[0]);
      } else {
        return User(username: "error");
      }
    } else {
      throw "user not found";
    }
  }
}


// class LoginBuilder extends StatefulWidget {
//   const LoginBuilder({
//     Key? key,
//     required this.httpService,
//     required this.numController,
//     required this.passController,
//   }) : super(key: key);

//   final HttpService httpService;
//   final TextEditingController? numController;
//   final TextEditingController? passController;

//   @override
//   State<LoginBuilder> createState() => _LoginBuilderState();
// }

// class _LoginBuilderState extends State<LoginBuilder> {
//   @override
// //   Widget build(BuildContext context) {
// //     return ;
// //     // return FutureBuilder(
// //     //     future: widget.httpService
// //     //         .users(widget.numController!.text, widget.passController!.text),
//         builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
//           if (snapshot.hasError) print(snapshot.error);
//           if (snapshot.hasData) {
//             User user = snapshot.data!;
//             if (user.username == "error") {
//               return Text("Такого пользователя не существует");
//             } else {
//              await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Eventor(
//                     user: user,
//                   ),
//                 ),
//               );
//               return const Center(child: CircularProgressIndicator());
//             }
//           } else {
// //     //         return Text("Подождите");
// //     //       }
// //     //     });
//   }
// }
