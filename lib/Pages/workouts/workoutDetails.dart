import 'package:fitapp/controllers/workout_controller.dart';
import 'package:fitapp/models/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../utils/theme_colors.dart';

class WorkoutDetail extends StatefulWidget{

  final int index;

  const WorkoutDetail({Key? key, required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WorkoutDetail();

}

class _WorkoutDetail extends State<WorkoutDetail>{
  late Workout _workout;
  final WorkoutController _workoutController = Get.find();
  late YoutubePlayerController _youtubePlayerController;
  final videoUrl = "https://www.youtube.com/watch?v=ykJmrZ5v0Oo";
  @override
  void initState(){
    super.initState();
    _workout= _workoutController.getWorkout(widget.index);
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    _youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      )
    );


  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    print("the id is ${_workout.id}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: TColor.black,
              size: 20,
            ),
          ),
        ),
        title: Text(_workout.name,
            style: TextStyle(
              color: TColor.black,
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
            )),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.more_horiz,
                color: TColor.black,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body:
      SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: TColor.lightGray,
                    image: DecorationImage(
                      image: NetworkImage(_workout.image ?? ''),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.0), // Add rounded corners
                  ),
                  child: Image(
                    image: NetworkImage(_workout.image ?? ''),

                    fit: BoxFit.contain,

                  ),
                ),
                const SizedBox(height: 16),
                Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Workout Description',
                                        style: TextStyle(
                                            color: TColor.black,
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: media.width * 0.05,
                                      ),
                                      Text(
                                        '${_workout.description}',
                                        style: TextStyle(
                                            color: TColor.black,

                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        height: media.width * 0.05,
                                      ),
                                      Text(
                                        'Workout Video',
                                        style: TextStyle(
                                            color: TColor.black,
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w700),
                                      )

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: media.width * 0.05,
                          ),
                          SizedBox(
                            height: media.width * 0.05,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            child: YoutubePlayer(
                              controller: _youtubePlayerController,
                              showVideoProgressIndicator: true,
                              onReady: ()=> debugPrint('Ready'),
                              bottomActions: [
                                CurrentPosition(),
                                ProgressBar(
                                  isExpanded: true,
                                    colors:  ProgressBarColors(
                                        playedColor: TColor.primaryColor1,
                                      handleColor: TColor.secondaryColor2
                                    )
                                ),
                                const PlaybackSpeedButton(),
                                 FullScreenButton(),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )


              ],
            ),)
      ),
    );

  }
}