import 'package:flutter/material.dart';
import 'package:fruit_app/shared/constants.dart';

class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'التحقق من الرمز',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'أدخل الرمز الذي أرسلناه إلى عنوان بريد التاليMaxxx@email.com',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(
              height: 29,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 74,
                  height: 60,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.orange.shade500, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0XFFE6E9E9), width: 1)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE6E9E9),
                          width: .2,
                        ),
                      ),
                      fillColor: Color(0xFFF9FAFA),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 74,
                  height: 60,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.orange.shade500, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0XFFE6E9E9), width: 1)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE6E9E9),
                          width: .2,
                        ),
                      ),
                      fillColor: Color(0xFFF9FAFA),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 74,
                  height: 60,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.orange.shade500, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0XFFE6E9E9), width: 1)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE6E9E9),
                          width: .2,
                        ),
                      ),
                      fillColor: Color(0xFFF9FAFA),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 74,
                  height: 60,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.orange.shade500, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0XFFE6E9E9), width: 1)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE6E9E9),
                          width: .2,
                        ),
                      ),
                      fillColor: Color(0xFFF9FAFA),
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 29,
            ),
            Container(
              height: 54,
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'تحقق من الرمز',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(16)),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'إعادة إرسال الرمز',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
