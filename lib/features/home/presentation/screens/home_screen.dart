import 'package:flutter/material.dart';
import 'package:mapbox_example/features/home/presentation/widgets/tabs/home_tab.dart';
import 'package:mapbox_example/features/home/presentation/widgets/tabs/marker_tab.dart';
import 'package:mapbox_example/features/home/presentation/widgets/tabs/search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int currentTab = 0;

  final tabs = <Widget>[
    HomeTab(),
    SearchTab(),
    MarkerTab(),
  ];

  void goToTab(int page) {
    setState(() {
      currentTab = page;
    });

    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: tabs
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          backgroundColor: Colors.grey.shade50,
          onTap: goToTab,
          currentIndex: currentTab,
          selectedItemColor: Colors.black,
          showSelectedLabels: true,
          // showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: currentTab == 0 ? Colors.black : Colors.grey.shade700,),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: currentTab == 1 ? Colors.black : Colors.grey.shade700,),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_location, color: currentTab == 2 ? Colors.black : Colors.grey.shade700,),
              label: "Marker",
            ),
          ],
        ),
      ),
    );
  }
}
