import 'package:cached_network_image/cached_network_image.dart';
import 'package:dietapp_a/my%20foods/screens/Add%20food/add_food_sreen.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/web_page_middle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebFoodMiddle extends StatelessWidget {
  final FoodsCollectionModel fdcm;

  final String? text;
  const WebFoodMiddle({Key? key, required this.fdcm, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: MediaQuery.of(context).size.width * 7.5 / 10,
        color: Colors.green.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              color: Colors.black87,
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (fdcm.imgURL != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl: fdcm.imgURL!,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(fdcm.fieldName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  if (fdcm.webURL != null)
                    Get.to(() => WebPageMiddle(
                        webURL: fdcm.webURL!, title: fdcm.fieldName));
                },
              ),
            ),
            if (text != null && text != "")
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text!),
              ),
          ],
        ),
      ),
    );
  }
}
