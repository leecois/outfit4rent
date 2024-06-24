import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';
import 'package:outfit4rent/data/repositories/package/package_repository.dart';
import 'package:outfit4rent/features/shop/models/package_model.dart';

class PackageController extends GetxController {
  static PackageController get instance => Get.find();

  final isLoading = false.obs;
  final _packageRepository = Get.put(PackageRepository());
  RxList<PackageModel> allPackages = <PackageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPackages();
  }

  Future<void> fetchPackages() async {
    try {
      isLoading.value = true;
      final packages = await _packageRepository.getAllPackages();
      allPackages.assignAll(packages);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
