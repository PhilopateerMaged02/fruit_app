import 'package:flutter/material.dart';
import 'package:fruit_app/modules/notifications/notifications.dart';
import 'package:fruit_app/shared/components.dart';

class Search extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 30),
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
                  "البحث",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    navigateTo(context, Notifications());
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.green[50],
                    backgroundImage:
                        AssetImage("assets/images/notification.png"),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                onTap: () {},
                controller: searchController,
                decoration: InputDecoration(
                    hintText: 'ابحث عن.......',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white60, width: 1.0)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white60, width: 1.0)),
                    suffixIcon: IconButton(
                      icon: Image(
                          image: AssetImage("assets/images/setting-4.jpg")),
                      onPressed: () {},
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.green[700]),
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            Spacer(),
            Container(
                width: 300,
                height: 300,
                child:
                    Image(image: AssetImage("assets/images/searcherror.jpg"))),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
