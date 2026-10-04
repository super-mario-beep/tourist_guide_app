import 'package:flutter/material.dart';
import 'package:tourist_guide_app/theme/app_colors.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    super.key,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.rating,
    this.imageUrl,
    this.isFavorite = false,
    this.onFavoritePressed,
    this.onTap,
  });

  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final int rating;
  final String? imageUrl;
  final bool isFavorite;
  final VoidCallback? onFavoritePressed;
  final VoidCallback? onTap;

  static const _height = 132.0;
  static const _padding = 14.0;
  static const _radius = BorderRadius.all(Radius.circular(20));
  static const _imageRadius = BorderRadius.all(Radius.circular(15));
  static const _placeholderColor = Color(0xFFD9D9D9);
  static const _starColor = Color(0xFFFFD600);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: _radius,
        gradient: LinearGradient(
          begin: Alignment(-0.96, 0.93),
          end: Alignment(0.94, -0.89),
          colors: [AppColors.primary, AppColors.secondary],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x405881A6),
            offset: Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: _radius,
          child: SizedBox(
            height: _height,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(_padding),
                  child: Row(
                    children: [
                      _buildImage(),
                      const SizedBox(width: 19),
                      Expanded(child: _buildDetails()),
                    ],
                  ),
                ),
                Positioned(
                  top: _padding,
                  right: 20,
                  child: InkResponse(
                    onTap: onFavoritePressed,
                    radius: 20,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    const placeholder = ColoredBox(color: _placeholderColor);

    return ClipRRect(
      borderRadius: _imageRadius,
      child: SizedBox(
        width: 135,
        height: _height - _padding * 2,
        child: imageUrl == null
            ? placeholder
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) =>
                    progress == null ? child : placeholder,
                errorBuilder: (_, _, _) => const ColoredBox(
                  color: _placeholderColor,
                  child: Image(
                    image: AssetImage('assets/images/error_image.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          // Keeps the name clear of the favorite icon.
          padding: const EdgeInsets.only(right: 40),
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          address,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$latitude, $longitude',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
        const Spacer(),
        _buildRating(),
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(
            Icons.star,
            size: 28,
            color: index < rating ? _starColor : _placeholderColor,
          ),
        );
      }),
    );
  }
}
