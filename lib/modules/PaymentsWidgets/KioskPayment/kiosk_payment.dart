import 'package:flutter/material.dart';
import 'package:fruit_app/shared/constants.dart';

class KioskPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Refrence Code",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Text(
              "Refrence Number",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "please use the refrence number below to complete",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.grey),
            ),
            Text(
              "your payment at any Aman/Masry outlet",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.grey),
            ),
            //your payment at any Aman/Masry outlet
            SizedBox(
              height: 20,
            ),
            Text(
              "${ApiContest.refCode}",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
