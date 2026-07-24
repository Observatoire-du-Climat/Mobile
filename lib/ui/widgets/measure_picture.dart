import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Displays the picture associated with a measure.
///
/// While the image is loading, a loading message is displayed.
/// If no picture is available or the request fails, a fallback message is shown.
class MeasurePicture extends StatelessWidget {
  final int measureId;
  final double height;
  final apiUrl = dotenv.env['BASE_API_URL'];

  MeasurePicture({
    super.key,
    required this.measureId,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    final pictureUrl =
        '$apiUrl/measures/$measureId/picture';

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        pictureUrl,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Text('Chargement de la photo...');
        },
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            height: 100,
            child: const Center(
              child: Text('Aucune photo disponible'),
            ),
          );
        },
      ),
    );
  }
}