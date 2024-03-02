// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/home/model/banner.dart';
import 'package:grocerymart/util/entensions.dart';

class HomePageHeroSlider extends ConsumerStatefulWidget {
  final List<BannerModel> banners;
  const HomePageHeroSlider({
    super.key,
    required this.banners,
  });

  @override
  ConsumerState<HomePageHeroSlider> createState() => _HomePageHeroSliderState();
}

class _HomePageHeroSliderState extends ConsumerState<HomePageHeroSlider> {
  final controller = PageController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
        children: [
          widget.banners.isNotEmpty
              ? SizedBox(
                  height: 157.h,
                  child: PageView(
                    controller: controller,
                    onPageChanged: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                    children: widget.banners
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.all(12.r),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Container(
                                height: 158.h,
                                width: double.infinity.w,
                                color: AppStaticColor.accentColor,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: e.media,
                                  placeholder: (context, url) =>
                                      const Icon(Icons.image),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(12.r),
                  padding: EdgeInsets.all(12.r),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppStaticColor.accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 157.h,
                  child: const Center(
                    child: Icon(Icons.image),
                  ),
                ),
          SizedBox(
            width: 390.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.banners
                  .asMap()
                  .entries
                  .map(
                    (mapentry) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: AnimatedSliderDot(
                        isActive: mapentry.key == selectedIndex,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          12.ph
        ],
      ),
    );
  }
}

class AnimatedSliderDot extends StatelessWidget {
  const AnimatedSliderDot({
    super.key,
    this.size = 5,
    this.width = 15,
    this.isActive = false,
  });
  final double size;
  final double width;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 200.miliSec,
      height: size,
      width: isActive ? size * 6 : width,
      decoration: BoxDecoration(
        color: isActive
            ? colors(context).primaryColor
            : colors(context).primaryColor!.withOpacity(0.4),
        borderRadius: BorderRadius.circular(size / 2),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
