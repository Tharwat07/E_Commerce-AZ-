import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../provider/splash_provider.dart';
import '../../provider/theme_provider.dart';
import '../../utill/color_resources.dart';
import '../../utill/custom_themes.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';
import 'not_loggedin_widget.dart';

class CustomExpandedAppBar extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget bottomChild;
  final bool isGuestCheck;

  CustomExpandedAppBar(
      {@required this.title,
      @required this.child,
      this.bottomChild,
      this.isGuestCheck = false});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    return Scaffold(
      floatingActionButton: isGuestCheck
          ? isGuestMode
              ? null
              : bottomChild
          : bottomChild,
      body: Stack(children: [
        // Background
        Image.asset(
          Images.more_page_header,
          height: 150,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          color: Provider.of<ThemeProvider>(context).darkTheme
              ? Colors.black
              : null,
        ),

        Positioned(
          top: 40,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          child: Row(children: [
            InkWell(
              onTap: () {
                Provider.of<SplashProvider>(context, listen: false)
                    .setFromSetting(false);
                Navigator.pop(context);
              },
              child: Image.asset(
                Images.arrow_back,
                height: 35,
                color: Colors.white,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 20,),
            Text(title,
                style: titilliumRegular.copyWith(
                    fontSize: 20,
                    color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ]),
        ),

        Container(
          margin: EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            color: ColorResources.getHomeBg(context),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: isGuestCheck
              ? isGuestMode
                  ? NotLoggedInWidget()
                  : child
              : child,
        ),
      ]),
    );
  }
}
