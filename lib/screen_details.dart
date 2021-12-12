import 'package:docapp/colors.dart';
import 'package:docapp/model/doctor_model.dart';
import 'package:docapp/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/progress.dart';
import 'widgets/ratingstar.dart';

class ScreenDetails extends StatefulWidget {
  const ScreenDetails({Key? key, required this.model}) : super(key: key);
  final DoctorModel model;
  @override
  State<ScreenDetails> createState() => _ScreenDetailsState();
}

class _ScreenDetailsState extends State<ScreenDetails> {
  DoctorModel model = DoctorModel();
  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: AppColor.grey,
          onPressed: () => {
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) => ScreenHome()))
            Navigator.of(context).pop()
          },
        ),
        actions: [
          IconButton(
              icon: Icon(
                model.isfavourite ? Icons.favorite : Icons.favorite_border,
                color: model.isfavourite ? Colors.red : AppColor.grey,
              ),
              onPressed: () {
                setState(() {
                  model.isfavourite = !model.isfavourite;
                });
              })
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Image.asset(model.image),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: MediaQuery.of(context).size.height * .5,
                  padding: EdgeInsets.only(
                      left: 19,
                      right: 19,
                      top: 16), //symmetric(horizontal: 19, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                model.name,
                                // style: titleStyle,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.check_circle,
                                  size: 18,
                                  color: Theme.of(context).primaryColor),
                              Spacer(),
                              RatingStar(
                                rating: model.rating,
                              )
                            ],
                          ),
                          subtitle: Text(
                            model.type,
                            // style: TextStyles.bodySm.subTitleColor.bold,
                          ),
                        ),
                        Divider(
                          thickness: .3,
                          color: Colors.white,
                        ),
                        Row(
                          children: <Widget>[
                            ProgressWidget(
                                value: model.goodReviews,
                                totalValue: 100,
                                activeColor: AppColor.purpleExtraLight,
                                backgroundColor: AppColor.grey.withOpacity(0.3),
                                title: "Good Review",
                                durationTime: 500),
                            ProgressWidget(
                                value: model.totalScore,
                                totalValue: 100,
                                activeColor: AppColor.purpleExtraLight,
                                backgroundColor: AppColor.grey.withOpacity(0.3),
                                title: "Total Score",
                                durationTime: 300),
                            ProgressWidget(
                                value: model.satisfaction,
                                totalValue: 100,
                                activeColor: AppColor.purpleExtraLight,
                                backgroundColor: AppColor.grey.withOpacity(0.3),
                                title: "Satisfaction",
                                durationTime: 800),
                          ],
                        ),
                        Divider(
                          thickness: .3,
                          color: Colors.white,
                        ),
                        Text(
                          "About",
                          // style: titleStyle
                        ),
                        Text(
                          model.description,
                          // style: TextStyles.body.subTitleColor,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.phone,
                                  color: AppColor.purpleLight),
                              onPressed: () => launch("tel://94476"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              icon: Icon(Icons.chat_bubble,
                                  color: AppColor.lightOrange),
                              onPressed: () => launch("sms:+92070"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Appointment Booked Successfully!")));
                              },
                              child: Text(
                                "Make an appointment",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: AppColor.green),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            // _appbar(),
          ],
        ),
      ),
    );
  }
}
