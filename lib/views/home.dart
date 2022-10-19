import 'package:flutter/material.dart';
import 'package:images_app/model/photo_model.dart';
import 'package:images_app/services/remote_services.dart';
import 'package:images_app/views/search.dart';

import '../widgets/grid_view_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textEditingController = TextEditingController();
  bool isLoaded = false;
  late PhotoModel photoModel;
  List<Photo> photos = [];
  @override
  void initState() {
    getTrendingImages();
    super.initState();
  }

  getTrendingImages() async {
    photoModel = (await RemoteServces().getTrendingPhotos())!;
    photos = photoModel.photos;
    if (photos.isNotEmpty) {
      setState(() {
        isLoaded = true;
      });
    } else {
      print("errro");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Images App"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none),
                hintText: 'Search',
                filled: true,
                fillColor: Colors.blueGrey[100],
                suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Search(
                                  searchQuery: textEditingController.text),
                            ));
                      }
                    },
                    icon: const Icon(Icons.search, size: 30)),
              ),
            ),
          ),
          Expanded(
            child: Visibility(
              visible: isLoaded,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: GridViewWidget(photos: photos),
            ),
          ),
        ],
      ),
    );
  }
}
