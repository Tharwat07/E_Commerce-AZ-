import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/theme_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String buttonText;
  final bool isBuy;
  CustomButton({this.onTap, @required this.buttonText, this.isBuy= false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorResources.getChatIcon(context),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
            ],
            gradient: (Provider.of<ThemeProvider>(context).darkTheme || onTap == null) ? null : isBuy?
            LinearGradient(colors: [
              Color(0xffFE961C),
              Color(0xffFE961C),
              Color(0xffFE961C),
            ]):
            LinearGradient(colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor,
            ]),
            borderRadius: BorderRadius.circular(10)),
        child: Text(buttonText,
            style: titilliumSemiBold.copyWith(
              fontSize: 16,
              color: Theme.of(context).highlightColor,
            )),
      ),
    );
  }
}
