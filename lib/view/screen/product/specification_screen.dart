import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../../localization/language_constrants.dart';
import '../../basewidget/custom_app_bar.dart';

class SpecificationScreen extends StatelessWidget {
  final String specification;
  SpecificationScreen({@required this.specification});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();


    return Scaffold(
      body: Column(children: [

        CustomAppBar(title: getTranslated('specification', context)),

        Expanded(child: SingleChildScrollView(child: Html(data: specification))),

      ]),
    );
  }
}
