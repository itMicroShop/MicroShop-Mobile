import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/categories/logic/category_provider.dart';
import 'package:grocerymart/features/categories/model/category.dart';
import 'package:grocerymart/features/home/model/product.dart';
import 'package:grocerymart/features/home/view/widget/basic_product_card.dart';
import 'package:grocerymart/features/home/view/widget/category_tile.dart';
import 'package:grocerymart/features/products/logic/product_provider.dart';
import 'package:grocerymart/features/shop/logic/shop_provider.dart';
import 'package:grocerymart/features/shop/model/shop.dart';
import 'package:grocerymart/features/shop/model/user_review.dart';
import 'package:grocerymart/features/shop/view/widget/review_card.dart';
import 'package:grocerymart/features/shop/view/widget/store_profile.dart';
import 'package:grocerymart/features/shop/view/widget/store_tab_selector.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/busy_loader.dart';
import 'package:grocerymart/widgets/screen_wrapper.dart';

class StoreDetailsScreen extends ConsumerStatefulWidget {
  final Shop shopDetails;
  const StoreDetailsScreen({
    super.key,
    required this.shopDetails,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends ConsumerState<StoreDetailsScreen> {
  int count = 1;
  int totalProducts = 0;
  int totalCategories = 0;
  int totalReviews = 0;
  int totalItemPerPage = 10;
  bool scrollLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getShopProducts();
      getCategoryList();
      getUserReviewList();
      _scrollController.addListener(_scrollListener);
    });
  }

  _scrollListener() {
    if (selectedIndex == 0) {
      return productScrollListener();
    } else if (selectedIndex == 1) {
      return categoryScrollListener();
    }
    return reviewsScrollListener();
  }

  productScrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      if (_shopProducts.length < totalProducts &&
          ref.watch(productNotifierProvider) == false) {
        scrollLoading = true;
        count++;
        getShopProducts();
      }
    }
  }

  categoryScrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      if (_categoryList.length < totalCategories &&
          ref.watch(categoryStateNotifierProvider) == false) {
        scrollLoading = true;
        count++;
        getCategoryList();
      }
    }
  }

  reviewsScrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      if (_userReviewList.length < totalReviews &&
          ref.watch(shopNotifierProvider) == false) {
        scrollLoading = true;
        count++;
        getUserReviewList();
      }
    }
  }

  PageController controller = PageController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    bool productLoading = ref.watch(productNotifierProvider);
    bool categoryLoading = ref.watch(categoryStateNotifierProvider);
    bool reviewLoading = ref.watch(shopNotifierProvider);
    return Scaffold(
      body: ScreenWrapper(
        child: Column(
          children: [
            StoreProfile(
              shopDetails: widget.shopDetails,
            ),
            Container(
              height: 104.h,
              width: 390.w,
              color: AppStaticColor.accentColor,
              child: widget.shopDetails.banners.isEmpty
                  ? _buildEmptyBannerList()
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: widget.shopDetails.banners.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                              left: index == 0 ? 5 : 16.r, right: 5.r),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 228.w,
                              height: 72.h,
                              padding: EdgeInsets.all(2.r),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    widget.shopDetails.banners[index].media,
                                placeholder: (context, url) =>
                                    const Icon(Icons.image),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            Container(
              width: 390.w,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StoreTabSelector(
                    title: S.of(context).allProducts,
                    selected: selectedIndex == 0,
                    onTap: () {
                      if (selectedIndex != 0) {
                        setState(() {
                          count = 1;
                          scrollLoading = false;
                          selectedIndex = 0;
                          controller.animateToPage(0,
                              duration: 200.miliSec,
                              curve: Curves.easeInOutCubic);
                        });
                      }
                    },
                  ),
                  StoreTabSelector(
                    title: S.of(context).categories,
                    selected: selectedIndex == 1,
                    onTap: () {
                      setState(() {
                        count = 1;
                        selectedIndex = 1;
                        controller.animateToPage(1,
                            duration: 200.miliSec,
                            curve: Curves.easeInOutCubic);
                      });
                    },
                  ),
                  StoreTabSelector(
                    title: S.of(context).reviews,
                    selected: selectedIndex == 2,
                    onTap: () {
                      setState(
                        () {
                          count = 1;
                          selectedIndex = 2;
                          controller.animateToPage(2,
                              duration: 200.miliSec,
                              curve: Curves.easeInOutCubic);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
                children: [
                  Container(
                    width: 390.w,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: productLoading && !scrollLoading
                        ? _buildLoader(context)
                        : _shopProducts.isNotEmpty
                            ? AnimationLimiter(
                                child: GridView.builder(
                                  padding:
                                      const EdgeInsets.only(bottom: 50, top: 5),
                                  controller: _scrollController,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16.h,
                                    crossAxisSpacing: 16.w,
                                    childAspectRatio: 171 / 240,
                                  ),
                                  itemCount: _shopProducts.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 2,
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: BasicProductCard(
                                            product: _shopProducts[index],
                                            cardColor:
                                                colors(context).accentColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Text(
                                  S.of(context).noProductFound,
                                  style: textStyle.subTitle,
                                ),
                              ),
                  ),
                  Container(
                    width: 390.w,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: categoryLoading && !scrollLoading
                        ? _buildLoader(context)
                        : _categoryList.isNotEmpty
                            ? AnimationLimiter(
                                child: GridView.builder(
                                  controller: _scrollController,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 16.h,
                                    crossAxisSpacing: 16.w,
                                    childAspectRatio: 78.w / 110.h,
                                    crossAxisCount: 4,
                                  ),
                                  itemCount: _categoryList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == _shopProducts.length) {
                                      if (categoryLoading) {
                                        return const ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              CircularProgressIndicator(),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }
                                    final Category category =
                                        _categoryList[index];
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 4,
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: CategoryTile(
                                            category: category,
                                            catgoryList: _categoryList,
                                            index: index,
                                            fromShop: true,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Text(
                                  S.of(context).noCategoriesFound,
                                  style: textStyle.subTitle,
                                ),
                              ),
                  ),
                  Container(
                    width: 390.w,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: reviewLoading && !scrollLoading
                        ? _buildLoader(context)
                        : _userReviewList.isNotEmpty
                            ? AnimationLimiter(
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: _userReviewList.length,
                                  itemBuilder: (context, index) {
                                    if (index == _userReviewList.length) {
                                      if (reviewLoading) {
                                        return const ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              CircularProgressIndicator(),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: ReviewCard(
                                              userReview:
                                                  _userReviewList[index],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Text(
                                  S.of(context).reviewsNotFound,
                                  style: textStyle.subTitle,
                                ),
                              ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar:
          (productLoading || categoryLoading || reviewLoading) && scrollLoading
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

  final List<Product> _shopProducts = [];
  Future<void> getShopProducts() async {
    await ref
        .read(productNotifierProvider.notifier)
        .getProducts(
          categoryId: null,
          shopId: widget.shopDetails.id,
          search: null,
          count: count,
          productCount: totalItemPerPage,
        )
        .then((response) {
      totalProducts = response.total;
      _shopProducts.addAll(response.productList);
    });
  }

  final List<Category> _categoryList = [];
  Future<void> getCategoryList() async {
    await ref
        .read(categoryStateNotifierProvider.notifier)
        .getCategories(
          shopId: widget.shopDetails.id,
          count: count,
          categoryCount: 20,
        )
        .then((response) {
      totalCategories = response.total;
      _categoryList.addAll(response.categories);
    });
  }

  final List<UserReview> _userReviewList = [];
  Future<void> getUserReviewList() async {
    await ref
        .read(shopNotifierProvider.notifier)
        .getUserReviews(
          shopId: widget.shopDetails.id,
          count: count,
          reviewCount: 20,
        )
        .then((response) {
      totalReviews = response.total;
      _userReviewList.addAll(response.userReviews);
    });
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

  _buildEmptyBannerList() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: 3,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(left: index == 0 ? 5 : 16.r, right: 5.r),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: 228.w,
              height: 72.h,
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.all(2.r),
              child: Center(
                child: Text(
                  'No Banner',
                  style: AppTextStyle(context)
                      .bodyText
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
