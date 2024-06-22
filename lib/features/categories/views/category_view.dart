// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  int listLength = 0;
  final List<dynamic> _productList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  init() {
    _productList.clear();
    _title = widget.catgoryList.first.name!;
    _selctedIndex = widget.selcetedIndex;
    getProducts2(categoryId: widget.categoryId, shopId: widget.shopId);

    scrollController.addListener(scrollListener);
  }

  scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      if (_productList.length < totalProducts &&
          ref.watch(productNotifierProvider) == false) {
        scrollLoading = true;
        count++;
        getProducts2(categoryId: widget.categoryId, shopId: widget.shopId);
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
              valueListenable:
                  Hive.box<HiveCartModel>(AppHSC.cartBox).listenable(),
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

                                // getProducts(
                                //   categoryId: catgory.id,
                                //   shopId: widget.shopId,
                                // );
                              }
                            },
                            isSelected: _selctedIndex == index,
                            title: 'Item ${catgory.name}',
                          );
                        },
                      ),
                    ),
                    FutureBuilder(
                        future: getProducts2(
                            categoryId: widget.categoryId,
                            shopId: widget.shopId),
                        builder: (context, snap) {
                          print(snap);
                          return Expanded(
                            child: Container(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                padding: EdgeInsets.symmetric(horizontal: 16.r),
                                child: isLoading && !scrollLoading
                                    ? _buildLoader(context)
                                    : (listLength > 0)
                                        ? AnimationLimiter(
                                            child: GridView.count(
                                              padding:
                                                  EdgeInsets.only(top: 10.h),
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 16.h,
                                              crossAxisSpacing: 16.w,
                                              childAspectRatio: 171 / 240,
                                              children: List.generate(
                                                listLength,
                                                (index) =>
                                                    AnimationConfiguration
                                                        .staggeredGrid(
                                                  columnCount: 2,
                                                  position: index,
                                                  duration: const Duration(
                                                      milliseconds: 375),
                                                  child: ScaleAnimation(
                                                    child: FadeInAnimation(
                                                      child: BasicProductCard(
                                                        product: Product(
                                                            id: snap.data[index]
                                                                ['id'],
                                                            name: snap.data[index]
                                                                ['name'],
                                                            thumbnail: snap.data[index]
                                                                ['thumbnail'],
                                                            price: double.parse(
                                                                snap.data[index]
                                                                    ['price']),
                                                            oldPrice: double.parse(snap
                                                                    .data[index]
                                                                ['old_price']),
                                                            discountPercentage:
                                                                snap.data[index]
                                                                    ['discount_percentage'],
                                                            shopId: snap.data[index]['shop_id'],
                                                            shopName: snap.data[index]['shop_name'],
                                                            sellType: snap.data[index]['sell_type'],
                                                            minimumQuantity: int.parse(snap.data[index]['min_order_qty']),
                                                            inStock: snap.data[index]['in_stock']),
                                                        cardColor:
                                                            colors(context)
                                                                .accentColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : listLength == 0
                                            ? Center(
                                                child: Text(
                                                  ' Opps no product found!',
                                                  style: textStyle.subTitle,
                                                ),
                                              )
                                            : Container()),
                          );
                        })
                  ],
                );
              })),
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

  Future getProducts2({required int categoryId, required int? shopId}) async {
    final client = Dio();
    try {
      final response = await client.get(
          'http://microshop.spatiulab.com/api/product/list?category_id=$categoryId&shop_id=$shopId&search=&page=1&per_page=10');

      if (response.statusCode == 200) {
        _productList.addAll(response.data['data']['products']);
        // print(_productList);
        listLength = response.data['data']['products'].length;
        return response.data['data']['products'];
      }
    } catch (error) {
      print(error);
    }
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
