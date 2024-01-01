import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.bannerUri,
  });

  final String bannerUri;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 8,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          bannerUri,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (_,__,___) => Container(),
        ),
      ),
    );
  }
}
