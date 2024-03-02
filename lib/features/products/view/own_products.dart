// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/home/model/product.dart';
import 'package:grocerymart/features/home/view/widget/basic_product_card.dart';
import 'package:grocerymart/features/products/logic/product_provider.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/util/context_less_nav.dart';
import 'package:grocerymart/widgets/busy_loader.dart';
import 'package:grocerymart/widgets/custom_search_field.dart';

// ignore: must_be_immutable
class OwnProductView extends ConsumerStatefulWidget {
  List<Product> products;
  OwnProductView({
    super.key,
    required this.products,
  });

  @override
  ConsumerState<OwnProductView> createState() => _OwnProductViewState();
}

class _OwnProductViewState extends ConsumerState<OwnProductView> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  int count = 1;
  int totalProducts = 0;
  bool scrollLoading = false;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      if (widget.products.length < totalProducts &&
          ref.watch(productNotifierProvider) == false) {
        scrollLoading = true;
        count++;
        getProducts(isSearch: false);
      }
    }
  }

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(productNotifierProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 80.h,
          title: Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: CustomSearchField(
              searchController: searchController,
              hintText: S.of(context).searchProducts,
              onChanged: (value) {
                if (value!.isEmpty) {
                  FocusScope.of(context).unfocus();
                  getProducts(isSearch: false);
                }
              },
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Future.delayed(const Duration(milliseconds: 200), () {
                  context.nav.pop();
                });
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          actions: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w).copyWith(bottom: 10),
              child: GestureDetector(
                onTap: () async {
                  scrollLoading = false;
                  FocusScope.of(context).unfocus();
                  if (searchController.text.isNotEmpty) {
                    getProducts(isSearch: true);
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
        body: isLoading && !scrollLoading
            ? Center(
                child: SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child: const BusyLoader(),
                ),
              )
            : GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  children: [
                    Expanded(
                      child: AnimationLimiter(
                        child: GridView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 14.h),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.h,
                                  crossAxisSpacing: 16.w,
                                  childAspectRatio: 171 / 240),
                          itemBuilder: (context, index) =>
                              AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: 2,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: BasicProductCard(
                                  product: widget.products[index],
                                  cardColor: colors(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                          itemCount: widget.products.length,
                        ),
                      ),
                    )
                  ],
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
      ),
    );
  }

  Future<void> getProducts({required bool isSearch}) async {
    await ref
        .read(productNotifierProvider.notifier)
        .getProducts(
          categoryId: null,
          shopId: null,
          search: searchController.text,
          count: count,
          productCount: 10,
        )
        .then((response) {
      totalProducts = response.total;
      if (isSearch) {
        widget.products = response.productList;
      } else {
        widget.products.addAll(response.productList);
      }
    });
  }
}
