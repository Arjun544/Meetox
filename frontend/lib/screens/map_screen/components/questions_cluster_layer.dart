import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/question_model.dart';

import '../../../core/imports/core_imports.dart';
import 'question_marker.dart';

class QuestionsClusterlayer extends GetView<MapScreenController> {
  const QuestionsClusterlayer(this.questions, {super.key});

  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    final tappedQuestion = Question().obs;

    return ZoomIn(
      child: Obx(
        () => MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            spiderfySpiralDistanceMultiplier: 2,
            circleSpiralSwitchover: 1,
            zoomToBoundsOnClick: false,
            size: Size(50.sp, 50.sp),
            markers: tappedQuestion.value.id != null
                ? [
                    Marker(
                      point: LatLng(
                        tappedQuestion.value.location!.coordinates![0],
                        tappedQuestion.value.location!.coordinates![1],
                      ),
                      width: 60.sp,
                      height: 60.sp,
                      builder: (context) => QuestionMarker(
                        question: tappedQuestion.value,
                        tappedQuestion: tappedQuestion,
                      ),
                    )
                  ]
                : questions
                    .map(
                      (question) => Marker(
                        point: LatLng(
                          question.location!.coordinates![0],
                          question.location!.coordinates![1],
                        ),
                        width: 60.sp,
                        height: 60.sp,
                        builder: (context) => QuestionMarker(
                          question: question,
                          tappedQuestion: tappedQuestion,
                        ),
                      ),
                    )
                    .toList(),
            polygonOptions: const PolygonOptions(
                borderColor: Colors.lightBlue, borderStrokeWidth: 4),
            builder: (context, markers) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  height: 40.sp,
                  width: 40.sp,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '+${markers.length - 1}',
                    style: context.theme.textTheme.labelMedium,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
