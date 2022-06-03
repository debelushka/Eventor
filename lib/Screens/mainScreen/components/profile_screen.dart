import 'package:eventor_two/data_models/user.dart';
import 'package:flutter/material.dart';

import '../../../components/textField_container.dart';
import '../../../constants.dart';
import 'widgets/display_image.dart';

class ProfileScreen extends StatefulWidget {
  late User? user;
  ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  ProfileScreenState createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String updateUserValue(dynamic phone) {
    String formattedPhoneNumber = "+7-" +
        phone.substring(0, 3) +
        "-" +
        phone.substring(3, 6) +
        "-" +
        phone.substring(6, 8) +
        "-" +
        phone.substring(8, phone.length);
    return formattedPhoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Profile",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              height: 25,
            ),
            DisplayImage(
              imagePath: widget.user!.image!,
            ),
            SizedBox(
              height: 50,
            ),
            TextFieldContainer(
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                    ),
                    Text(
                      widget.user!.username,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
            TextFieldContainer(
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Icon(
                        Icons.phone,
                        color: kPrimaryColor,
                      ),
                    ),
                    Text(
                      updateUserValue(widget.user!.nphone),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
            TextFieldContainer(
              child: SizedBox(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Icon(
                        Icons.description,
                        color: kPrimaryColor,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        widget.user!.description.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
// <Widget>[
          // Padding(
          //   padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
          //   child: DisplayImage(
          //     imagePath:
          //         "https://sun9-16.userapi.com/s/v1/if1/aYkGzZSlCeniXfbUB6Jht-50FknOeAaro8cJPJzjMveEM9odWxcxziDjymnt5hxDxiXJmKuP.jpg?size=1052x1080&quality=96&type=album",
          //   ),
          // ),
//           TextFieldContainer(
//             child: Row(
//               children: <Widget>[
//                 Icon(
//                   Icons.person,
//                   size: 25,
//                 ),
//                 Text(
//                   "Otemba",
//                   style: TextStyle(fontSize: 25),
//                 )
//               ],
//               mainAxisAlignment: MainAxisAlignment.center,
//             ),
//           ),
//         ],