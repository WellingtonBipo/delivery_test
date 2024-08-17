import 'package:delivery_test/controllers/categories/categories_controller.dart';
import 'package:delivery_test/controllers/product_details/product_details_controller.dart';
import 'package:delivery_test/controllers/special_offers/special_offers_controller.dart';
import 'package:delivery_test/controllers/top_offers/top_offers_controller.dart';
import 'package:delivery_test/core/extensions/int_extension.dart';
import 'package:delivery_test/core/extensions/string_extension.dart';
import 'package:delivery_test/core/utils/controller_state.dart';
import 'package:delivery_test/views/app_routes.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static const padding = 16.0;
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late String _selectedCity = _cities.first;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadInfos());
  }

  void _loadInfos() {
    TopOffersController.read(context).getOffers();
    CategoriesController.read(context).getCategories();
    SpecialOffersController.read(context).getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSAppBarHome(
        title: 'Delivery',
        location: _selectedCity,
        onTapLocation: _onTapLocation,
        onTapProfile: () => print('Profile'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _loadInfos(),
        color: DSTheme.of(context).colors.brandPrimary,
        child: ListView(
          padding: EdgeInsets.only(
            top: HomePage.padding,
            bottom: HomePage.padding + DSBottonNavigator.overflowHeight(),
          ),
          children: [
            const _OrderCards(),
            const SizedBox(height: 20),
            const _Carousel(),
            const SizedBox(height: 25),
            const _Title(title: 'Shop by category'),
            const SizedBox(height: 10),
            const _CategoryList(),
            const SizedBox(height: 25),
            _Title(
              title: "Today's Special",
              trailingText: 'See all',
              onTapTrailing: () => print('See all'),
            ),
            const SizedBox(height: 10),
            const _Products(),
          ],
        ),
      ),
      bottomNavigationBar: DSBottonNavigator(
        currentIndex: _currentIndex,
        onChange: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Future<void> _onTapLocation() async {
    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fill,
      color: DSTheme.of(context).colors.contentPrimary,
      initialValue: _selectedCity,
      items: [
        for (final city in _cities)
          PopupMenuItem<String>(
            value: city,
            child: DSText(city),
          ),
      ],
    );
    if (result == null) return;
    setState(() => _selectedCity = result);
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
    this.trailingText,
    this.onTapTrailing,
  });

  final String title;
  final String? trailingText;
  final void Function()? onTapTrailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HomePage.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DSText(
            title,
            typography: const DSTextTypography.header3(),
          ),
          if (trailingText != null)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTapTrailing,
              child: DSText(
                trailingText!,
                typography: const DSTextTypography.header5(),
                color: DSTheme.of(context).colors.brandPrimary,
              ),
            ),
        ],
      ),
    );
  }
}

class _OrderCards extends StatelessWidget {
  const _OrderCards();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HomePage.padding),
      child: Row(
        children: [
          Expanded(
            child: DSCardOrder(
              type: DSCardOrderType.orderAgain,
              onTap: () => print('Order again'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: DSCardOrder(
              type: DSCardOrderType.localShop,
              onTap: () => print('Local shop'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Carousel extends StatelessWidget {
  const _Carousel();

  @override
  Widget build(BuildContext context) {
    final state = TopOffersController.watch(context).state;
    final children = switch (state) {
      ControllerStateInitial() || ControllerStateLoading() => [
          const DSCardTopDeal.loading(),
        ],
      ControllerStateError() => [const DSCardTopDeal.error()],
      ControllerStateSuccess() => state.data.map((offer) {
          return DSCardTopDeal(
            header: offer.header,
            title: offer.title,
            buttonText: offer.buttonText,
            imageUrl: offer.imageUrl,
            colorBackground: offer.colorHex.toColorFromHex(),
            onTapButton: () => print(offer.buttonText),
          );
        }).toList(),
    };
    return DSCarousel(
      padding: const EdgeInsets.symmetric(horizontal: HomePage.padding),
      onTap: state is! ControllerStateSuccess
          ? null
          : (i) => print(state.data?[i].buttonText),
      children: children,
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList();

  @override
  Widget build(BuildContext context) {
    final state = CategoriesController.watch(context).state;
    final children = switch (state) {
      ControllerStateInitial() || ControllerStateLoading() => 10.generate(
          (_) => const DSCardCategory.loading(),
        ),
      ControllerStateError() => 10.generate(
          (_) => const DSCardCategory.error(),
        ),
      ControllerStateSuccess() => state.data.map(
          (category) => DSCardCategory(
            text: category.text,
            imageUrl: category.imageUrl,
            onTap: () => print(category.text),
          ),
        ),
    };
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: HomePage.padding),
      child: Row(
        children: children
            .map((e) => [e, const SizedBox(width: 10)])
            .expand((e) => e)
            .toList()
          ..removeLast(),
      ),
    );
  }
}

class _Products extends StatelessWidget {
  const _Products();

  @override
  Widget build(BuildContext context) {
    final controller = SpecialOffersController.watch(context);
    final state = controller.state;
    final children = switch (state) {
      ControllerStateError() => 2.generate((_) => const DSCardProduct.error()),
      ControllerStateInitial() ||
      ControllerStateLoading() =>
        2.generate((_) => const DSCardProduct.loading()),
      ControllerStateSuccess() => state.data.map((product) {
          return DSCardProduct(
            heroTag: 'product-${product.id}',
            text: product.name,
            rate: product.rate,
            imageUrl: product.imageUrl,
            color: product.colorHex.toColorFromHex(),
            isFavorite: controller.productsFavoritesIds.contains(product.id),
            onTap: () {
              ProductDetailsController.read(context).loadDetails(product);
              Navigator.of(context).pushNamed(AppRoutes.productDetails);
            },
            onTapFavorite: () => controller.toggleFavorite(product.id),
          );
        }).toList(),
    };
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: HomePage.padding),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: children,
    );
  }
}

const _cities = [
  'Bacangan, Sambit',
  'New York, NY',
  'São Paulo, SP',
  'London, UK',
];
