import 'package:blog_app/common/helpers/is_dark_mode.dart';
import 'package:blog_app/common/widgets/appbar/app_bar.dart';
import 'package:blog_app/core/configs/assets/app_images.dart';
import 'package:blog_app/core/configs/assets/app_vectors.dart';
import 'package:blog_app/core/configs/theme/app_colors.dart';
import 'package:blog_app/presentation/home/widgets/new_songs.dart';
import 'package:blog_app/presentation/home/widgets/playlist.dart';
import 'package:blog_app/presentation/profile/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        trailingButton: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const ProfilePage()));
            },
            icon: const Icon(Icons.person)),
        hideBackButton: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabs(),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children: [
                  const NewSongs(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Playlist(),
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 150,
        width: 320,
        child: Stack(children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.homeTopCard)),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Image.asset(
                  AppImages.homeArtist,
                ),
              )),
        ]),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
        isScrollable: false,
        controller: _tabController,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        indicatorColor: AppColors.primary,
        padding: const EdgeInsets.all(18),
        tabs: const [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "News",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Videos",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Artists",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Podcast",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
        ]);
  }
}
