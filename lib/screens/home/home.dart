import 'dart:math';

import 'package:duitgone2/models/money.dart';
import 'package:duitgone2/screens/about/about.dart';
import 'package:duitgone2/screens/add_record/add_record.dart';
import 'package:duitgone2/screens/home/money_list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const title = "duitGone2";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Money> moneys;

  @override
  void initState() {
    super.initState();
    moneys = Money.generateMockData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: _createAppBar(context),
      drawer: _createDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddRecord(
                    onRecordAdded: _addMoney,
                  )));
        },
        child: Icon(
          Icons.add,
          size: 32,
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: PieChart(
              duration: Duration(milliseconds: 250),
              PieChartData(
                sections: _createSections(moneys),
                centerSpaceRadius: 0,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              moneys
                  .map((mon) => mon.amount)
                  .reduce((acc, val) => acc + val)
                  .toStringAsFixed(2),
              style: TextStyle(fontSize: 26),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MoneyList(moneys: moneys),
          ),
        ],
      ),
    );
  }

  Drawer _createDrawer() => Drawer(
        child: Builder(builder: (context) {
          return ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Home.title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                },
                leading: Icon(Icons.home_outlined),
                title: Text("Dashboard"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => About()));
                },
                leading: Icon(Icons.info_outlined),
                title: Text("About"),
              ),
            ],
          );
        }),
      );

  AppBar _createAppBar(BuildContext context) => AppBar(
        title: Text(
          Home.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          );
        }),
      );

  List<PieChartSectionData> _createSections(List<Money> moneys) {
    const colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
      Colors.black,
      Colors.white,
    ];
    return moneys.map((money) {
      return PieChartSectionData(
        value: money.amount.abs(),
        title: money.category.label,
        titlePositionPercentageOffset: 1,
        color: colors[Random().nextInt(colors.length)],
        radius: 100,
      );
    }).toList();
  }

  void _addMoney(Money money) {
    setState(() {
      print(money.category.label);
      moneys.insert(0, money);
    });
  }
}
