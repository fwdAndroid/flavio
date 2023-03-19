import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SubZonalOrderTab extends StatefulWidget {
  const SubZonalOrderTab({super.key});

  @override
  State<SubZonalOrderTab> createState() => _SubZonalOrderTabState();
}

class _SubZonalOrderTabState extends State<SubZonalOrderTab> {
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
            children: <Widget>[
              // ActiveRetailerOrders(),
              // CompletedRetailersOrders()
            ],
          ),
        ),
      ),
    );
  }
}
