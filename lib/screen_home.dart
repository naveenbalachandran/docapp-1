import 'package:docapp/colors.dart';
import 'package:docapp/screen_details.dart';
import 'package:flutter/material.dart';

import 'model/doctor_model.dart';
import 'model/doctors.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<DoctorModel> doctorDataList = [];
  void initState() {
    doctorDataList = doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.short_text,
          size: 30,
          color: Colors.black,
        ),
        actions: <Widget>[
          Icon(
            Icons.notifications_none,
            size: 30,
            color: AppColor.grey.withAlpha(150),
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://static.wikia.nocookie.net/disney/images/1/11/Hailee_Steinfeld.jpg/revision/latest?cb=20180410032651"),
          )
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _header(),
            ],
          ),
        ),
        _searchField(),
        Container(
          height: 160,
          width: 350,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Banner3.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Text("Top Doctors",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: doctorDataList.length,
              itemBuilder: (context, index) {
                return _docCard(index);
              }),
        ),
      ]),
    );
  }

  Widget _docCard(int index) {
    return Card(
      child: ListTile(
          title: Text(
            doctorDataList[index].name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text(
            doctorDataList[index].type,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          leading: CircleAvatar(
            backgroundImage: AssetImage(doctorDataList[index].image),
            backgroundColor: Colors.white,
          ),
          onTap: () {
            DoctorModel current = doctorDataList[index];
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ScreenDetails(model: current)));
          }),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Hello,",
          style: TextStyle(color: AppColor.subTitleTextColor, fontSize: 24),
        ),
        Text(
          "Hailee Stienfield",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _searchField() {
    return Container(
        height: 55,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(13)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColor.grey.withOpacity(.3),
              blurRadius: 15,
              offset: Offset(5, 5),
            )
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle:
                TextStyle(color: AppColor.subTitleTextColor, fontSize: 12),
            suffixIcon: SizedBox(
                width: 50, child: Icon(Icons.search, color: AppColor.purple)),
          ),
        ));
  }
}
