// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:flutter_painter_v2/flutter_painter.dart';
// import 'package:flutter_drawing_board/flutter_drawing_board.dart';
//
// class DrawingPage extends StatefulWidget {
//   @override
//   _DrawingPageState createState() => _DrawingPageState();
// }
//
// class _DrawingPageState extends State<DrawingPage> {
//   Color _brushColor = Colors.black;
//   double _brushSize = 5.0;
//   final DrawingBoardController _controller = DrawingBoardController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Digital Drawing Tool'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               _controller.clear();
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: DrawingBoard(
//               controller: _controller,
//               backgroundColor: Colors.white,
//               brushColor: _brushColor,
//               brushSize: _brushSize,
//             ),
//           ),
//           _buildBrushControls(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBrushControls() {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       color: Colors.grey[200],
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//             icon: Icon(Icons.brush),
//             onPressed: () {
//               _showBrushSizeDialog();
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.color_lens),
//             onPressed: () {
//               _showColorPickerDialog();
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showBrushSizeDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Select Brush Size'),
//           content: Slider(
//             value: _brushSize,
//             min: 1.0,
//             max: 20.0,
//             divisions: 19,
//             label: _brushSize.toStringAsFixed(1),
//             onChanged: (value) {
//               setState(() {
//                 _brushSize = value;
//                 _controller.updateBrushSize(_brushSize);
//               });
//             },
//           ),
//           actions: [
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _showColorPickerDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Select Brush Color'),
//           content: ColorPicker(
//             pickerColor: _brushColor,
//             onColorChanged: (color) {
//               setState(() {
//                 _brushColor = color;
//                 _controller.updateBrushColor(_brushColor);
//               });
//             },
//           ),
//           actions: [
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }