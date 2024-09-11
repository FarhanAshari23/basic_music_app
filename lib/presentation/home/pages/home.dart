import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/home/widgets/artists_list.dart';
import 'package:spotify/presentation/home/widgets/news_songs.dart';
import 'package:spotify/presentation/home/widgets/play_list.dart';
import 'package:spotify/presentation/profile/pages/profile.dart';

import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../core/configs/assets/app_vectors.dart';

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
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        action: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfilePage(),
            ),
          ),
          icon: const Icon(Icons.person),
        ),
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
                children: const [
                  NewsSongs(),
                  ArtistsPage(),
                  Center(
                    child: Text("Coming Soon"),
                  ),
                  Center(
                    child: Text("Coming Soon"),
                  ),
                ],
              ),
            ),
            const PlayList()
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 150,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 334,
                height: 116,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xff42C83C)),
                child: const Padding(
                  padding: EdgeInsets.only(top: 15, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Songs',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Bawa Dia Kembali',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Mahalini',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Image.asset(
                  AppImages.homeArtist,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      controller: _tabController,
      indicatorColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 40),
      tabs: const [
        Text(
          "News",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        Text(
          "Artists",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        Text(
          "Videos",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        Text(
          "Podcasts",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
