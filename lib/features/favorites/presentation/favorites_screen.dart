import 'package:flutter/material.dart';
import 'package:tourist_guide_app/core/di/service_locator.dart';
import 'package:tourist_guide_app/core/theme/app_colors.dart';
import 'package:tourist_guide_app/core/widgets/centered_sliver.dart';
import 'package:tourist_guide_app/core/widgets/status_message.dart';
import 'package:tourist_guide_app/features/favorites/presentation/favorites_view_model.dart';
import 'package:tourist_guide_app/features/places/presentation/place_list_item.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _viewModel = FavoritesViewModel(getIt());

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (_, _) => CustomScrollView(
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 32, 20, 24),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Favorites',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              if (_viewModel.favorites.isEmpty)
                const CenteredSliver(
                  child: StatusMessage(
                    imagePath: 'assets/images/empty_favorites.png',
                    title: 'There are no favorites yet...',
                    message:
                        'Here you will see all your favorite sights. '
                        'Mark them as favorite by pressing the heart icon.',
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  sliver: SliverList.separated(
                    itemCount: _viewModel.favorites.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 20),
                    itemBuilder: (_, index) {
                      final place = _viewModel.favorites[index];
                      return PlaceListItem(
                        place: place,
                        listName: 'favorites',
                        isFavorite: true,
                        onFavoritePressed: () =>
                            _viewModel.removeFavorite(place),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
