import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ImageScreen extends StatelessWidget {
  final String url;

  ImageScreen({
    Key key,
    @required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Expanded(
        child: CachedNetworkImage(
          imageUrl: '${this.url}',
          // Ajust the image changing the box fit attributte
          fit: BoxFit.cover,
          placeholder: (_, __) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: 15,
              ),
            );
          },
        ),
      ),
    );
  }
}
