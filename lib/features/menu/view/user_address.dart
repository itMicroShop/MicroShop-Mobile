import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_input_decor.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/menu/logic/menu_provider.dart';
import 'package:grocerymart/features/menu/model/user_address.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/busy_loader.dart';
import 'package:grocerymart/widgets/buttons/full_width_button.dart';

class AddUserAddressScreen extends ConsumerStatefulWidget {
  final UserAddress? userAddress;
  const AddUserAddressScreen({
    super.key,
    required this.userAddress,
  });

  @override
  ConsumerState<AddUserAddressScreen> createState() =>
      _AddUserAddressScreenState();
}

class _AddUserAddressScreenState extends ConsumerState<AddUserAddressScreen> {
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();

  final TextEditingController nameControler = TextEditingController();

  final TextEditingController phoneNumController = TextEditingController();

  final TextEditingController areaController = TextEditingController();

  final TextEditingController flatNumController = TextEditingController();

  final TextEditingController postalCodeController = TextEditingController();

  final TextEditingController addressLine1Controller = TextEditingController();

  final TextEditingController addressLine2Controller = TextEditingController();

  int activeIndex = 0;

  List<String> addressTags = ['home', 'office', 'other'];
  String addressTag = '';

  final List<FocusNode> fNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  bool isDefaultAddress = false;

  @override
  void initState() {
    super.initState();
    getPosition();
    if (widget.userAddress != null) {
      nameControler.text = widget.userAddress!.name;
      phoneNumController.text = widget.userAddress!.phone;
      areaController.text = widget.userAddress!.area;
      flatNumController.text = widget.userAddress!.flat;
      postalCodeController.text = widget.userAddress!.postCode.toString();
      addressLine1Controller.text = widget.userAddress!.addressLine1;
      addressLine2Controller.text = widget.userAddress!.addressLine2;
      addressTag = widget.userAddress!.addressName;
      isDefaultAddress = widget.userAddress!.isDefault;
      activeIndex =
          addressTags.indexOf(widget.userAddress!.addressName.toLowerCase());
    } else {
      addressTag = addressTags.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(menuStateNotifierProvider);
    final textStyle = AppTextStyle(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).addNewAddress),
        ),
        body: FormBuilder(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
            ),
            child: SingleChildScrollView(
              child: AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        )),
                    children: [
                      SizedBox(height: 10.h),
                      buildTextField(
                        name: S.of(context).name,
                        hintText: S.of(context).enterName,
                        focusNode: fNodes[0],
                        textInputType: TextInputType.text,
                        controller: nameControler,
                        width: double.infinity,
                      ),
                      14.ph,
                      buildTextField(
                        name: S.of(context).phoneNumber,
                        hintText: S.of(context).enterPhone,
                        focusNode: fNodes[1],
                        textInputType: TextInputType.phone,
                        controller: phoneNumController,
                        width: double.infinity,
                      ),
                      14.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildTextField(
                            name: S.of(context).area,
                            hintText: S.of(context).area,
                            focusNode: fNodes[2],
                            textInputType: TextInputType.text,
                            controller: areaController,
                            width: null,
                          ),
                          buildTextField(
                            name: S.of(context).flat,
                            hintText: S.of(context).enterFlatNo,
                            focusNode: fNodes[3],
                            textInputType: TextInputType.number,
                            controller: flatNumController,
                            width: null,
                          ),
                          buildTextField(
                            name: S.of(context).postalCode,
                            hintText: S.of(context).enterPC,
                            focusNode: fNodes[4],
                            textInputType: TextInputType.text,
                            controller: postalCodeController,
                            width: null,
                          ),
                        ],
                      ),
                      14.ph,
                      buildTextField(
                        name: S.of(context).addressLine1,
                        hintText: S.of(context).enterAddressLine1,
                        focusNode: fNodes[5],
                        textInputType: TextInputType.text,
                        controller: addressLine1Controller,
                        width: double.infinity,
                      ),
                      14.ph,
                      buildTextField(
                        name: S.of(context).addressLine2,
                        hintText: S.of(context).enterAddressLine1,
                        focusNode: fNodes[6],
                        textInputType: TextInputType.text,
                        controller: addressLine2Controller,
                        width: double.infinity,
                      ),
                      14.ph,
                      buildAddressTag(),
                      14.ph,
                      Row(
                        children: [
                          Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            activeColor: colors(context).primaryColor,
                            value: isDefaultAddress,
                            onChanged: (defult) {
                              setState(() {
                                isDefaultAddress = defult!;
                              });
                            },
                          ),
                          Text(
                            S.of(context).makeDefault,
                            style: textStyle.bodyTextSmall
                                .copyWith(fontWeight: FontWeight.w500),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
          child: isLoading
              ? SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child: const BusyLoader(),
                )
              : AppTextButton(
                  height: 50.h,
                  onTap: () {
                    performSaveAddress();
                  },
                  title: S.of(context).save,
                ),
        ),
      ),
    );
  }

  late Position _position;
  Future<void> getPosition() async {
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> performSaveAddress() async {
    if (_formkey.currentState!.validate()) {
      UserAddress userAddress = UserAddress(
        id: widget.userAddress?.id,
        name: nameControler.text,
        phone: phoneNumController.text,
        area: areaController.text,
        flat: flatNumController.text,
        postCode: postalCodeController.text,
        addressLine1: addressLine1Controller.text,
        addressLine2: addressLine2Controller.text,
        latitude: _position.latitude.toString(),
        longitude: _position.longitude.toString(),
        addressName: addressTag,
        isDefault: isDefaultAddress,
      );
      final nav = context.nav;
      String? message = await ref
          .read(menuStateNotifierProvider.notifier)
          .manageUserAddress(userAddress: userAddress);
      nav.pop(true);
      EasyLoading.showSuccess(message!);
    } else {
      return;
    }
  }

  Widget buildTextField({
    required String name,
    required FocusNode focusNode,
    required String hintText,
    required TextInputType textInputType,
    required TextEditingController controller,
    required double? width,
  }) {
    final textStyle = AppTextStyle(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: textStyle.bodyTextSmall.copyWith(fontWeight: FontWeight.w500),
        ),
        14.ph,
        SizedBox(
          width: width ?? 114.w,
          child: FormBuilderTextField(
            focusNode: focusNode,
            name: name,
            decoration: AppInputDecor.loginPageInputDecor.copyWith(
              hintText: hintText,
            ),
            keyboardType: textInputType,
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose(
              [FormBuilderValidators.required()],
            ),
            controller: controller,
          ),
        ),
      ],
    );
  }

  Widget buildAddressTag() {
    final textStyle = AppTextStyle(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).addressTag,
          style: textStyle.bodyTextSmall.copyWith(fontWeight: FontWeight.w500),
        ),
        14.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: addressTags.asMap().entries.map(
            (entry) {
              int index = entry.key;
              String tag = entry.value;
              return InkWell(
                borderRadius: BorderRadius.circular(8.sp),
                onTap: () {
                  setState(() {
                    activeIndex = index;
                    addressTag = tag;
                  });
                },
                child: Container(
                  height: 50.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    border: Border.all(
                      color: activeIndex == index
                          ? colors(context).primaryColor ??
                              AppStaticColor.primaryColor
                          : colors(context).bodyTextColor!.withOpacity(0.5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tag.toUpperCase(),
                      style: textStyle.bodyTextSmall.copyWith(
                          color: activeIndex == index
                              ? colors(context).primaryColor ??
                                  AppStaticColor.primaryColor
                              : colors(context).bodyTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
