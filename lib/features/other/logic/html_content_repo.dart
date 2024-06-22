import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerymart/config/app_constants.dart';
import 'package:grocerymart/features/other/model/html_content.dart';
import 'package:grocerymart/utils/api_client.dart';

class HtmlContentRepo {
  final Ref ref;

  HtmlContentRepo(this.ref);

  Future<HtmlContent> getPrivacyPolicy() async {
    final response =
        await ref.read(apiClientProvider).get(AppConstant.getPrivacyPolicy);
    final data = response.data['data']['setting'];
    final privacyPolicy = HtmlContent.fromMap(data);
    return privacyPolicy;
  }

  Future<HtmlContent> getTermsAndConditions() async {
    final response = await ref
        .read(apiClientProvider)
        .get(AppConstant.getTermsAndConditions);
    final data = response.data['data']['setting'];
    final termsAndConditions = HtmlContent.fromMap(data);
    return termsAndConditions;
  }

  Future<HtmlContent> getAboutUsContent() async {
    final response =
        await ref.read(apiClientProvider).get(AppConstant.getAboutUsContent);
    final data = response.data['data']['setting'];
    final aboutUs = HtmlContent.fromMap(data);
    return aboutUs;
  }
}

final htmlContentRepo = Provider((ref) => HtmlContentRepo(ref));
