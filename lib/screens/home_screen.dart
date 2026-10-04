import 'package:flutter/material.dart';
import 'package:tourist_guide_app/theme/app_colors.dart';
import 'package:tourist_guide_app/widgets/place_card.dart';

// Temporary mock data until the sights API is connected.
const _places = [
  (
    name: 'Gornji grad',
    address: '10 000, Zagreb',
    latitude: 45.8147052,
    longitude: 15.9733762,
    rating: 3,
    imageUrl: 'https://picsum.photos/id/1031/400/300',
  ),
  (
    name: 'Kaptol',
    address: '10 000, Zagreb',
    latitude: 45.8186541,
    longitude: 15.976547,
    rating: 2,
    imageUrl: 'https://picsum.photos/id/1040/400/300',
  ),
  (
    name: 'Park Ribnjak',
    address: '10 000, Zagreb',
    latitude: 45.8194249,
    longitude: 15.9831026,
    rating: 4,
    imageUrl: 'https://picsum.photos/id/1043/400/300',
  ),
  (
    name: 'Park Zrinjevac',
    address: '10 000, Zagreb',
    latitude: 45.8105029,
    longitude: 15.9789437,
    rating: 4,
    imageUrl: 'https://picsum.photos/id/1047/400/300',
  ),
  (
    name: 'Park Opatovina',
    address: '10 000, Zagreb',
    latitude: 45.8164213,
    longitude: 15.9761842,
    rating: 3,
    imageUrl: 'https://picsum.photos/id/1067/400/300',
  ),
  (
    name: 'Park Maksimir',
    address: '10 000, Zagreb',
    latitude: 45.8269518,
    longitude: 16.0187254,
    rating: 5,
    imageUrl: 'https://picsum.photos/id/1018/400/300',
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _favoriteIndexes = <int>{0, 2, 3};

  void _toggleFavorite(int index) {
    setState(() {
      if (!_favoriteIndexes.remove(index)) _favoriteIndexes.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 32, 20, 24),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Places',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              sliver: SliverList.separated(
                itemCount: _places.length,
                separatorBuilder: (_, _) => const SizedBox(height: 20),
                itemBuilder: (_, index) {
                  final place = _places[index];
                  return PlaceCard(
                    name: place.name,
                    address: place.address,
                    latitude: place.latitude,
                    longitude: place.longitude,
                    rating: place.rating,
                    imageUrl: place.imageUrl,
                    isFavorite: _favoriteIndexes.contains(index),
                    onFavoritePressed: () => _toggleFavorite(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
