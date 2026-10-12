import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tourist_guide_app/core/di/service_locator.dart';
import 'package:tourist_guide_app/core/theme/app_colors.dart';
import 'package:tourist_guide_app/core/widgets/primary_button.dart';
import 'package:tourist_guide_app/core/widgets/snack_bar.dart';
import 'package:tourist_guide_app/core/widgets/status_message.dart';
import 'package:tourist_guide_app/core/widgets/top_bar.dart';
import 'package:tourist_guide_app/features/places/domain/place.dart';
import 'package:tourist_guide_app/features/places/presentation/place_details_view_model.dart';

class PlaceDetailsScreen extends StatefulWidget {
  const PlaceDetailsScreen({
    super.key,
    required this.placeId,
    required this.heroTag,
  });

  final int placeId;

  final String heroTag;

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  static const _sheetOverlap = 24.0;
  static const _buttonSize = 44.0;

  late final _viewModel = PlaceDetailsViewModel(
    widget.placeId,
    getIt(),
    getIt(),
    getIt(),
  );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _openInMaps() async {
    final opened = await _viewModel.openInMaps();
    if (!opened && mounted) context.showSnackBar('Could not open maps.');
  }

  @override
  Widget build(BuildContext context) {
    final place = _viewModel.place;
    if (place == null) {
      return const Scaffold(
        appBar: TopBar(title: ''),
        body: Center(
          child: StatusMessage(
            imagePath: 'assets/images/error_image.png',
            title: 'Place not found.',
            message: 'Go back and refresh the list of places.',
          ),
        ),
      );
    }

    final imageHeight = MediaQuery.sizeOf(context).height * 0.4;
    final topInset = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Hero(
                      tag: widget.heroTag,
                      child: SizedBox(
                        height: imageHeight,
                        width: double.infinity,
                        child: _PlaceImage(url: place.imageUrl),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: imageHeight - _sheetOverlap,
                      ),
                      child: _DetailsSheet(place: place),
                    ),
                    Positioned(
                      top: topInset + 12,
                      left: 20,
                      child: _RoundButton(
                        icon: Icons.arrow_back_ios_new,
                        iconSize: 20,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Positioned(
                      top: imageHeight - _sheetOverlap - _buttonSize / 2,
                      right: 24,
                      child: ListenableBuilder(
                        listenable: _viewModel,
                        builder: (_, _) => _RoundButton(
                          icon: _viewModel.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          onPressed: _viewModel.toggleFavorite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              top: false,
              minimum: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: PrimaryButton(
                label: 'Show on maps',
                onPressed: _openInMaps,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsSheet extends StatelessWidget {
  const _DetailsSheet({required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place.name,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            place.address,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Rating',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                size: 26,
                color: index < place.rating
                    ? AppColors.secondary
                    : const Color(0xFFD9D9D9),
              );
            }),
          ),
          const SizedBox(height: 20),
          Text(
            place.description,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceImage extends StatelessWidget {
  const _PlaceImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    const placeholder = ColoredBox(color: Color(0xFFD9D9D9));
    if (url.isEmpty) return placeholder;

    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (_, child, progress) =>
          progress == null ? child : placeholder,
      errorBuilder: (_, _, _) => placeholder,
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.onPressed,
    this.iconSize = 24,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [AppColors.primary, AppColors.secondary],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkResponse(
          onTap: onPressed,
          radius: _PlaceDetailsScreenState._buttonSize / 2,
          child: SizedBox.square(
            dimension: _PlaceDetailsScreenState._buttonSize,
            child: Icon(icon, color: Colors.white, size: iconSize),
          ),
        ),
      ),
    );
  }
}
