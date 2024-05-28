import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:outfit4rent/common/widgets/appbar/appbar.dart';
import 'package:outfit4rent/utils/constants/sizes.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Add new Address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user_outline), labelText: 'Name')),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile_outline), labelText: 'Phone Number')),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_3_outline), labelText: 'Street'))),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code_outline), labelText: 'Postal Code'))),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_3_outline), labelText: 'City'))),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(child: TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code_outline), labelText: 'State'))),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile_outline), labelText: 'Country')),
              const SizedBox(height: TSizes.defaultSpace),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
