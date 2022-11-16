import 'package:amyz_user_app/view/screen/auth/widget/sign_in_widget.dart';
import 'package:amyz_user_app/view/screen/auth/widget/sign_up_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';

class AuthScreen extends StatelessWidget {
  final int initialPage;

  AuthScreen({this.initialPage = 0});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false)
        .initAddressTypeList(context);
    Provider.of<AuthProvider>(context, listen: false).isRemember;
    PageController _pageController = PageController(initialPage: initialPage);

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // background
          Provider.of<ThemeProvider>(context).darkTheme
              ? SizedBox()
              : Image.asset(Images.background,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width),

          Consumer<AuthProvider>(
            builder: (context, auth, child) => SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),

                  // for logo with text
                  Image.asset(Images.logo_with_name_image,
                      height: 150, width: 200),

                  // for decision making section like sign in or register section
                  Padding(
                    padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_LARGE),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          bottom: 0,
                          right: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                          left: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            //margin: EdgeInsets.only(right: Dimensions.FONT_SIZE_LARGE),
                            height: 1,
                            color: ColorResources.getGainsBoro(context),
                          ),
                        ),
                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) => Row(
                            children: [
                              InkWell(
                                onTap: () => _pageController.jumpToPage(0,
                                ),
                                child: Column(
                                  children: [
                                    Text(getTranslated('SIGN_IN', context),
                                        style: authProvider.selectedIndex == 0
                                            ? titilliumSemiBold
                                            : titilliumRegular),
                                    Container(
                                      height: 2,
                                      width: 150,
                                      margin: EdgeInsets.only(top: 10),
                                        color: authProvider.selectedIndex == 0
                                            ? Theme.of(context).primaryColor
                                            : Colors.transparent),
                                  ],
                                ),
                              ),

                              InkWell(
                                onTap: () => _pageController.jumpToPage(1,
                                ),
                                child: Column(
                                  children: [
                                    Text(getTranslated('SIGN_UP', context),
                                        style: authProvider.selectedIndex == 1
                                            ? titilliumSemiBold
                                            : titilliumRegular),
                                    Container(
                                        height: 2,
                                        width: 165,
                                        margin: EdgeInsets.only(top: 10),
                                        color: authProvider.selectedIndex == 1
                                            ? Theme.of(context).primaryColor
                                            : Colors.transparent),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // show login or register widget
                  Expanded(
                    child: Consumer<AuthProvider>(
                      builder: (context, authProvider, child) =>
                          PageView.builder(
                        itemCount: 2,
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          if (authProvider.selectedIndex == 0) {
                            return SignInWidget();
                          } else {
                            return SignUpWidget();
                          }
                        },
                        onPageChanged: (index) {
                          authProvider.updateSelectedIndex(index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
