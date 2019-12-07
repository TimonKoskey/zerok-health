import 'package:flutter/material.dart';

import './pages/charts.dart';
import './pages/stats.dart';
import './pages/groups/main-groups.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return AppContainer();
  }
}

class AppContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            // backgroundColor: Color(0xff1976d2),
            title: Text('ZerokHealthSystems'),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(text: 'DIARY',),
                Tab(text: 'GROUPS',),
                Tab(text: 'DIAGRAM',),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              DiaryContainerWidget(),
              GroupsContainer(),
              GraphContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
