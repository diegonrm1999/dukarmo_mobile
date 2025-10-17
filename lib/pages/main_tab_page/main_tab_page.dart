import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/pages/main_tab_page/main_tab_controller.dart';
import 'package:dukarmo_app/widgets/background_scaffold.dart';
import 'package:provider/provider.dart';

class MainTabPage extends StatelessWidget {
  const MainTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MainTabController>(context);
    final currentPage = controller.config.pages[controller.currentIndex];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(currentPage.title, style: TextStyleWrapper.lgBold),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: BackgroundScaffold(
        backgroundPath: "assets/images/home_wallpaper.webp",
        transparency: 0.1,
        child: currentPage.page,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          controller.onBottomNavigationBarTap(index);
        },
        backgroundColor: AppColors.homeBackground,
        selectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: controller.currentIndex,
        items: controller.config.pages
            .map(
              (p) => BottomNavigationBarItem(
                icon: Icon(p.icon),
                label: '',
                backgroundColor: Colors.black,
              ),
            )
            .toList(),
      ),
    );
  }
}
