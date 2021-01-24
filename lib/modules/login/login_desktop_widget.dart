import 'package:flutter/material.dart';
import 'package:web_test/utilities/globals.dart';

class LoginDesktop extends StatefulWidget {
  final Widget childRight;

  const LoginDesktop({Key key, this.childRight}) : super(key: key);
  @override
  _LoginDesktopState createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
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
  Widget _buildItemImage(){
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: Globals.maxPadding,left: Globals.maxPadding),
        child: Image.asset("assets/img-login.jpg"),
      ),
    );
  }
  Widget _buildItemRight(){
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: widget.childRight??Container(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _buildItemImage(),
          _buildItemRight()
        ],
      ),
    );
  }
}
