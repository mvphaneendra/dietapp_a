import 'package:dietapp_a/app%20Constants/url/url_avatar.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/controllers/fc_controller.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/objects/foods_collection_strings.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/folder_view_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/web_page_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/youtube_player_middle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MultiFoodsCollectionMiddle extends StatelessWidget {
  final List<FoodsCollectionModel> listFDCM;
  final String? text;
  const MultiFoodsCollectionMiddle({
    Key? key,
    required this.listFDCM,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTopWidgetMiddle(
        text: text,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blueGrey.shade900,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: listFDCM.length,
                itemBuilder: (context, index) {
                  FoodsCollectionModel fdcm = listFDCM[index];

                  if (fdcm.isFolder) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        child: Row(
                          children: [
                            const Icon(MdiIcons.folderOutline,
                                color: Colors.white),
                            const SizedBox(width: 10),
                            Text(fdcm.fieldName,
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        onTap: () {
                          if (fdcm.docRef != null) {
                            fcc.pathsListMaps.value.clear();
                            fcc.currentPathCR.value = fdcm.docRef!
                                .collection(fdcs.subCollections)
                                .path;
                            Get.to(() => FolderViewMiddle(
                                  folderName: fdcm.fieldName,
                                  homePath: fcc.currentPathCR.value,
                                ));
                          }
                        },
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          child: Row(
                            children: [
                              URLavatar(
                                  imgURL: fdcm.rumm?.img,
                                  webURL: fdcm.rumm?.url),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  fdcm.fieldName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            if (fdcm.rumm?.isYoutubeVideo ?? false) {
                              Get.to(() => YoutubePlayerMiddle(
                                  webURL: fdcm.rumm!.url,
                                  title: fdcm.fieldName));
                            } else if (fdcm.rumm != null) {
                              Get.to(() => WebPageMiddle(
                                  webURL: fdcm.rumm!.url,
                                  title: fdcm.fieldName));
                            }
                          }),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
