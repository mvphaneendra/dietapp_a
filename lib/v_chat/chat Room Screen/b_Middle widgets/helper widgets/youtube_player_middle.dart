import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerMiddle extends StatelessWidget {
  final FoodsCollectionModel fdcm;
  const YoutubePlayerMiddle({Key? key, required this.fdcm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController ytc = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(fdcm.webURL!) ?? "kjiSVunIWpU",
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        hideThumbnail: true,
        enableCaption: false,
        disableDragSeek: false,
        startAt: 1,
        useHybridComposition: false,
      ),
    );

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: ytc,
        actionsPadding: const EdgeInsets.all(0.0),

        // showVideoProgressIndicator: true,
        bottomActions: [
          CurrentPosition(),
          RemainingDuration(),
          ProgressBar(
            isExpanded: true,
            colors: const ProgressBarColors(
              bufferedColor: Colors.transparent,
              playedColor: Colors.red,
              handleColor: Colors.red,
              backgroundColor: Colors.white,
            ),
          ),
          FullScreenButton(),
        ],
        showVideoProgressIndicator: true,
        progressColors: const ProgressBarColors(
          bufferedColor: Colors.transparent,
          playedColor: Colors.red,
          backgroundColor: Colors.white70,
        ),
        onReady: () {},
      ),
      builder: (context, player) {
        return SafeArea(
          child: Scaffold(
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              player,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(fdcm.fieldName),
              ),
              Row(
                children: [
                  IconButton(onPressed: null, icon: Icon(MdiIcons.share)),
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}
