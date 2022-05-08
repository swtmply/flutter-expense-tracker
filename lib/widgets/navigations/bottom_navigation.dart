import 'package:flutter/material.dart';
import 'package:gas2s/screens/main/home.dart';
import 'package:gas2s/screens/main/settings.dart';
import 'package:gas2s/screens/main/stats.dart';
import 'package:gas2s/theme/colors.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const FAB(),
      bottomNavigationBar: BAB(
        pageController: _pageController,
        currentPage: _currentPage,
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
          SettingsMenuScreen(),
        ],
      ),
    );
  }
}

class BAB extends StatelessWidget {
  const BAB({
    Key? key,
    required PageController pageController,
    required int currentPage,
  })  : _pageController = pageController,
        _currentPage = currentPage,
        super(key: key);

  final PageController _pageController;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
          BottomNavItem(
            icon: Icons.menu,
            pageController: _pageController,
            page: 2,
            currentPage: _currentPage,
          ),
        ],
      ),
    );
  }
}

class FAB extends StatelessWidget {
  const FAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
