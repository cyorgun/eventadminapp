import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evente/evente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../base/color_data.dart';
import '../../base/widget_utils.dart';
import '../Screen/featured_event_detail2.dart';

class Card4 extends StatelessWidget {
  final Event events;
  final String heroTag,id;
  const Card4({Key? key, required this.events,required this.id, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? dateTime = events!.date?.toDate();
    String date = DateFormat('d MMMM, yyyy').format(dateTime!);
    return InkWell(
      child: Container(
        height: 150.0,
        margin: EdgeInsets.only(bottom: 20 , left: 20.0, right: 20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: shadowColor,
                  blurRadius: 27,
                  offset: const Offset(0, 8))
            ],
            borderRadius: BorderRadius.circular(22 )),
        padding: EdgeInsets.only(top: 7 , left: 7 , bottom: 6 , right: 20 ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        image: DecorationImage(
                            image: NetworkImage(
                              events?.image ?? '',
                            ),
                            fit: BoxFit.cover)),
                  ),
                  // Image.network(event.image??'',height: 82,width: 82,),
                  // getAssetImage(event.image ?? "",
                  //     width: 82 , height: 82 ),
                  getHorSpace(10 ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          child: getCustomFont(
                              events?.title ?? "", 15.5  , Colors.black, 1,
                              fontWeight: FontWeight.w700,
                              txtHeight: 1.5 ,
                              fontFamily: "Sofia",
                              overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
 Row(
                          children: [
                         Icon(Icons.calendar_month,size: 18.0,color: accentColor,),
                            getHorSpace(5 ),
                            getCustomFont(
                                date.toString() ?? "", 15  ,
                              fontFamily: "Sofia", greyColor, 1,
                                fontWeight: FontWeight.w500, txtHeight: 1.5 ),
                          ],
                        ),
                        getVerSpace(2 ),
                        Row(
                          children: [
                            Icon(Icons.location_on,size: 18.0,color: accentColor,),
                          getHorSpace(5 ),
                            Container(
                          width: 150,
                              child: getCustomFont(
                                  events?.location ?? "", 15  , greyColor, 1,fontFamily: "Sofia",
                                  fontWeight: FontWeight.w500, txtHeight: 1.5 ),
                            ),
                          ],
                        ),
                        getVerSpace(7 ),
                        Row(
                          children: [
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("JoinEvent")
                                  .doc("user")
                                  .collection(events.title ?? '')
                                  .snapshots(),
                              builder: (BuildContext ctx,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                return snapshot.hasData
                                    ? new joinEvents(
                                        list: snapshot.data?.docs,
                                      )
                                    : Container();
                              },
                            ),
                            
            Container(
              height: 35 ,
              width: 80.0,
              decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.051),
                  borderRadius: BorderRadius.circular(50 )),
              child: Center(
                  child: Text(
                "\$ " + (events?.price.toString() ?? ""),
                style: TextStyle(
                    color: accentColor,
                    fontSize: 15  ,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              )),
            ),
                          ],
                        ),
                          ],
                        ),
                       
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
           Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => new FeaturedEvent2Detail(
                event: events,
                id: id,
              )));      
      }
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
                  String? _title = list?[i]['name'].toString();
                  String? _uid = list?[i]['uid'].toString();
                  String? _img = list?[i]['photoProfile'].toString();

                  return Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Container(
                      height: 24.0,
                      width: 24.0,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(70.0)),
                          image: DecorationImage(
                              image: NetworkImage(_img ?? ''),
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
                height: 32 ,
                width: 32 ,
                decoration: BoxDecoration(
                                color: accentColor,
                    borderRadius: BorderRadius.circular(30 ),
                    border: Border.all(color: Colors.white, width: 1.5 )),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getCustomFont(list?.length.toString() ?? '', 12  ,
                        Colors.white, 1,
                        fontWeight: FontWeight.w600),
                    getCustomFont(" +", 12  , Colors.white, 1,
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


