import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_test/modules/home_page/src/ui/home_page_widget.dart';
import 'package:web_test/modules/login/login_desktop_widget.dart';
import 'package:web_test/utilities/globals.dart';
import 'package:web_test/utilities/responsive.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _emailNode = FocusNode();
  FocusNode _passwordNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget _inputItem(String title, TextEditingController controller,
      FocusNode node, FocusNode nextNode, bool isRequire, bool isHide,
      {bool isPhone = false, String hint = ""}) {
    return Container(
      padding: EdgeInsets.only(
        right: Globals.maxPadding,
        left: Globals.maxPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Container(
                  margin: EdgeInsets.only(
                    top: Globals.minPadding,
                  ),
                  child: RichText(
                    text: TextSpan(
                        text: title ?? "",
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                        children: [
                          TextSpan(
                            text: isRequire ? "*" : "",
                            style: TextStyle(color: Colors.red, fontSize: 15.0),
                          ),
                        ]),
                  ),
                )
              : Container(),
          Container(
            margin: EdgeInsets.only(
              top: Globals.minPadding,
            ),
            // padding: EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border:
                  Border.all(color: node.hasFocus ? Colors.blue : Colors.grey),
            ),
            child: TextField(
              style: TextStyle(color: Colors.black, fontSize: 14),
              controller: controller,
              focusNode: node,
              keyboardType: isPhone ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon: isPhone
                    ? null
                    : Container(
                        margin: EdgeInsets.only(
                          right: Globals.minPadding,
                          left: Globals.minPadding,
                        ),
                        child: isHide
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
              ),
              onSubmitted: (value) {},
              onChanged: (value) {},
            ),
          )
        ],
      ),
    );
  }

  Widget _renderBody() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
            left: Globals.maxPadding,
            right: Globals.maxPadding,
            top: Globals.maxPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ResponsiveWidget.isSmallScreen(context)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: Globals.maxHeight * 0.4,
                        margin: EdgeInsets.only(bottom: Globals.maxPadding),
                        child: Image.asset("assets/img-login.jpg"),
                      ),
                    ],
                  )
                : Container(),
            Container(
                margin: EdgeInsets.only(
                    top: Globals.maxPadding, bottom: Globals.minPadding),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: Globals.maxPadding,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                )),
            _inputItem(
                null, _emailController, _emailNode, _passwordNode, true, false,
                isPhone: true, hint: "Username"),
            _inputItem(
                null, _passwordController, _passwordNode, null, true, true,
                hint: "Password"),
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .popUntil((route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                  top: Globals.minPadding,
                  bottom: Globals.minPadding,
                  right: Globals.maxPadding,
                  left: Globals.maxPadding,
                ),
                width: Globals.maxWidth,
                height: 44.0,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Globals().init(context: context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ResponsiveWidget(
        largeScreen: LoginDesktop(
          childRight: _renderBody(),
        ),
        mediumScreen: LoginDesktop(
          childRight: _renderBody(),
        ),
        smallScreen: _renderBody(),
      ),
    );
  }
}
