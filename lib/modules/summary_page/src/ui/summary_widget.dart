import 'package:flutter/material.dart';
import 'package:web_test/models/questions_data_model.dart';
import 'package:web_test/utilities/custom_icon_check.dart';
import 'package:web_test/utilities/globals.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
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

  Widget _buildTitleIcon(Answers answer, Function onTap) {
    return Container(
      width: (Globals.maxWidth * 0.3) / 4,
      padding: EdgeInsets.symmetric(vertical: Globals.minPadding),
      child: InkWell(
        onTap: onTap,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: CustomIconCheck(
          isSelected: answer.isSelected,
          width: ((Globals.maxWidth * 0.3) / 4 - Globals.maxPadding),
          height: ((Globals.maxWidth * 0.3) / 4 - Globals.maxPadding),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
