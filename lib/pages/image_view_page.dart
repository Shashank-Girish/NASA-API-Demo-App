import 'package:api_example/data/image_model.dart';
import 'package:flutter/material.dart';

class ImageViewPage extends StatelessWidget {
  final ImageModel imageModel;
  const ImageViewPage({super.key, required this.imageModel});

  @override
  Widget build(BuildContext context) {
    String dateStr = (imageModel.date != null)
        ? "${imageModel.date!.year}-${imageModel.date!.month}-${imageModel.date!.day}"
        : 'Day';
    return Scaffold(
        appBar: AppBar(
          title: Text('NASA Image of the $dateStr'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Date: $dateStr",
                style:
                    const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ),
            Image.network(
              imageModel.hdurl ??
                  imageModel.url ??
                  'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                imageModel.title ?? 'No Title',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                imageModel.explanation ?? 'No Description',
                style: const TextStyle(fontSize: 16, fontFamily: 'Roboto'),
              ),
            ),
          ]),
        ));
  }
}
