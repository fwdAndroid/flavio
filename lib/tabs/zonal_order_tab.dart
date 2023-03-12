import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavio/tab_pages/zonaltab/zonal_active_tab.dart';
import 'package:flavio/tab_pages/zonaltab/zonal_complete_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ZonalOrderTab extends StatefulWidget {
  const ZonalOrderTab({super.key});

  @override
  State<ZonalOrderTab> createState() => _ZonalOrderTabState();
}

class _ZonalOrderTabState extends State<ZonalOrderTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.purple,
            title: const Text('Order History'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "Active",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                Tab(
                  child: Text(
                    "Completed",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ZonalActiveTab(
                Uuid: "",
              ),
              ZonalCompleteTab()
            ],
          ),
        ),
      ),
    );
  }
}
