import 'package:flutter/material.dart';
import 'package:fruit_app/modules/Login/login_screen.dart';
import 'package:fruit_app/shared/constants.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'حساب جديد',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: Container(
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'الاسم كامل',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
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
              const SizedBox(
                height: 33,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'البريد الالكتروني',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
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
              const SizedBox(
                height: 33,
              ),
              TextFormField(
                controller: passController,
                decoration: InputDecoration(
                    hintText: 'كلمة المرور',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0XFFE6E9E9), width: 1)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 185, 236, 236),
                            width: 1.0)),
                    suffixIcon: const Icon(
                      Icons.remove_red_eye_sharp,
                      color: Colors.grey,
                    ),
                    fillColor: Color(0xFFF9FAFA),
                    filled: true),
              ),
              SizedBox(
                height: 16,
              ),
              Transform.translate(
                offset: Offset(14, 12),
                child: Row(
                  children: [
                    Transform.scale(
                        scale: 1.3,
                        child: Checkbox(value: true, onChanged: (value) {})),
                    Text(
                      'من خلال إنشاء حساب ، فإنك توافق على',
                    ),
                    Text(
                      ' الشروط',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                    //الشروط والأحكام الخاصة بنا
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    ' والأحكام الخاصة بنا',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 33,
              ),
              Container(
                height: 54,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'إنشاء حساب جديد',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'تمتلك حساب بالفعل؟',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    child: Text(
                      'تسجيل دخول',
                      style: TextStyle(
                          color: primaryColor,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
