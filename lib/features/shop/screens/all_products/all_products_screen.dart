import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/common/widgets/products/sortable/sortable_products.dart';
import 'package:outfit4rent/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:outfit4rent/features/shop/controllers/all_products_controller.dart';
import 'package:outfit4rent/features/shop/models/product_model.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';
import 'package:outfit4rent/utils/helpers/cloud_helper_functions.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });

  final String title;
  final Map<String, dynamic>? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: TAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder<List<ProductModel>>(
              future: futureMethod ?? controller.fetchProductsByQuery(query ?? {}),
              builder: (context, snapshot) {
                //Todo: Check the state of the Future
                const loader = TVerticalProductShimmer();
                final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

                if (widget != null) return widget;
                final product = snapshot.data!;
                return TSortableProducts(
                  products: product,
                );
              }),
        ),
      ),
    );
  }
}
