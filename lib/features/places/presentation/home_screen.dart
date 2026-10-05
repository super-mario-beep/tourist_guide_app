import 'package:flutter/material.dart';
import 'package:tourist_guide_app/core/di/service_locator.dart';
import 'package:tourist_guide_app/core/theme/app_colors.dart';
import 'package:tourist_guide_app/core/widgets/loading_indicator.dart';
import 'package:tourist_guide_app/core/widgets/place_card.dart';
import 'package:tourist_guide_app/core/widgets/status_message.dart';
import 'package:tourist_guide_app/features/places/presentation/home_view_model.dart';
import 'package:tourist_guide_app/features/places/presentation/place_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _viewModel = HomeViewModel(getIt(), getIt());

  @override
  void initState() {
    super.initState();
    _viewModel.loadPlaces();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _openDetails(int placeId) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PlaceDetailsScreen(placeId: placeId)),
    );
    // The heart may have been toggled on the details screen.
    _viewModel.refreshFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => _viewModel.loadPlaces(showLoading: false),
          child: ListenableBuilder(
            listenable: _viewModel,
            builder: (_, _) => CustomScrollView(
              // Lets pull-to-refresh work even when the content is short.
              physics: const AlwaysScrollableScrollPhysics(),
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
                _buildContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return switch (_viewModel.status) {
      HomeStatus.loading => const _CenteredSliver(child: LoadingIndicator()),
      HomeStatus.error => const _CenteredSliver(
        child: StatusMessage(
          imagePath: 'assets/images/error_image.png',
          title: 'There was an error.',
          message: 'Please try again later or check your internet connection.',
        ),
      ),
      HomeStatus.empty => const _CenteredSliver(
        child: StatusMessage(
          imagePath: 'assets/images/no_locations_found.png',
          title: 'No places found.',
          message: 'Try to refresh the screen or check later.',
        ),
      ),
      HomeStatus.success => SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        sliver: SliverList.separated(
          itemCount: _viewModel.places.length,
          separatorBuilder: (_, _) => const SizedBox(height: 20),
          itemBuilder: (_, index) {
            final place = _viewModel.places[index];
            return PlaceCard(
              name: place.name,
              address: place.address,
              latitude: place.latitude,
              longitude: place.longitude,
              rating: place.rating,
              imageUrl: place.imageUrl,
              isFavorite: _viewModel.isFavorite(place),
              onFavoritePressed: () => _viewModel.toggleFavorite(place),
              heroTag: placeImageHeroTag(place.id),
              onTap: () => _openDetails(place.id),
            );
          },
        ),
      ),
    };
  }
}

class _CenteredSliver extends StatelessWidget {
  const _CenteredSliver({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        // Lifts the content slightly above the true center, like the design.
        padding: const EdgeInsets.only(bottom: 60),
        child: Center(child: child),
      ),
    );
  }
}
