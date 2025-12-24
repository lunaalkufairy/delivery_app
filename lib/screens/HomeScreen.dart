import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:delivery_app/model/profile.dart';
import 'package:delivery_app/screens/SideBarScreen.dart';

import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/screens/CartScreeen.dart';
import 'package:delivery_app/screens/DashbordScreen.dart';
import 'package:delivery_app/screens/OrderScreen.dart';
import 'package:delivery_app/screens/SearchScreen.dart';
import 'package:delivery_app/screens/favoraiteScreen.dart';

class HomeScreen extends StatefulWidget {
  final Profile profile;
  final String access_token;
  const HomeScreen({
    super.key,
    required this.profile,
    required this.access_token,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState(access_token: access_token, profile: profile);
}

class _HomeScreenState extends State<HomeScreen> {
  final Profile profile;
  late List<Widget> pages;
  final String access_token;
  _HomeScreenState({required this.access_token, required this.profile});

  int tap = 2;

  @override
  void initState() {
    super.initState();
    // تمرير UserProfile إلى الشاشات
    pages = <Widget>[
      SearchScreen(access_token: access_token),
      OrdersScreen(token: access_token),
      DashbordScreen(profile: profile, access_token: access_token),
      FavoraiteScreen(access_token: access_token),
      CartScreen(token: access_token),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print('HOME $access_token');
    return Scaffold(
      drawer: Sidebar(
        profile: profile,
        access_token: access_token, // تمرير كائن UserProfile مباشرةً
      ),
      body: pages.elementAt(tap),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: offWhite,
          boxShadow: [
            BoxShadow(
              color: yellow.withOpacity(0.2),
              offset: Offset(0, -2),
              blurRadius: 7,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          child: GNav(
            onTabChange: (value) {
              setState(() {
                tap = value; // تحديث التاب الحالي
              });
            },
            padding: EdgeInsets.all(11),
            activeColor: offWhite,
            tabBackgroundColor: yellow.withOpacity(0.80),
            backgroundColor: offWhite,
            selectedIndex: tap,
            gap: 4,
            tabs: [
              GButton(icon: search, text: 'Search'),
              GButton(icon: order, text: 'Orders'),
              GButton(icon: home, text: 'Home'),
              GButton(icon: favorate, text: 'Favorite'),
              GButton(icon: cart, text: 'Cart'),
            ],
          ),
        ),
      ),
    );
  }
}
