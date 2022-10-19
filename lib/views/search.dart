import 'package:flutter/material.dart';

import '../model/photo_model.dart';
import '../services/remote_services.dart';
import '../widgets/grid_view_widget.dart';

class Search extends StatefulWidget {
  const Search({Key? key, required this.searchQuery}) : super(key: key);
  final String searchQuery;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoaded = false;
  late PhotoModel photoModel;
  List<Photo> photos = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    getImages();
    super.initState();
  }

  getImages() async {
    photoModel = (await RemoteServces().getPhotosByQuery(widget.searchQuery))!;
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
        centerTitle: true,
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
                hintText: widget.searchQuery,
                filled: true,
                fillColor: Colors.blueGrey[100],
                suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                        Navigator.pushReplacement(
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
          )
        ],
      ),
    );
  }
}
