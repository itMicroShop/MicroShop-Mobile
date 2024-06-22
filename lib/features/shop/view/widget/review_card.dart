import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/shop/model/user_review.dart';
import 'package:readmore/readmore.dart';

class ReviewCard extends StatelessWidget {
  final UserReview userReview;
  const ReviewCard({
    Key? key,
    required this.userReview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppStaticColor.grayColor.withOpacity(
            0.2,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.red,
              backgroundImage: CachedNetworkImageProvider(
                userReview.userProfilePhoto,
              ),
            ),
            title: Text(
              userReview.userName,
              style: textStyle.bodyTextSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppStaticColor.blackColor,
              ),
            ),
            subtitle: Text(userReview.date),
            trailing: SizedBox(
              width: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(userReview.rating.toString()),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        getRating(userReview.rating),
                        (index) => const Icon(
                          Icons.star,
                          size: 16,
                          color: Color(0xFFf4b30c),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: ReadMoreText(
              userReview.message,
              trimLines: 2,
              trimCollapsedText: 'Show More',
              trimExpandedText: 'Show less',
              trimMode: TrimMode.Line,
              style: textStyle.bodyTextSmall.copyWith(
                fontWeight: FontWeight.normal,
                color: AppStaticColor.blackColor,
              ),
              moreStyle: TextStyle(color: colors(context).primaryColor),
              lessStyle: TextStyle(color: colors(context).primaryColor),
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  int getRating(String stringValue) {
    String cleanValue = stringValue.replaceAll('.', '').replaceAll('0', '');
    int rating = int.tryParse(cleanValue) ?? 0;
    return rating;
  }
}
