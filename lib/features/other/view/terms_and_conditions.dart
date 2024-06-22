import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/other/logic/html_content_repo.dart';
import 'package:grocerymart/features/other/model/html_content.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/widgets/busy_loader.dart';

class TermsAndConditions extends ConsumerWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = AppTextStyle(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).termsConditions),
      ),
      body: FutureBuilder(
        future: ref.read(htmlContentRepo).getTermsAndConditions(),
        builder: ((context, AsyncSnapshot<HtmlContent> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                S.of(context).someThingWrong,
                style: textStyle.subTitle,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final HtmlContent? termsAndConditions = snapshot.data;

            return Padding(
              padding: EdgeInsets.all(10.0.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Html(
                      style: {
                        '*': Style(
                            fontSize: FontSize(14.sp),
                            fontFamily: 'Open Sans',
                            color: colors(context).bodyTextColor)
                      },
                      data: termsAndConditions!.content,
                    ),
                  ],
                ),
              ),
            );
          }
          return _buildLoader(context);
        }),
      ),
    );
  }

  _buildLoader(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxHeight: 120.h, minWidth: 100.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: colors(context).accentColor),
        width: 200,
        child: const BusyLoader(
          size: 120,
        ),
      ),
    );
  }
}
