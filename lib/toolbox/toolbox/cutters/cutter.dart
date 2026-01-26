// import 'package:shorthand_app/common/model/line.dart';
// import 'package:shorthand_app/common/model/lines.dart';
import 'package:shorthand_app/toolbox/toolbox/cutters/line_cutter_by_direction_change.dart';

class Cutter {
  StrokeCutter strokeCutter = StrokeCutter();

  // static Lines2 cutByVerticalDirectionChange(Line2 stroke) {
  //   // convert to points
  // }

  // static Lines2 cutByHorizontalDirectionChange(Line2 stroke) {
  //   // convert to points
  // }
}

// Got it — **Dart** 👍
// Yes, you *can* do exactly that in Dart using **extension methods**, and they work very naturally for this use case.

// You **don’t attach an extension to a class instance**, but you **extend the type** (`Rect`) with extra behavior.

// ---

// ## ✅ Correct Dart way: extension on `Rect`

// ```dart
// import 'dart:ui';

// extension RectCutter on Rect {
//   List<Rect> sliceToHalfVertically() {
//     final halfWidth = width / 2;

//     return [
//       Rect.fromLTWH(left, top, halfWidth, height),
//       Rect.fromLTWH(left + halfWidth, top, halfWidth, height),
//     ];
//   }
// }
// ```

// Usage:

// ```dart
// final rect = Rect.fromLTWH(0, 0, 100, 50);

// final halves = rect.sliceToHalfVertically();
// ```

// This is **exactly idiomatic Dart**.

// ---

// ## ❌ What you *cannot* do in Dart

// You **cannot** have:

// ```dart
// rect.cutter.sliceToHalfVertically(); // ❌ not possible
// ```

// Why:

// * Extensions **do not add fields or properties**
// * They only add **methods/getters/setters directly to the type**

// ---

// ## ✅ Closest alternatives if you want `.cutter`

// ### Option 1: Getter returning helper object (wrapper pattern)

// ```dart
// extension RectCutter on Rect {
//   _RectCutter get cutter => _RectCutter(this);
// }

// class _RectCutter {
//   final Rect rect;

//   _RectCutter(this.rect);

//   List<Rect> sliceToHalfVertically() {
//     final halfWidth = rect.width / 2;
//     return [
//       Rect.fromLTWH(rect.left, rect.top, halfWidth, rect.height),
//       Rect.fromLTWH(rect.left + halfWidth, rect.top, halfWidth, rect.height),
//     ];
//   }
// }
// ```

// Usage:

// ```dart
// rect.cutter.sliceToHalfVertically(); // ✅ works
// ```

// ⚠️ Note: this allocates a helper object.

// ---

// ### Option 2: Namespace-style extension (cleanest & fastest)

// ```dart
// extension RectCutting on Rect {
//   List<Rect> sliceVertically(int parts) {
//     final partWidth = width / parts;
//     return List.generate(
//       parts,
//       (i) => Rect.fromLTWH(
//         left + i * partWidth,
//         top,
//         partWidth,
//         height,
//       ),
//     );
//   }
// }
// ```

// Usage:

// ```dart
// rect.sliceVertically(2);
// ```

// ---

// ## Recommendation 🧠

// If this is **pure behavior**, go with:

// ```dart
// rect.sliceToHalfVertically();
// ```

// If you’re building a **fluent DSL** or lots of grouped ops, the `cutter` getter is acceptable — just be aware it’s a wrapper.

// ---

// ## Summary

// | Goal                                  | Possible?    |
// | ------------------------------------- | ------------ |
// | `rect.sliceToHalfVertically()`        | ✅ Best       |
// | `rect.cutter.sliceToHalfVertically()` | ❌ (directly) |
// | Getter returning helper               | ✅            |
// | Add state via extension               | ❌            |

// If you want, tell me:

// * performance-critical or not?
// * immutable vs mutable ops?
// * Flutter `Rect` or your own?

// I can refine the pattern exactly to your needs.
