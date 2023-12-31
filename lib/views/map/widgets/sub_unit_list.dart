import 'package:flutter/material.dart';
import 'package:viet_chronicle/controllers/map_controller.dart';
import 'package:viet_chronicle/models/lesson.dart';
import 'package:viet_chronicle/routes/routes.dart';
import 'package:viet_chronicle/utils/global_data.dart';
import 'package:viet_chronicle/utils/styles.dart';
import 'package:viet_chronicle/views/map/widgets/break_subunit.dart';
import 'package:viet_chronicle/views/quiz/quiz_view.dart';
import 'package:viet_chronicle/views/video/video_view.dart';
import 'package:viet_chronicle/views/widgets/circle_button/vc_circle_button.dart';
import 'package:viet_chronicle/views/widgets/button/controller/vc_button_controller.dart';

class SubUnitList extends StatelessWidget {
  final VCButtonController vcButtonController = VCButtonController();
  final MapController mapController;

  final int subUnitId;
  final List<Lesson> lessons;

  SubUnitList({
    super.key,
    required this.subUnitId,
    required this.lessons,
    required this.mapController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32 * viewportRatio),
      child: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(lessons.length, (index) {
            return Column(
              children: [
                VCCircleButton(
                  iconName: lessons[index].lessonType ?? '',
                  callback: () {
                    if (lessons[index].lessonType == 'quiz') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizView(
                                  lessonId: lessons[index].id,
                                )),
                      );
                    }

                    if (lessons[index].lessonType == 'video') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoView(
                                  lessonId: lessons[index].id,
                                )),
                      );
                    }
                    if (lessons[index].lessonType == 'reward') {
                      Navigator.popAndPushNamed(context, AppRoutes.rewardView);
                    }

                    GlobalData.instance.subUnit = subUnitId;
                    GlobalData.instance.lesson = index;

                    // print(
                    // "sub unit id = ${GlobalData.instance.subUnit} - lesson id = ${GlobalData.instance.lesson}");
                  },
                  controller: vcButtonController,
                  leftPadding: LessonStyles.leftPaddings[index % 8],
                  rightPadding: LessonStyles.rightPaddings[index % 8],
                  status: lessons[index].status,
                ),
                SizedBox(
                  height: LessonStyles.bottomPaddings[index % 4],
                ),
                if (index == lessons.length - 1 &&
                    subUnitId !=
                        mapController
                                .getUnit(mapController.getUnitId())
                                .subunits
                                .length -
                            1)
                  BreakSubunit(
                      subUnitTitle: mapController
                          .getSubUnit(mapController.getUnitId(), subUnitId + 1)
                          .title!),
              ],
            );
          }),
        ),
      ),
    );
  }
}
