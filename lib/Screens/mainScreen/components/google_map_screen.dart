import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:eventor_two/components/rounded_button.dart';
import 'package:eventor_two/constants.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/rounded_textField.dart';
import '../../../components/textField_container.dart';
import '../../../controller/MarkerController.dart';

import '../../../data_models/marker.dart';
import '../../../data_models/user.dart';
import 'package:date_field/date_field.dart';
import 'widgets/resize_image.dart';

class GoogleMapScreen extends StatefulWidget {
  late User user;
  GoogleMapScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Marker? _origin;

  @override
  void dispose() {
    super.dispose();
  }

  ImageCropper imageC = ImageCropper();
  Future<void> _onMapCreated(GoogleMapController controller) async {
    List<UMarker> markerList = await httpO.getMarkers();

    for (final marker in markerList) {
      Uint8List m = await imageC.resizeAndCircle(marker.image!, 150);

      _markers[marker.username!] = Marker(
          markerId: MarkerId(marker.username!),
          infoWindow: InfoWindow(title: marker.username),
          icon: BitmapDescriptor.fromBytes(m),
          position: LatLng(
            double.parse(marker.latitude!),
            double.parse(marker.longitude!),
          ),
          onTap: () {
            _showMarker(marker);
          });
    }

    setState(() {});
  }

  _showMarker(UMarker marker) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              height: size.height * 0.5,
              color: Colors.white,
              child: Center(
                child: ListView(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: size.width * 0.45,
                              height: size.height * 0.2,
                              child: Image.network(
                                marker.image!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
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
                                    marker.username!,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Icon(
                                    Icons.date_range,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Text(
                                  marker.date!,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Icon(
                                    Icons.timer,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Text(
                                  marker.time!,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: size.width * 0.8,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(30)),
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
                              marker.desc!,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                    RoundedButton(
                        text: "Открыть telegram канал мероприятия",
                        press: () {
                          _launchUrl(marker.telegram!);
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  final Map<String, Marker> _markers = {};
  HttpService httpO = HttpService();
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GoogleMap(
      onLongPress: (argument) => _addMarker(argument),
      onMapCreated: _onMapCreated,
      zoomControlsEnabled: false,
      initialCameraPosition: const CameraPosition(
        target: LatLng(45.020237, 39.030983),
        zoom: 17,
      ),
      markers: _markers.values.toSet(),
    );
  }

  _addMarker(LatLng pos) {
    late String date;
    late String time;

    final TextEditingController? descController = TextEditingController();
    final TextEditingController? imageController = TextEditingController();
    final TextEditingController? telegramController = TextEditingController();

    Size size = MediaQuery.of(context).size;
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 0, bottom: MediaQuery.of(context).viewInsets.bottom + 15),
          child: Container(
            height: size.height * 0.4,
            child: ListView(
              children: <Widget>[
                TextFieldContainer(
                  child: DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Only date',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    lastDate: DateTime.now().add(const Duration(days: 7)),
                    firstDate: DateTime.now().add(const Duration(days: 0)),
                    initialEntryMode: DatePickerEntryMode.calendar,
                    dateFormat: DateFormat('yyyy-MM-dd'),
                    use24hFormat: true,
                    onDateSelected: (DateTime value) {
                      date = "${value.day}-${value.month}-${value.year}";
                    },
                  ),
                ),
                TextFieldContainer(
                  child: DateTimeFormField(
                    dateFormat: DateFormat.Hm(),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Only time',
                    ),
                    mode: DateTimeFieldPickerMode.time,
                    use24hFormat: true,
                    onDateSelected: (DateTime value) {
                      time = "${value.hour}:${value.minute}";
                    },
                  ),
                ),
                RoundedInputField(
                  usernameController: imageController,
                  icon: Icons.image,
                  hintText: "Enter URL images",
                ),
                RoundedInputField(
                  usernameController: descController,
                  icon: Icons.description,
                  hintText: "Enter description",
                ),
                RoundedInputField(
                  usernameController: telegramController,
                  icon: Icons.description,
                  hintText: "Enter url telegram chat",
                ),
                RoundedButton(
                  text: "Создать маркер",
                  press: () async {
                    UMarker marker = UMarker.create(
                      username: widget.user.username,
                      image: imageController!.text,
                      date: date,
                      time: time,
                      desc: descController!.text,
                      latitude: pos.latitude.toString(),
                      longitude: pos.longitude.toString(),
                      telegram: telegramController!.text,
                    );

                    UMarker markerError = await httpO.markersAdd(marker);
                    if (markerError.error!) {
                      print("ERROR");
                    } else
                      print("VSE horosho");
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
