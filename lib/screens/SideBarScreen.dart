import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/model/profile.dart';
import 'package:delivery_app/screens/profileScreen.dart';
import 'package:delivery_app/screens/settingsScreen.dart';
import 'package:delivery_app/service/getAllStores.dart';

class Sidebar extends StatefulWidget {
  final Profile profile;
  final String access_token;

  const Sidebar({required this.profile, required this.access_token});

  @override
  State<Sidebar> createState() =>
      _SidebarState(access_token: access_token, profile: profile);
}

class _SidebarState extends State<Sidebar> {
  final String access_token;
  final Profile profile;
  _SidebarState({required this.access_token, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: offWhite,
      child: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Divider(color: offWhite, height: 90),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                child: profile.profileImage == null
                    ? Icon(Icons.person, size: 50, color: grey)
                    : null,
              ),
              Divider(height: 20, color: offWhite),
              Text(
                profile.firstName,
                style: TextStyle(fontFamily: 'sofia-pro', fontSize: 20),
              ),
              Text(
                profile.phoneNumber,
                style: TextStyle(fontFamily: 'sofia-pro'),
              ),
              Divider(height: 60, color: offWhite),
            ],
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'My Profile',
              style: TextStyle(fontFamily: 'sofia-pro'),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    profile: profile,
                    access_token: access_token,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet_rounded),
            title: Text(
              'Payment Methods',
              style: TextStyle(fontFamily: 'sofia-pro'),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings', style: TextStyle(fontFamily: 'sofia-pro')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Settingsscreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.help_center_rounded),
            title: Text(
              'Helps & FAQs',
              style: TextStyle(fontFamily: 'sofia-pro'),
            ),
            onTap: () {},
          ),
          Divider(height: 190, color: offWhite),
          Padding(
            padding: const EdgeInsets.only(right: 80, left: 15),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              title: Text(
                'Log Out',
                style: TextStyle(fontFamily: 'sofia-pro', color: Colors.white),
              ),
              tileColor: yellow,
              leading: Icon(
                Icons.power_settings_new_rounded,
                color: Colors.white,
              ),
              onTap: () {
                fetchStores(access_token);

                // fetchFavoriteProducts(access_token);
                // List<Map<String, dynamic>> products = await fetchProducts(
                //     '48|8KXCYTqOQW0hj3vyfrbHx1pSkvfTfaDo5IPrs643f3f72b84');
                // print(products[1]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
