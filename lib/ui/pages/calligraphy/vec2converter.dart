import 'package:shorthand_app/toolbox/model/point.dart';
import 'package:shorthand_app/ui/pages/calligraphy/vec2.dart'; // for Point (Flutter)

class Vec2Converter {
  static Vec2 fromPoint(Point p) {
    return Vec2(p.x, p.y);
  }

  static Point toPoint(Vec2 v) {
    return Point(v.x, v.y);
  }
}
