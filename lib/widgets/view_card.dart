import 'package:api_example/data/image_model.dart';
import 'package:flutter/material.dart';

Widget carouselCard(ImageModel imageModel, BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          // Background image with loading indicator
          Image.network(
            imageModel.url ?? 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.error, color: Colors.red),
              );
            },
          ),
          // Overlay for text content
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  imageModel.title ?? 'No Title',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  imageModel.explanation ?? 'No Description',
                  style: const TextStyle(
                      fontSize: 18, fontFamily: 'Roboto', color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}