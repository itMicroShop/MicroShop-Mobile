import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/shop/logic/shop_provider.dart';
import 'package:grocerymart/features/shop/model/shop.dart';
import 'package:grocerymart/features/shop/view/widget/seller_card.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/widgets/busy_loader.dart';
import 'package:grocerymart/widgets/custom_search_field.dart';

class ShopTab extends ConsumerStatefulWidget {
  const ShopTab({super.key});

  @override
  ConsumerState<ShopTab> createState() => _StoresTabState();
}

class _StoresTabState extends ConsumerState<ShopTab> {
  int count = 1;
  int totalShop = 0;
  int shopCount = 6;
  bool scrollLoading = false;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = SearchController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getShopList(isSearch: false);
      _scrollController.addListener(_scrollListener);
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      if (_nearByShop.length < totalShop &&
          ref.watch(shopNotifierProvider) == false) {
        scrollLoading = true;
        count++;
        getShopList(isSearch: false);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(shopNotifierProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.h,
          title: Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: CustomSearchField(
              hintText: S.of(context).searchShop,
              searchController: _searchController,
              onChanged: (value) {
                if (value!.isEmpty) {
                  getShopList(isSearch: false);
                }
              },
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w).copyWith(bottom: 10),
              child: GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  scrollLoading = false;
                  count = 1;
                  if (_searchController.text.isNotEmpty) {
                    getShopList(isSearch: true);
                  }
                },
                child: CircleAvatar(
                  radius: 25.r,
                  backgroundColor: colors(context).accentColor,
                  child: Icon(
                    Icons.search,
                    color: colors(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: (isLoading || positionLoader) && scrollLoading == false
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
                    : AnimationLimiter(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.only(bottom: 100.h),
                          itemCount: _nearByShop.length + 1,
                          itemBuilder: (context, index) {
                            if (index == _nearByShop.length) {
                              if (isLoading) {
                                return const ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 8.h),
                                    child: SellerCard(
                                      shop: _nearByShop[index],
                                      cardColor: colors(context).accentColor,
                                    ),
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
      ),
    );
  }

  final List<Shop> _nearByShop = [];
  bool positionLoader = false;
  Future<void> getShopList({required bool isSearch}) async {
    setState(() {
      positionLoader = true;
    });
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      positionLoader = false;
    });
    await ref
        .read(shopNotifierProvider.notifier)
        .getShopList(
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
          shop: _searchController.text,
          count: count,
          shopCount: shopCount,
        )
        .then((response) {
      if (isSearch) {
        totalShop = response.total;
        _nearByShop.clear();
        _nearByShop.addAll(response.shopList);
      } else {
        totalShop = response.total;
        _nearByShop.addAll(response.shopList);
      }
    });
  }
}
