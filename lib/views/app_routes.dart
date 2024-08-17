import 'package:delivery_test/views/pages/home_page/home_page.dart';
import 'package:delivery_test/views/pages/product_details/product_details_page.dart';
import 'package:flutter/material.dart';

sealed class AppRoutes {
  static const String home = '/';
  static const String productDetails = '/product-details';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      home => MaterialPageRoute(builder: (context) => const HomePage()),
      productDetails =>
        MaterialPageRoute(builder: (context) => const ProductDetailsPage()),
      _ => MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Unknown route')),
            body: Center(child: Text('Not found route => "${settings.name}"')),
          ),
        ),
    };
  }
}
