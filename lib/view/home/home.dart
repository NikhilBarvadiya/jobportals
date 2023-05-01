import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:jobportals/core/theme/light.dart';
import 'package:jobportals/view/home/home_ctrl.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeCtrl>(
      init: HomeCtrl(),
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: IndexedStack(index: _.selectedIndex, children: _.pages),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _.selectedIndex,
            onTap: (i) => _.onItemTapped(i),
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home, color: _.selectedIndex == 0 ? lightColorScheme.primary : Colors.black),
                backgroundColor: _.selectedIndex == 0 ? Colors.black : Colors.grey,
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Icons.person, color: _.selectedIndex == 1 ? lightColorScheme.primary : Colors.black),
                backgroundColor: _.selectedIndex == 1 ? Colors.black : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
