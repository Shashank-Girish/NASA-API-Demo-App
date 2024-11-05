import 'package:api_example/data/image_model.dart';
import 'package:api_example/pages/image_view_page.dart';
import 'package:api_example/widgets/view_card.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<List<ImageModel>> _fetchImages() async {
    final startDate = DateTime.now().subtract(const Duration(days: 7));
    final endDate = DateTime.now();
    final imageRemoteData = ImageRemoteData();
    List<ImageModel> images =
        await imageRemoteData.fetchImages(startDate, endDate);
    List<ImageModel> filteredImages =
        images.where((image) => image.url != null).toList();
    return filteredImages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('NASA Images of the Week'),
        ),
        body: FutureBuilder(
          future: _fetchImages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(child: Text('No images found'));
            } else if (snapshot.hasData) {
              return PageView.builder(itemBuilder: (context, index) {
                return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageViewPage(
                                imageModel: snapshot.data![index]))),
                    child: carouselCard(snapshot.data![index], context));
              });
            } else {
              return const Center(child: Text('No data'));
            }
          },
        ));
  }
}
