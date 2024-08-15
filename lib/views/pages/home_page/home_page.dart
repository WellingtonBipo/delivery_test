import 'package:delivery_test/controllers/categories/categories_controller.dart';
import 'package:delivery_test/controllers/special_offers/special_offers_controller.dart';
import 'package:delivery_test/controllers/top_offers/top_offers_controller.dart';
import 'package:delivery_test/models/category_model.dart';
import 'package:delivery_test/models/special_offer_model.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSAppBarHome(
        title: 'Delivery',
        location: _selectedCity,
        onTapLocation: _onTapLocation,
        onTapProfile: () => print('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: HomePage.padding,
          bottom: HomePage.padding + DSBottonNavigator.overflowHeight(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            typography: const DSTextTypography.header2(),
          ),
          if (trailingText != null)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTapTrailing,
              child: DSText(
                trailingText!,
                typography: const DSTextTypography.header4(),
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
    return FutureBuilder(
      future: TopOffersController().getTopOffers(),
      builder: (context, snapshot) {
        final offers = snapshot.data;
        return DSCarousel(
          padding: const EdgeInsets.symmetric(horizontal: HomePage.padding),
          children: [
            if (offers == null)
              const DSCardTopDeal.loading()
            else
              for (final offer in offers)
                DSCardTopDeal(
                  header: offer.header,
                  title: offer.title,
                  buttonText: offer.buttonText,
                  onTapButton: () => print(offer.buttonText),
                  imageUrl: offer.imageUrl,
                  colorBackground: fromHex(offer.colorHex),
                ),
          ],
        );
      },
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CategoriesController().getCategories(),
      builder: (context, snapshot) {
        final categories = snapshot.data ??
            <CategoryModel?>[...List.generate(10, (_) => null)];
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: HomePage.padding),
          child: Row(
            children: [
              for (final category in categories) ...[
                if (category == null)
                  const DSCardCategory.loading()
                else
                  DSCardCategory(
                    text: category.text,
                    imageUrl: category.imageUrl,
                    onTap: () => print(category),
                  ),
                const SizedBox(width: 10),
              ],
            ]..removeLast(),
          ),
        );
      },
    );
  }
}

class _Products extends StatelessWidget {
  const _Products();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SpecialOffersController().getSpecialOffers(),
      builder: (context, snapshot) {
        final offers = snapshot.data ??
            <SpecialOfferModel?>[...List.generate(10, (_) => null)];

        return GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: HomePage.padding),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            for (final offer in offers)
              if (offer == null)
                const DSCardProduct.loading()
              else
                DSCardProduct(
                  text: offer.text,
                  rate: offer.rate,
                  imageUrl: offer.imageUrl,
                  color: fromHex(offer.colorHex),
                  onTap: () => print(offer.text),
                ),
          ],
        );
      },
    );
  }
}

const _cities = [
  'New York, NY',
  'São Paulo, SP',
  'London, UK',
];

const _products = [
  'Lime Orange',
  'Organic Fresh Green Cabbage',
  'Organic Fresh Green Cabbage',
  'Organic Fresh Green Cabbage',
  'Organic Fresh Green Cabbage',
  'Organic Fresh Green Cabbage',
];

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
