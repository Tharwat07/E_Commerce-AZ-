import 'dart:convert';
import 'package:amyz_user_app/utill/app_constants.dart';
import 'package:amyz_user_app/view/screen/address/widget/adress_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/model/response/address_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/location_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../basewidget/no_internet_screen.dart';
import '../../basewidget/not_loggedin_widget.dart';
import 'add_new_address_screen.dart';

class AddressScreen extends StatefulWidget {
  final AddressModel addressModel;

  AddressScreen({this.addressModel});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool _isLoggedIn;

  @override
  void initState() async {
    super.initState();
    _isLoggedIn =
        Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (_isLoggedIn) {
      Provider.of<LocationProvider>(context, listen: false)
          .initAddressList(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoggedIn
          ? Consumer<ProfileProvider>(
              builder: (context, locationProvider, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Center(
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated('saved_address', context),
                              style: robotoRegular.copyWith(
                                  color: ColorResources.getTextTitle(context)),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AddNewAddressScreen()));
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.add,
                                      color:
                                          ColorResources.getTextTitle(context)),
                                  Text(
                                    getTranslated('add_new', context),
                                    style: robotoRegular.copyWith(
                                        color: ColorResources.getTextTitle(
                                            context)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    locationProvider.addressList != null
                        ? locationProvider.addressList.length > 0
                            ? Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    await Provider.of<ProfileProvider>(context,
                                            listen: false)
                                        .initAddressList(context);
                                  },
                                  child: Scrollbar(
                                    child: Center(
                                      child: SizedBox(
                                        child: ListView.builder(
                                          padding: EdgeInsets.all(
                                              Dimensions.PADDING_SIZE_SMALL),
                                          itemCount: locationProvider
                                              .addressList.length,
                                          itemBuilder: (context, index) =>
                                              AddressWidget(
                                            addressModel: locationProvider
                                                .addressList[index],
                                            index: index,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : NoInternetOrDataScreen(isNoInternet: false)
                        : Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor))),
                  ],
                );
              },
            )
          : NotLoggedInWidget(),
    );
  }
}
