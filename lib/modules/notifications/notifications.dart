import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image(
                        image: AssetImage("assets/images/backArrow.png"))),
                Spacer(),
                Text(
                  "الاشعارات",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.green[50],
                  backgroundImage: AssetImage("assets/images/notification.png"),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 20),
              child: Row(
                children: [
                  Text(
                    "جديد",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.green[50],
                    radius: 15,
                    child: Text(
                      "2",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "تحديد الكل مقروء",
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 370,
              width: 500,
              child: ListView.separated(
                  itemBuilder: (context, index) =>
                      buildUnReadNotificationItem(),
                  separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 8,
                      ),
                  itemCount: 6),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 20),
              child: Row(
                children: [
                  Text(
                    "في وقت سابق",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.green[50],
                    radius: 15,
                    child: Text(
                      "2",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "تحديد الكل مقروء",
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 370,
                width: 500,
                child: ListView.separated(
                    itemBuilder: (context, index) =>
                        buildUnReadNotificationItem(),
                    separatorBuilder: (context, index) => Container(
                          width: double.infinity,
                          height: 8,
                        ),
                    itemCount: 6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUnReadNotificationItem() {
    return Container(
      width: double.infinity,
      height: 80,
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/images/sale1.png"),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "خصم ",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: "50%",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: " علي اسعار الفواكه بمناسبه العيد",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "9 صباحا",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReadNotificationItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage("assets/images/sale1.png"),
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "خصم ",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                TextSpan(
                  text: "50%",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: " علي اسعار الفواكه بمناسبه العيد",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          "9 صباحا",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
