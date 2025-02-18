import 'dart:developer';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/const/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? tabController;
  final AppinioSwiperController gymCardController = AppinioSwiperController();
  final AppinioSwiperController homeCardController = AppinioSwiperController();

  @override
  void initState() {
    getTheUserData();
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  List<CachedNetworkImage> userImageItem = [];

  void getTheUserData() {
    for (var element in candidates) {
      userImageItem.add(
        CachedNetworkImage(
          imageUrl: element.image ?? '',
          fit: BoxFit.cover,
          errorWidget: (context, error, stackTrace) => const Center(
            child: Icon(
              Icons.error,
              color: AppColors.white,
              size: 100,
            ),
          ),
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColors.white),
            ),
          ),
        ),
      );
    }
    if (mounted) {
      setState(() {});
    }
  }

  Active? side;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(5).copyWith(bottom: AppBar().preferredSize.height + 25, top: 20),
              child: AppinioSwiper(
                invertAngleOnBottomDrag: false,
                backgroundCardCount: 3,
                backgroundCardScale: 0.8,
                loop: true,
                threshold: 200,
                backgroundCardOffset: Offset.zero,
                swipeOptions: const SwipeOptions.symmetric(horizontal: true),
                controller: gymCardController,
                onCardPositionChanged: (SwiperPosition position) {
                  log("SwiperPosition:- ${position.angle}");

                  if (position.angle > 1.0) {
                    setState(() {
                      side = Active.Like;
                    });
                  }
                },
                onSwipeEnd: _swipeEnd,
                onEnd: _onEnd,
                onSwipeBegin: _swipeEnd,
                cardCount: userImageItem.length,
                cardBuilder: (BuildContext context, int index) {
                  return Stack(
                    clipBehavior: Clip.antiAlias,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: userImageItem[index],
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5).copyWith(bottom: AppBar().preferredSize.height + 25, top: 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColors.blue),
            )
          ],
        ),
      ),
      floatingActionButton: TabWidget(tabController: tabController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _swipeEnd(int previousIndex, int targetIndex, SwiperActivity activity) {
    log("OnSwipe");
    switch (activity) {
      case Swipe():
        log('The card was swiped to the : ${activity.direction}');
        log('previous index: $previousIndex, target index: $targetIndex');

        break;
      case Unswipe():
        log('A ${activity.direction.name} swipe was undone.');
        log('previous index: $previousIndex, target index: $targetIndex');
        break;
      case CancelSwipe():
        side = null;
        setState(() {});
        log('A swipe was cancelled');
        break;
      case DrivenActivity():
        log('Driven Activity');
        break;
    }
  }

  void _onEnd() {
    log('end reached!');
  }

  @override
  bool get wantKeepAlive => true;
}

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.tabController,
  });

  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TabBar(
        controller: tabController,
        onTap: (int index) {},
        tabs: const [
          Text("GYM"),
          Text("HOME"),
        ],
        indicator: const ShapeDecoration(
          color: AppColors.black,
          shape: StadiumBorder(),
        ),
        dividerColor: AppColors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: const EdgeInsets.symmetric(vertical: 15),
        splashBorderRadius: BorderRadius.circular(50),
        labelColor: AppColors.white,
        indicatorColor: AppColors.transparent,
        overlayColor: MaterialStateProperty.all(AppColors.black.withOpacity(0.1)),
        unselectedLabelColor: AppColors.black,
        labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white),
        automaticIndicatorColorAdjustment: true,
        unselectedLabelStyle: const TextStyle(fontSize: 15, color: AppColors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ExampleCandidateModel {
  String? image;
  String? job;
  String? city;

  ExampleCandidateModel({
    this.image,
    this.job,
    this.city,
  });
}

List<ExampleCandidateModel> candidates = [
  ExampleCandidateModel(
    image: 'https://wallpapercave.com/wp/wp8235051.jpg',
    job: 'Manager',
    city: 'Town',
  ),
  ExampleCandidateModel(
    image: 'https://wallpapercave.com/wp/wp7578910.jpg',
    job: 'Manager',
    city: 'Town',
  ),
  ExampleCandidateModel(
    image: 'https://wallpapercave.com/wp/wp5885891.jpg',
    job: 'Manager',
    city: 'Town',
  ),
  ExampleCandidateModel(
    image: 'https://wallpapercave.com/wp/wp8852204.jpg',
    job: 'Manager',
    city: 'Town',
  ),
  ExampleCandidateModel(
    image: 'https://wallpapercave.com/wp/wp7578728.jpg',
    job: 'Manager',
    city: 'Town',
  ),
  ExampleCandidateModel(
    image: 'https://wallpapercave.com/wp/wp8852207.jpg',
    job: 'Manager',
    city: 'Town',
  ),
  ExampleCandidateModel(
    image: 'https://wallpapercave.com/wp/wp8852211.jpg',
    job: 'Manager',
    city: 'Town',
  ),
  ExampleCandidateModel(
    image: 'https://wallpapercave.com/wp/wp8257746.jpg',
    job: 'Manager',
    city: 'Town',
  ),
];

enum Active { Like, Dislike }
