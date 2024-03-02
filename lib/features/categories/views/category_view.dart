// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/hive_contants.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/cart/model/hive_cart_model.dart';
import 'package:grocerymart/features/categories/model/category.dart';
import 'package:grocerymart/features/categories/views/widget/custom_chip.dart';
import 'package:grocerymart/features/home/model/product.dart';
import 'package:grocerymart/features/home/view/widget/basic_product_card.dart';
import 'package:grocerymart/features/products/logic/product_provider.dart';
import 'package:grocerymart/widgets/busy_loader.dart';
import 'package:grocerymart/widgets/custom_app_bar.dart';
import 'package:grocerymart/widgets/screen_wrapper.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  final List<Category> catgoryList;
  final int selcetedIndex;
  final int categoryId;
  final int? shopId;
  const CategoryScreen({
    super.key,
    required this.catgoryList,
    required this.selcetedIndex,
    required this.categoryId,
    required this.shopId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryViewState();
}

class _CategoryViewState extends ConsumerState<CategoryScreen> {
  final ItemScrollController _scrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();

  final ScrollController scrollController = ScrollController();

  int count = 1;
  int totalProducts = 0;
  bool scrollLoading = false;
  int _selctedIndex = 0;
  String _title = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  init() {
    _title = widget.catgoryList.first.name!;
    _selctedIndex = widget.selcetedIndex;
    getProducts(categoryId: widget.categoryId, shopId: widget.shopId);
    scrollController.addListener(scrollListener);
  }

  scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      if (_productList.length < totalProducts &&
          ref.watch(productNotifierProvider) == false) {
        scrollLoading = true;
        count++;
        getProducts(categoryId: widget.categoryId, shopId: widget.shopId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    bool isLoading = ref.watch(productNotifierProvider);
    return Scaffold(
      body: ScreenWrapper(
        child: ValueListenableBuilder<Box<HiveCartModel>>(
          valueListenable: Hive.box<HiveCartModel>(AppHSC.cartBox).listenable(),
          builder: (context, cartBox, _) {
            final cartList = cartBox.values.toList();
            return Column(
              children: [
                Stack(
                  children: [
                    CustomAppBar(
                      title: _title,
                      showCartIcon: true,
                      showSearch: false,
                    ),
                    cartList.isNotEmpty
                        ? Positioned(
                            right: 12.w,
                            top: 40.h,
                            child: CircleAvatar(
                              radius: 12.sp,
                              backgroundColor: colors(context).primaryColor,
                              child: Center(
                                child: Text(
                                  cartList.length.toString(),
                                  style: textStyle.bodyText.copyWith(
                                    color: AppStaticColor.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
                Container(
                  height: 50.h,
                  width: 390.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: ScrollablePositionedList.builder(
                    initialScrollIndex: widget.selcetedIndex,
                    itemScrollController: _scrollController,
                    itemCount: widget.catgoryList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final catgory = widget.catgoryList[index];
                      return SelectChip(
                        onTap: () {
                          if (_selctedIndex != index) {
                            setState(() {
                              _selctedIndex = index;
                              _title = catgory.name!;
                              count = 1;
                              scrollLoading = false;
                            });
                            if (_scrollController.isAttached) {
                              _scrollController.scrollTo(
                                index: _selctedIndex,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOutCubic,
                              );
                            }
                            _productList.clear();
                            getProducts(
                              categoryId: catgory.id,
                              shopId: widget.shopId,
                            );
                          }
                        },
                        isSelected: _selctedIndex == index,
                        title: 'Item ${catgory.name}',
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
                    child: isLoading && !scrollLoading
                        ? _buildLoader(context)
                        : _productList.isNotEmpty
                            ? AnimationLimiter(
                                child: GridView.count(
                                  padding: EdgeInsets.only(top: 10.h),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.h,
                                  crossAxisSpacing: 16.w,
                                  childAspectRatio: 171 / 240,
                                  children: List.generate(
                                    _productList.length,
                                    (index) =>
                                        AnimationConfiguration.staggeredGrid(
                                      columnCount: 2,
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: BasicProductCard(
                                            product: _productList[index],
                                            cardColor:
                                                colors(context).accentColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  ' Opps no product found!',
                                  style: textStyle.subTitle,
                                ),
                              ),
                  ),
                )
              ],
            );
          },
        ),
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

  final List<Product> _productList = [];
  Future<void> getProducts(
      {required int categoryId, required int? shopId}) async {
    await ref
        .read(productNotifierProvider.notifier)
        .getProducts(
          categoryId: categoryId,
          shopId: shopId,
          search: null,
          count: count,
          productCount: 10,
        )
        .then((response) {
      _productList.addAll(response.productList);
      totalProducts = response.total;
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
}
