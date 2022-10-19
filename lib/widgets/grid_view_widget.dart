import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:images_app/views/image_view.dart';
import '../model/photo_model.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    Key? key,
    required this.photos,
  }) : super(key: key);

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
        semanticChildCount: photos.length,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        gridDelegate: SliverWovenGridDelegate.count(pattern: const [
          WovenGridTile(.6),
          WovenGridTile(
            .7,
            crossAxisRatio: 1,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ], crossAxisSpacing: 8, crossAxisCount: 2),
        childrenDelegate:
            SliverChildBuilderDelegate(childCount: photos.length, (ctx, i) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ImageView(imgPath: photos[i].src.portrait)));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.grey,
                child: Hero(
                  tag: photos[i].src.portrait,
                  child: Image.network(
                    photos[i].src.portrait,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
