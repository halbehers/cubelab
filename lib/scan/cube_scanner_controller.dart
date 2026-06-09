import 'dart:async';

import 'package:camera/camera.dart';
import 'package:cubelab/helpers/logger.dart';
import 'package:flutter/services.dart';

class CubeScannerController {
  static const MethodChannel _channel = MethodChannel('cube_vision');

  bool _isProcessing = false;

  DateTime _lastProcessed = DateTime.fromMillisecondsSinceEpoch(0);

  static const Duration _minInterval = Duration(milliseconds: 150);

  List<String>? detectedFace;

  Future<void> processFrame(CameraImage image) async {
    await _processFrame(image);
  }

  Future<void> _processFrame(CameraImage image) async {
    if (_isProcessing) return;

    final now = DateTime.now();

    if (now.difference(_lastProcessed) < _minInterval) {
      return;
    }

    _isProcessing = true;
    _lastProcessed = now;

    try {
      final Map<String, dynamic> frameData = {
        'width': image.width,
        'height': image.height,
        'format': image.format.raw,
        'planes': image.planes.map((plane) {
          return {
            'bytes': plane.bytes,
            'bytesPerRow': plane.bytesPerRow,
            'bytesPerPixel': plane.bytesPerPixel,
            'height': plane.height,
            'width': plane.width,
          };
        }).toList(),
      };

      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'analyzeFrame',
        frameData,
      );

      if (result == null) {
        return;
      }

      final bool faceDetected = result['faceDetected'] == true;

      if (!faceDetected) {
        detectedFace = null;
        return;
      }

      final stickers = (result['stickers'] as List<dynamic>)
          .map((e) => e.toString())
          .toList();

      detectedFace = stickers;

      /*
      Example returned data:

      {
        "faceDetected": true,
        "stickers": [
          "W","W","R",
          "G","W","R",
          "B","Y","O"
        ]
      }
    */

      getLogger().d('Detected face: $stickers');
    } on PlatformException catch (e) {
      getLogger().e('OpenCV processing error: ${e.message}');
    } catch (e) {
      getLogger().e('Unexpected frame processing error: $e');
    } finally {
      _isProcessing = false;
    }
  }
}
