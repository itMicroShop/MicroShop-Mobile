import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/categories/logic/category_provider.dart';
import 'package:grocerymart/features/categories/model/category.dart';
import 'package:grocerymart/features/home/view/widget/category_tile.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/widgets/busy_loader.dart';
import 'package:grocerymart/widgets/custom_app_bar.dart';

class AllCategoriesTab extends ConsumerStatefulWidget {
  const AllCategoriesTab({super.key});

  @override
  ConsumerState<AllCategoriesTab> createState() => _AllCategoriesTabState();
}

class _AllCategoriesTabState extends ConsumerState<AllCategoriesTab> {
  int count = 1;
  int totalCategory = 0;
  int categoryCount = 20;
  bool scrollLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCategories();
      _scrollController.addListener(_scrollListener);
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      if (_categories.length < totalCategory &&
          ref.watch(categoryStateNotifierProvider) == false) {
        scrollLoading = true;
        count++;
        getCategories();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    bool isLoading = ref.watch(categoryStateNotifierProvider);
    int columnCount = 4;
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: S.of(context).allCategories,
            showNotifIcon: true,
            showBack: false,
            centerTitle: false,
          ),
          Expanded(
            child: isLoading && !scrollLoading
                ? Center(
                    child: Container(
                      constraints:
                          BoxConstraints(maxHeight: 120.h, minWidth: 100.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: colors(context).accentColor),
                      width: 200,
                      child: const BusyLoader(
                        size: 120,
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: _categories.isEmpty
                        ? Center(
                            child: Text(
                              S.of(context).noCategoriesFound,
                              style: textStyle.subTitle,
                            ),
                          )
                        : AnimationLimiter(
                            child: GridView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.only(top: 10),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 16.h,
                                crossAxisSpacing: 16.w,
                                childAspectRatio: 78.w / 110.w,
                                crossAxisCount: columnCount,
                              ),
                              itemCount: _categories.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  columnCount: columnCount,
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                      child: CategoryTile(
                                        category: _categories[index],
                                        catgoryList: _categories,
                                        index: index,
                                        fromShop: false,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: isLoading && scrollLoading
          ? const SizedBox(
              height: 50,
              width: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : const SizedBox(),
    );
  }

  final List<Category> _categories = [];

  Future<void> getCategories() async {
    ref
        .read(categoryStateNotifierProvider.notifier)
        .getCategories(shopId: null, count: count, categoryCount: categoryCount)
        .then(
      (response) {
        totalCategory = response.total;
        _categories.addAll(response.categories);
      },
    );
  }
}
