import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evente_mobile_admin_app/Screen/Update_event_detailScreen.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import 'package:evente/evente.dart';
import '../../../base/constant.dart';
import '../../widget/empty_screen.dart';
import 'package:evente/evente.dart';
import '../base/color_data.dart';
import '../base/widget_utils.dart';
import '../bloc/sign_up_bloc.dart';
import '../model/users_model.dart';
import '../widget/map_sheet.dart';
import 'Barcode_Scanner_Screen.dart';
import 'JoinEventDetailListScreen.dart';

class FeaturedEvent2Detail extends StatefulWidget {
  Event? event;
  String? id;
  FeaturedEvent2Detail({
    Key? key,
    this.event,
    this.id,
  }) : super(key: key);

  @override
  State<FeaturedEvent2Detail> createState() => _FeaturedEvent2DetailState();
}

class _FeaturedEvent2DetailState extends State<FeaturedEvent2Detail> {
  void backClick() {
    Navigator.of(context).pop();
  }

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  void deleteDoc(){
        FirebaseFirestore.instance.collection("event").doc(widget.id).delete();
                            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Delete Success',
              textAlign: TextAlign.center,
            ),
          ),
        );
                            Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<SignInBloc>();
    final Event event = widget.event!;
// event.joinEvent!.forEach((id, data) {
//     String name = data['name'];
//     String photoProfile = data['photoProfile'];
//     String id = data['id'];
//     print('Name: $name');
//     print('Name: $photoProfile');
//     print('Name: $id');
//   });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: buildImageWidget(),
          ),
        ],
      ),
    );
  }

  Widget buildFollowWidget(BuildContext context) {
    final Event event = widget.event!;
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: 20),
      Container(
        // decoration: BoxDecoration(
        //     color: lightGrey, borderRadius: BorderRadius.circular(22 )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      backgroundImage: NetworkImage(event.image ?? ''),
                      radius: 20.0),
                  // getAssetImage("image.png", width: 58 , height: 58 ),
                  getHorSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(event.userName ?? '', 18, Colors.black, 1,
                          fontWeight: FontWeight.w600, txtHeight: 1.5),
                    ],
                  )
                ],
              ),
              // getButton(context, Colors.white, "Follow", accentColor, () {}, 14 ,
              //     weight: FontWeight.w700,
              //     buttonHeight: 40 ,
              //     buttonWidth: 76 ,
              //     isBorder: true,
              //     borderColor: accentColor,
              //     borderWidth: 1 ,
              //     borderRadius: BorderRadius.circular(14 ))
            ],
          ),
        ),
      ),
    );
  }

  Container buildTicketPrice() {
    final Event event = widget.event!;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: accentColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(22)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              getSvgImage("ticket.svg",
                  width: 24, height: 24, color: Colors.black),
              getHorSpace(5),
              getRichText("Ticket Price ", Colors.black, FontWeight.w600, 15,
                  "", greyColor, FontWeight.w500, 13),
            ],
          ),
          getCustomFont(
              "\$" + event.price.toString() ?? "", 20, Colors.black, 1,
              fontWeight: FontWeight.w700)
        ],
      ),
    );
  }

  Widget buildImageWidget() {
    final sb = context.watch<SignInBloc>();
    final Event event = widget.event!;

    DateTime? dateTime = event.date?.toDate();
    String date = DateFormat('d MMMM, yyyy').format(dateTime!);
    return ListView(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 327,
              width: double.infinity,
              decoration: BoxDecoration(
                  // borderRadius:
                  //     BorderRadius.vertical(bottom: Radius.circular(22 )),
                  image: DecorationImage(
                      image: NetworkImage(event.image ?? ''),
                      fit: BoxFit.cover)),
              alignment: Alignment.topCenter,
              child: Container(
                height: 183,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          darkShadow.withOpacity(0.6),
                          lightShadow.withOpacity(0.0)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 1.0])),
                child: getPaddingWidget(
                  EdgeInsets.only(top: 26, right: 20, left: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            color: Colors.white),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Icon(Icons.arrow_back_ios_new,
                                color: Colors.black, size: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 300,
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor,
                            blurRadius: 27,
                            offset: const Offset(0, 8))
                      ]),
                ))
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                      color: greyColor.withOpacity(0.4),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                ),
              ),
              getVerSpace(20),
              Row(
                children: [
                  getCustomFont(
                    date ?? '',
                    14,
                    fontFamily: "Sofia",
                    greyColor,
                    1,
                    fontWeight: FontWeight.w500,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                      height: 5.0,
                      width: 3.0,
                      color: greyColor.withOpacity(0.5),
                    ),
                  ),
                  getCustomFont(
                    event.time ?? '',
                    fontFamily: "Sofia",
                    14,
                    greyColor,
                    1,
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),

//               Text(
//   event.joinEvent != null && event.joinEvent!.isNotEmpty
//       ? event.joinEvent!.values.first['name']
//       : 'Tidak ada data joinEvent',
// ),
              getCustomFont(event.title ?? '', 22, Colors.black, 1,
                  fontWeight: FontWeight.w700, txtHeight: 1.5),
              getVerSpace(10),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.black26,
                  ),
                  getHorSpace(5),
                  Container(
                    width: 300,
                    child: getCustomFont(
                      event.location ?? '',
                      17,
                      greyColor,
                      1,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),

              getVerSpace(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getCustomFont(
                    'People Joined :',
                    17,
                    greyColor,
                    1,
                    fontWeight: FontWeight.w500,
                  ),
                  Container(
                    width: 20,
                    height: 30,
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("JoinEvent")
                        .doc("user")
                        .collection(event.title ?? '')
                        .snapshots(),
                    builder: (BuildContext ctx,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      return snapshot.hasData
                          ? joinEvents(
                              list: snapshot.data?.docs,
                            )
                          : Container();
                    },
                  ),
                ],
              ),

              getVerSpace(20),
              buildTicketPrice(),
              getVerSpace(20),
              getCustomFont('Description', 19, Colors.black, 1,
                  fontWeight: FontWeight.w700, txtHeight: 1.5),
              getVerSpace(20),
              getPaddingWidget(
                EdgeInsets.symmetric(horizontal: 20),
                ReadMoreText(
                  event.description ?? "",
                  trimLines: 8,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read more...',
                  trimExpandedText: 'Show less',
                  style: TextStyle(
                      fontFamily: 'Sofia',
                      color: greyColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      height: 1.5),
                  lessStyle: TextStyle(
                      fontFamily: 'Sofia',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: accentColor),
                  moreStyle: TextStyle(
                      fontFamily: 'Sofia',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: accentColor),
                ),
              ),

              getVerSpace(45),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 206,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(22)),
                    child: GoogleMap(
                      trafficEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(event.mapsLatLink as double,
                            event.mapsLangLink as double),
                        zoom: 12,
                      ),
                      onMapCreated: _onMapCreated,
                      markers: {
                        Marker(
                          markerId: const MarkerId("marker1"),
                          position: LatLng(event.mapsLatLink as double,
                              event.mapsLangLink as double),
                          draggable: true,
                          onDragEnd: (value) {
                            // value is the new position
                          },
                          // To do: custom marker icon
                        ),
                      },
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: true,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                    ),
                  ),
                  InkWell(
                    onTap: (() {
                      MapsSheet.show(
                        context: context,
                        onMapTap: (map) {
                          map.showDirections(
                            destination: Coords(event.mapsLatLink as double,
                                event.mapsLangLink as double),
                            directionsMode: DirectionsMode.driving,
                          );
                        },
                      );
                    }),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        height: 150,
                        width: 40.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 27,
                                  offset: const Offset(0, 8))
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.navigation_rounded,
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              RotatedBox(
                                quarterTurns:
                                    3, // mengatur rotasi sebesar 90 derajat
                                child: Text(
                                  'Navigate',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Sofia',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              getVerSpace(45),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
  StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("JoinEvent")
                    .doc("user")
                    .collection(event.title ?? '')
                    .snapshots(),
                builder:
                    (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  final user = snapshot.data?.docs.map((e) {
                    return UserModel.fromFirestore(e);
                  }).toList();
                  return snapshot.hasData
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    JoinEventDetailListScreen(
                                      list: snapshot.data?.docs,
                                    )));
                          },
                          child: Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width/2.2,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                color: Colors.green),
                            child: const Center(
                              child: Text(
                                "See Join Event",
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              ),

             InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    BarcodeScannerScreen(
                                       eventModel: widget.event,
                                    )));
                          },
                          child: Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width/2.2,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                color: Colors.blueAccent),
                            child: Center(
                              child: Text(
                                "Scan E Ticket",
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                     

                ],
              ),

              SizedBox(height: 10.0,),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("JoinEvent")
                    .doc("user")
                    .collection(event.title ?? '')
                    .snapshots(),
                builder:
                    (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  final user = snapshot.data?.docs.map((e) {
                    return UserModel.fromFirestore(e);
                  }).toList();
                  return snapshot.hasData
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    UpdateEventDetailScreen(
                                      event:widget.event,
                                      id: widget.id,
                                    )));
                          },
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                color: accentColor),
                            child: Center(
                              child: Text(
                                "Update Event",
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              ),

              SizedBox(
                height: 10.0,
              ),
  StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("JoinEvent")
                    .doc("user")
                    .collection(event.title ?? '')
                    .snapshots(),
                builder:
                    (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  final user = snapshot.data?.docs.map((e) {
                    return UserModel.fromFirestore(e);
                  }).toList();
                  return snapshot.hasData
                      ? InkWell(
                          onTap: () {
                        // deleteDoc();

          //                 const SnackBar(
          //   backgroundColor: Colors.redAccent,
          //   content: Text(
          //     'This Feature Ready on Release APL',
          //     textAlign: TextAlign.center,
          //   ),
          // );

                  showDialog(context: context, builder: (context){
                  return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(37 ),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 20 ),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          getVerSpace(30 ),
          Container(
            width: double.infinity,
            height: 190 ,
            margin: EdgeInsets.symmetric(horizontal: 30 ),
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(34 ))),
            child: Column(
              children: [
                getVerSpace(40 ),  
               Icon(Icons.error,size: 120.0,color: Colors.red,),
              
           ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30 ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(37 ),
                boxShadow: [
                  BoxShadow(
                      color: "#2B9CC3C6".toColor(),
                      offset: const Offset(0, -2),
                      blurRadius: 24)
                ]),
            child: Column(
              children: [
                getVerSpace(30 ),
                getCustomFont('This Feature Not Abble', 22 , Colors.black, 1,
                    fontWeight: FontWeight.w700, txtHeight: 1.5 ),
                getVerSpace(8 ),
                getMultilineCustomFont(
                    "This Feature Ready on Release APK.", 16 , Colors.black,
                    fontWeight: FontWeight.w500, txtHeight: 1.5 ),
                getVerSpace(30 ),
                getButton(context, Colors.redAccent, "Close", Colors.white, () {
                     Navigator.pop(context);
                }, 18 ,
                    weight: FontWeight.w700,
                    buttonHeight: 60 ,
                    borderRadius: BorderRadius.circular(22 )),
                getVerSpace(30 ),
              ],
            ),
          )
        ],
      ),
    );
              
                  });


                          },
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                color: Colors.redAccent),
                            child: Center(
                              child: Text(
                                "Delete Event",
                                style: TextStyle(
                                    fontFamily: "Sofia",
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              ),
              SizedBox(height: 10.0,)
              
            ],
          ),
        ),
      ],
    );
  }
}

class joinEvents extends StatelessWidget {
  joinEvents({this.list});
  final List<DocumentSnapshot>? list;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Container(
              height: 25.0,
              width: 54.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 0.0, left: 5.0, right: 5.0),
                itemCount: list!.length > 3 ? 3 : list?.length,
                itemBuilder: (context, i) {
                  final user = list?.map((e) {
                    return UserModel.fromFirestore(e);
                  }).toList();

                  // String? _title = list?[i]['name'].toString();
                  // String? _uid = list?[i]['uid'].toString();
                  // String? _img = list?[i]['photoProfile'].toString();

                  return Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Container(
                      height: 24.0,
                      width: 24.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(70.0)),
                          image: DecorationImage(
                              image: NetworkImage(user?[i].photoProfile ?? ''),
                              fit: BoxFit.cover)),
                    ),
                  );
                },
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 3.0,
            left: 0.0,
          ),
          child: Row(
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 1.5)),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getCustomFont(
                        list?.length.toString() ?? '', 12, Colors.white, 1,
                        fontWeight: FontWeight.w600),
                    getCustomFont(" +", 12, Colors.white, 1,
                        fontWeight: FontWeight.w600),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
