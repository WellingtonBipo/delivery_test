// ignore_for_file: sort_child_properties_last

import 'package:delivery_test/controllers/categories/categories_controller.dart';
import 'package:delivery_test/controllers/product_details/product_details_controller.dart';
import 'package:delivery_test/controllers/special_offers/special_offers_controller.dart';
import 'package:delivery_test/controllers/top_offers/top_offers_controller.dart';
import 'package:delivery_test/core/back_end_connector/back_end_connector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  AppProviders({
    required this.child,
    super.key,
  });

  final Widget child;

  final _backEndConnector = BackEndConnector();

  @override
  Widget build(BuildContext context) => MultiProvider(
        child: child,
        providers: [
          ChangeNotifierProvider(
            create: (_) => TopOffersController(_backEndConnector),
          ),
          ChangeNotifierProvider(
            create: (_) => CategoriesController(_backEndConnector),
          ),
          ChangeNotifierProvider(
            create: (_) => SpecialOffersController(_backEndConnector),
          ),
          ChangeNotifierProvider(
            create: (_) => ProductDetailsController(_backEndConnector),
          ),
        ],
      );
}
