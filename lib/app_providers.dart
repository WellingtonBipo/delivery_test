import 'package:delivery_test/controllers/categories/categories_controller.dart';
import 'package:delivery_test/controllers/special_offers/special_offers_controller.dart';
import 'package:delivery_test/controllers/top_offers/top_offers_controller.dart';
import 'package:delivery_test/core/back_end_connector/back_end_connector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProviders extends MultiProvider {
  AppProviders({
    required Widget super.child,
    super.key,
  }) : super(
          providers: [
            ChangeNotifierProvider(
              create: (_) => TopOffersController(
                backEndConnector: _backEndConnector,
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => CategoriesController(
                backEndConnector: _backEndConnector,
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => SpecialOffersController(
                backEndConnector: _backEndConnector,
              ),
            ),
          ],
        );

  static final _backEndConnector = BackEndConnector();
}
