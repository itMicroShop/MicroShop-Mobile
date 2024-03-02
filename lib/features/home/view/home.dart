import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/hive_contants.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/categories/logic/category_provider.dart';
import 'package:grocerymart/features/categories/model/category.dart';
import 'package:grocerymart/features/dashboard/logic/misc_providers.dart';
import 'package:grocerymart/features/home/logic/home_provider.dart';
import 'package:grocerymart/features/home/model/banner.dart';
import 'package:grocerymart/features/home/model/product.dart';
import 'package:grocerymart/features/home/view/widget/category_tile.dart';
import 'package:grocerymart/features/home/view/widget/home_page_hero_slider.dart';
import 'package:grocerymart/features/home/view/widget/home_shimmer.dart';
import 'package:grocerymart/features/home/view/widget/near_by_store.dart';
import 'package:grocerymart/features/home/view/widget/recommended_widget.dart';
import 'package:grocerymart/features/menu/model/user_address.dart';
import 'package:grocerymart/features/shop/logic/shop_provider.dart';
import 'package:grocerymart/features/shop/model/shop.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/busy_loader.dart';
import 'package:grocerymart/widgets/custom_app_bar.dart';
import 'package:grocerymart/widgets/permission_handler_dialog.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  Future<void> init() async {
    LocationPermission permission = await Geolocator.checkPermission();
    getBanners();
    getRecommendedProducts();
    getCategories();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      getShopList(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );
    } else {
      Position? position = await getLocation();
      getShopList(
        latitude: position!.latitude.toString(),
        longitude: position.longitude.toString(),
      );
    }
  }

  bool loader = true;
  bool isLoading = false;
  @override
  Widget build(
    BuildContext context,
  ) {
    bool bannerLoading = ref.watch(homeStateNotifierProvider);
    bool shopLoading = ref.watch(shopNotifierProvider);
    bool categoryLoading = ref.watch(categoryStateNotifierProvider);
    return Scaffold(
      body: bannerLoading
          ? const HomeShimmerWidget()
          : Column(
              children: [
                SizedBox(child: _buildAppBar(context)),
                Flexible(
                  flex: 4,
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 55.h),
                    shrinkWrap: true,
                    children: [
                      bannerLoading
                          ? _builderLoader()
                          : HomePageHeroSlider(
                              banners: _banners,
                            ),
                      productLoading
                          ? _builderLoader()
                          : RecommendedWidget(
                              products: _products,
                            ),
                      categoryLoading
                          ? _builderLoader()
                          : _buildCategoriesWidget(),
                      shopLoading || loader
                          ? _builderLoader()
                          : NearbyStoreWidget(
                              shopList: _shopList,
                            ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Container _buildCategoriesWidget() {
    final textStyle = AppTextStyle(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      padding: EdgeInsets.all(10.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: colors(context).accentColor ?? AppStaticColor.accentColor,
            blurRadius: 5,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: AnimationLimiter(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).categories,
                  style: textStyle.subTitle,
                ),
                GestureDetector(
                  onTap: () {
                    ref.watch(homeTabControllerProvider).animateToPage(1,
                        duration: 200.miliSec, curve: Curves.easeInOutCubic);
                  },
                  child: Text(
                    S.of(context).viewAll,
                    style: textStyle.bodyText.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colors(context).primaryColor),
                  ),
                ),
              ],
            ),
            GridView.count(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10),
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
              childAspectRatio: 78.w / 115.h,
              crossAxisCount: 4,
              children: List.generate(
                _categories.length,
                (index) => AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: 4,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return CustomAppBar(
      showNotifIcon: true,
      showBack: false,
      showSearchTextField: true,
      searchController: searchController,
      readOnly: true,
      onPressed: () {
        context.nav.pushNamed(Routes.ownProductScreen, arguments: _products);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_pin,
                color: colors(context).primaryColor,
              ),
              8.pw,
              ValueListenableBuilder(
                valueListenable:
                    Hive.box(AppHSC.deliveryAddressBox).listenable(),
                builder: (context, addressBox, _) {
                  UserAddress? deliveryAddress;
                  Map<dynamic, dynamic>? address =
                      addressBox.get(AppHSC.deliveryAddress);
                  if (address != null) {
                    Map<String, dynamic> addressStringKey =
                        address.cast<String, dynamic>();
                    deliveryAddress = UserAddress.fromMap(addressStringKey);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            S.of(context).deliverTo,
                            style: textStyle.bodyTextSmall
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                      deliveryAddress != null
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width / 1.6,
                              child: Text(
                                '${deliveryAddress.flat},${deliveryAddress.area},${deliveryAddress.postCode}, ${deliveryAddress.addressLine1} ${deliveryAddress.addressLine2}',
                                overflow: TextOverflow.ellipsis,
                                style: textStyle.bodyTextSmall
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  final List<BannerModel> _banners = [];
  final List<Product> _products = [];
  final List<Category> _categories = [];
  final List<Shop> _shopList = [];

  bool productLoading = false;

  Future<void> getBanners() async {
    await ref.read(homeStateNotifierProvider.notifier).getBanners().then(
      (banners) {
        _banners.addAll(banners);
        setState(() {});
      },
    );
  }

  Future<void> getRecommendedProducts() async {
    setState(() {
      productLoading = true;
    });
    await ref
        .read(homeStateNotifierProvider.notifier)
        .getRecommendedProducts()
        .then((products) {
      setState(() {
        productLoading = false;
      });
      _products.addAll(products);
    });
  }

  Future<void> getCategories() async {
    ref
        .read(categoryStateNotifierProvider.notifier)
        .getCategories(shopId: null, count: 1, categoryCount: 8)
        .then(
      (response) {
        setState(() {});
        _categories.addAll(response.categories);
        setState(() {});
      },
    );
  }

  Future<void> getShopList(
      {required String latitude, required String longitude}) async {
    ref
        .read(shopNotifierProvider.notifier)
        .getShopList(
            latitude: latitude, longitude: longitude, count: 1, shopCount: 4)
        .then((response) {
      loader = false;
      _shopList.addAll(response.shopList);
    });
  }

  Future<Position?> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location servces is not disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showPermissionHandlerDialog(
          buttionName: "Request Permission",
          permission: permission,
        );
        return null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showPermissionHandlerDialog(
        buttionName: "GO TO SETTINGS",
        permission: permission,
      );
      return null;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  void showPermissionHandlerDialog({
    required String buttionName,
    required LocationPermission permission,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PermissionHandlerDialog(
          buttionName: buttionName,
          onTap: () async {
            context.nav.pop();
            if (permission == LocationPermission.denied) {
              await Geolocator.requestPermission();
              Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);
              getShopList(
                latitude: position.latitude.toString(),
                longitude: position.longitude.toString(),
              );
            } else if (permission == LocationPermission.deniedForever) {
              await AppSettings.openAppSettings(
                      type: AppSettingsType.location, asAnotherTask: true)
                  .then((value) => SystemNavigator.pop());
            }
          },
        );
      },
    );
  }

  _builderLoader() {
    return Container(
      decoration: BoxDecoration(
        color: colors(context).accentColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: const Center(
        child: BusyLoader(
          size: 120,
        ),
      ),
    );
  }
}
