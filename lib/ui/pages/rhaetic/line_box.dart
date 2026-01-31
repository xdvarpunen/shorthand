import 'package:shorthand_app/toolbox/model/line.dart';
import 'package:shorthand_app/ui/pages/pigpen_cipher/copy/bounding_box.dart';

class LineBox {
  final Line line;
  final BoundingBox box;

  LineBox(this.line) : box = BoundingBox.fromPoints(line.points);
}
