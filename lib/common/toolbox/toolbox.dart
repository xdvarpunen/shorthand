import 'package:shorthand_app/common/toolbox/filters/filters.dart';
import 'package:shorthand_app/common/toolbox/inspectors/inspectors.dart';
import 'package:shorthand_app/common/toolbox/transformers/transformers.dart';
import 'package:shorthand_app/common/toolbox/validators/validators.dart';

class Toolbox {
  final Groupers groupers = Groupers();
  final Cutters cutters = Cutters();
  final Filters filters = Filters();
  final Validators validators = Validators();
  final Inspectors inspectors = Inspectors();
  final Transformers transformers = Transformers();
}

class Cutters {}

class Groupers {}

// where bounding box and intersection goes? to bounding box concept. part of line or lines
// we use toolbox to discover tools needed through organization
