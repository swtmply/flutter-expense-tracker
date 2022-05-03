import 'package:flutter/material.dart';
import 'package:gas2s/screens/home_screen.dart';
import 'package:gas2s/screens/stats_screen.dart';
import 'package:gas2s/theme/colors.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        elevation: 2,
        backgroundColor: AppColors.violet,
        child: Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.violet,
                AppColors.pink,
              ],
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavItem(
              icon: Icons.home,
              pageController: _pageController,
              page: 0,
              currentPage: _currentPage,
            ),
            BottomNavItem(
              icon: Icons.bar_chart,
              pageController: _pageController,
              page: 1,
              currentPage: _currentPage,
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: const [
          HomePage(),
          StatsScreen(),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    Key? key,
    required this.icon,
    required this.pageController,
    required this.page,
    required this.currentPage,
  }) : super(key: key);

  final IconData icon;
  final PageController pageController;
  final int page;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              pageController.jumpToPage(page);
            },
            child: Icon(
              icon,
              color:
                  currentPage == page ? AppColors.violet : AppColors.coolGray,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
