import 'package:flavio/login_screens/sub_zonal_login.dart';
import 'package:flavio/login_screens/zonal_manager_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            'assets/splash.png',
            height: 250,
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => ZonalManagerLogin(
                              bussines: "Zone Manager",
                            )));
              },
              leading: Icon(Icons.business),
              title: Text("Zonals Manager "),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => SubZoneLogin(
                              r: "Sub Zone Manager",
                            )));
              },
              leading: Icon(Icons.recycling_outlined),
              title: Text("Sub Zonal Sales Manager "),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}
