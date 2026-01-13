import 'package:shorthand_app/common/toolbox/filters/filters.dart';
import 'package:shorthand_app/common/toolbox/inspectors/inspectors.dart';
// import 'package:shorthand_app/common/toolbox/point_manager/point_manager.dart';
import 'package:shorthand_app/common/toolbox/transformers/transformers.dart';

class Toolbox {
  // final PointsManager pointsManager = PointsManager();
  // Groupers
  // Cutters
  final Filters filters = Filters();
  // final Validators inspectors = Validators();
  final Inspectors inspectors = Inspectors();
  final Transformers transformers = Transformers();
}


// Attaching to common data types according to Law of Demeter

// Actually now that i think about it this is cool separate thing
// We use Law of Demeter for discovering through types
// We use Toolbox for discovering tools within those types

// where bounding box and intersection goes?
