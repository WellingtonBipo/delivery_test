import 'dart:async';

import 'package:delivery_test/controllers/product_details/product_details_controller.dart';
import 'package:delivery_test/controllers/special_offers/special_offers_controller.dart';
import 'package:delivery_test/core/extensions/string_extension.dart';
import 'package:delivery_test/core/utils/controller_state.dart';
import 'package:delivery_test/models/product_details.dart';
import 'package:design_system/atoms/shimmer/ds_shimmer.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final body = Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            color: DSTheme.of(context).colors.brandPrimary,
            onRefresh: () async {
              final controller = ProductDetailsController.read(context);
              final product = controller.productToLoad;
              if (product == null) return;
              unawaited(controller.loadDetails(product));
            },
            child: const CustomScrollView(
              slivers: [
                _CarouselImages(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        _Header(),
                        _Tags(),
                        _Details(),
                        _Comments(),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                _Error(),
              ],
            ),
          ),
        ),
        const _AddCartBox(),
      ],
    );

    return Builder(
      builder: (context) {
        final specialOffersController = SpecialOffersController.watch(context);
        final productsState = ProductDetailsController.watch(context).state;
        final productId = productsState.data?.id;
        return Scaffold(
          appBar: DSAppBarPage(
            rightIcon: productId == null
                ? null
                : DSAppBarIconButton(
                    icon: specialOffersController.productsFavoritesIds
                            .contains(productId)
                        ? DSIconAssets.heartFilled
                        : DSIconAssets.heartEmpty,
                    onTap: () {
                      specialOffersController.toggleFavorite(productId);
                    },
                  ),
          ),
          body: body,
        );
      },
    );
  }
}

class _CarouselImages extends StatelessWidget {
  const _CarouselImages();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxHeight = screenWidth * 0.78;
    return SliverResizingHeader(
      minExtentPrototype: SizedBox(height: maxHeight / 2),
      maxExtentPrototype: SizedBox(height: maxHeight),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final controller = ProductDetailsController.watch(context);
          final product = controller.productToLoad;
          final imageUrl = product?.imageUrl;
          final state = controller.state;
          final children = switch (state) {
            ControllerStateInitial() ||
            ControllerStateLoading() ||
            ControllerStateError() =>
              [
                if (product == null || imageUrl == null)
                  DSShimmer(child: SizedBox(height: maxHeight))
                else
                  Hero(
                    tag: 'product-${product.id}',
                    child: Image.network(imageUrl),
                  ),
              ],
            ControllerStateSuccess() => [
                for (var i = 0; i < state.data.imagesUrl.length; i++)
                  if (i == 0)
                    Hero(
                      tag: 'product-${state.data.id}',
                      child: Image.network(state.data.imagesUrl[i]),
                    )
                  else
                    Image.network(state.data.imagesUrl[i]),
              ],
          };
          return Container(
            padding: const EdgeInsets.only(bottom: 15),
            color: DSTheme.of(context).colors.scaffoldBackground,
            child: DSCarousel(
              height: constraints.maxHeight - 15,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: children,
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  static const loadingTextName = 'Product Name';
  static const loadingTextShop = 'Shop: Some Shop';

  @override
  Widget build(BuildContext context) {
    final state = ProductDetailsController.watch(context).state;
    String name;
    String shop;
    var rate = 0.0;
    switch (state) {
      case ControllerStateInitial():
      case ControllerStateLoading():
        name = loadingTextName;
        shop = loadingTextShop;
        break;
      case ControllerStateError():
        return const SizedBox.shrink();
      case ControllerStateSuccess():
        name = state.data.name;
        shop = 'Shop: ${state.data.shop}';
        rate = state.data.rate;
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DSText(
                name,
                isLoading: name == loadingTextName,
                typography: const DSTextTypography.header2(),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: DSTheme.of(context).colors.contentPrimary,
                ),
              ),
              child: DSRate(
                rate: rate,
                isLoading: state is ControllerStateLoading,
                typography: const DSTextTypography.header4(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        DSText(
          shop,
          isLoading: shop == loadingTextShop,
        ),
      ],
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags();

  @override
  Widget build(BuildContext context) {
    final state = ProductDetailsController.watch(context).state;
    List<ProductTag?> tags;
    switch (state) {
      case ControllerStateInitial():
      case ControllerStateLoading():
        tags = [null];
        break;
      case ControllerStateError():
        return const SizedBox.shrink();
      case ControllerStateSuccess():
        tags = state.data.tags;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: DSTheme.of(context).colors.contentPrimary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tags
            .map(
              (tag) => Container(
                height: 65,
                width: 65,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tag?.colorHex.toColorFromHex(),
                ),
                child: tag == null
                    ? null
                    : Image.network(
                        tag.imageUrl,
                        color:
                            DSTheme.of(context).colors.textPrimaryAlwaysLight,
                      ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details();

  static const loadingText = 'Some details.\nMode details.';

  @override
  Widget build(BuildContext context) {
    final state = ProductDetailsController.watch(context).state;
    final String details;
    switch (state) {
      case ControllerStateError():
        return const SizedBox.shrink();
      case ControllerStateInitial() || ControllerStateLoading():
        details = loadingText;
        break;
      case ControllerStateSuccess():
        details = state.data.details;
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const DSText(
          'Details',
          typography: DSTextTypography.header3(),
        ),
        const SizedBox(height: 10),
        DSText(
          details,
          isLoading: details == loadingText,
          typography: const DSTextTypography.bodyBold(),
        ),
      ],
    );
  }
}

class _Comments extends StatelessWidget {
  const _Comments();

  @override
  Widget build(BuildContext context) {
    final state = ProductDetailsController.watch(context).state;
    if (state is ControllerStateError) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const DSText(
          'Comments',
          typography: DSTextTypography.header3(),
        ),
        const SizedBox(height: 10),
        ..._fakeComments
            .map(
              (comment) => [
                DSShimmer(
                  enabled: state is ControllerStateLoading,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: DSTheme.of(context).colors.contentPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DSText(
                              comment.name,
                              typography: const DSTextTypography.header4(),
                            ),
                            const SizedBox(width: 10),
                            DSRate(
                              rate: comment.rate,
                              typography: const DSTextTypography.header5(),
                            ),
                          ],
                        ),
                        DSText(
                          comment.comment,
                          typography: const DSTextTypography.body(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            )
            .expand((e) => e)
            .toList(),
      ],
    );
  }
}

class _AddCartBox extends StatelessWidget {
  const _AddCartBox();

  static const loadingTextPrice = r'$0.00';
  static const loadingTextOldPrice = r'$0.00';

  @override
  Widget build(BuildContext context) {
    final state = ProductDetailsController.watch(context).state;
    String price;
    String oldPrice;
    switch (state) {
      case ControllerStateInitial():
      case ControllerStateLoading():
        price = loadingTextPrice;
        oldPrice = loadingTextOldPrice;
        break;
      case ControllerStateError():
        price = '-';
        oldPrice = '';
        break;
      case ControllerStateSuccess():
        price = '\$${state.data.price.toStringAsFixed(2)}';
        oldPrice = '\$${state.data.oldPrice.toStringAsFixed(2)}';
        break;
    }
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(20).copyWith(bottom: 0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: DSTheme.of(context).colors.contentPrimary,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DSText(
                    'Price',
                    color: DSTheme.of(context).colors.contentSecondary,
                    typography: const DSTextTypography.bodyBold(),
                  ),
                  Row(
                    children: [
                      DSText(
                        price,
                        isLoading: price == loadingTextPrice,
                        typography: const DSTextTypography.header1(),
                      ),
                      const SizedBox(width: 10),
                      DSText(
                        oldPrice,
                        isLoading: oldPrice == loadingTextOldPrice,
                        typography: const DSTextTypography.header3(),
                        color: DSTheme.of(context).colors.textSecondary,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: DSInkWellContainer(
                onTap: () => print('Add to cart'),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: DSTheme.of(context).colors.brandPrimary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Align(
                  child: DSText(
                    'Add to Cart',
                    color: DSTheme.of(context).colors.textPrimaryAlwaysLight,
                    typography: const DSTextTypography.header4(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) {
    final state = ProductDetailsController.watch(context).state;
    if (state is ControllerStateError) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: DSTheme.of(context).colors.textPrimary,
                size: 50,
              ),
              const SizedBox(height: 15),
              const DSText(
                'Error on loading product infos',
                typography: DSTextTypography.header2(),
              ),
            ],
          ),
        ),
      );
    }
    return const SliverToBoxAdapter();
  }
}

final _fakeComments = [
  (
    name: 'John',
    rate: 4.0,
    comment: 'Very good',
  ),
  (
    name: 'Alice',
    rate: 5.0,
    comment: 'Excellent product!',
  ),
  (
    name: 'Bob',
    rate: 3.5,
    comment: 'Average quality.',
  ),
  (
    name: 'Eve',
    rate: 4.5,
    comment: 'Great value for the price.',
  ),
];
