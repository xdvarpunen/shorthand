import 'package:flutter/material.dart';
import 'package:shorthand_app/common/model/immutable/canvas_controller.dart';

// class CanvasComplexTemplatePage extends StatelessWidget {
//   final String title;
//   final VoidCallback? onClear;
//   final List<Widget>? actions;
//   final Widget canvas;

//   const CanvasComplexTemplatePage({
//     super.key,
//     required this.title,
//     required this.canvas,
//     this.onClear,
//     this.actions,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         actions: actions,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             if (onClear != null)
//               ElevatedButton(
//                 onPressed: onClear,
//                 child: const Text('Clear'),
//               ),
//             if (onClear != null) const SizedBox(height: 20),
//             Expanded(child: canvas),
//           ],
//         ),
//       ),
//     );
//   }
// }
class CanvasComplexTemplatePage extends StatelessWidget {
  final String title;
  final Widget canvas;
  final VoidCallback? onClear;
  final VoidCallback? onUndo;
  final VoidCallback? onRedo;
  final VoidCallback? onToggleTool;
  final Tool? currentTool;

  const CanvasComplexTemplatePage({
    super.key,
    required this.title,
    required this.canvas,
    this.onClear,
    this.onUndo,
    this.onRedo,
    this.onToggleTool,
    this.currentTool,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (onUndo != null)
            IconButton(icon: const Icon(Icons.undo), onPressed: onUndo),
          if (onRedo != null)
            IconButton(icon: const Icon(Icons.redo), onPressed: onRedo),
          if (onToggleTool != null)
            // IconButton(
            //   icon: Icon(currentTool == Tool.pen
            //       ? Icons.edit
            //       : Icons.cleaning_services),
            //   onPressed: onToggleTool,
            // ),
            // Pen/Eraser Switch
            Row(
              children: [
                const Text('Pen'),
                Switch(
                  value: currentTool == Tool.eraser, // use the prop
                  onChanged: (_) => onToggleTool?.call(),
                ),
                const Text('Eraser'),
              ],
            ),
          if (onClear != null)
            IconButton(icon: const Icon(Icons.clear), onPressed: onClear),
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(16), child: canvas),
    );
  }
}
