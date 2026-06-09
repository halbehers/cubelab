import 'package:camera/camera.dart';
import 'package:cubelab/helpers/logger.dart';
import 'package:cubelab/main.dart';
import 'package:cubelab/scan/cube_scanner_controller.dart';
import 'package:cubelab/theme/h_icon.dart';
import 'package:cubelab/theme/icon_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  CameraDescription? _cameraDescription;
  final CubeScannerController _cubeScannerController = CubeScannerController();
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isNotEmpty) {
      _cameraDescription = cameras.first;
      await _initializeCameraController(_cameraDescription!);
    }

    if (controller != null && controller!.value.isInitialized) {
      controller!.startImageStream((CameraImage image) {
        // TODO
        // _cubeScannerController.processFrame(image);
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cameraController = controller;

    if (cameraController == null) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // cameraController.dispose();
      controller = null;
    } else if (state == AppLifecycleState.resumed &&
        _cameraDescription != null) {
      _initializeCameraController(_cameraDescription!);
    }
  }

  Future<void> _initializeCameraController(
    CameraDescription cameraDescription,
  ) async {
    final cameraController = CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        getLogger().e(
          'Camera error ${cameraController.value.errorDescription}',
        );
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait(<Future<Object?>>[
        // The exposure mode is currently not supported on the web.
        ...!kIsWeb
            ? <Future<Object?>>[
                cameraController.getMinExposureOffset().then(
                  (double value) => _minAvailableExposureOffset = value,
                ),
                cameraController.getMaxExposureOffset().then(
                  (double value) => _maxAvailableExposureOffset = value,
                ),
              ]
            : <Future<Object?>>[],
        cameraController.getMaxZoomLevel().then(
          (double value) => _maxAvailableZoom = value,
        ),
        cameraController.getMinZoomLevel().then(
          (double value) => _minAvailableZoom = value,
        ),
      ]);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          getLogger().e('You have denied camera access.');
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          getLogger().e('Please go to Settings app to enable camera access.');
        case 'CameraAccessRestricted':
          // iOS only
          getLogger().e('Camera access is restricted.');
        case 'AudioAccessDenied':
          getLogger().e('You have denied audio access.');
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          getLogger().e('Please go to Settings app to enable audio access.');
        case 'AudioAccessRestricted':
          // iOS only
          getLogger().e('Audio access is restricted.');
        default:
          getLogger().e(e);
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget _cameraPreviewWidget(BuildContext context) {
    final CameraController? cameraController = controller;
    final appTheme = context.appTheme;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text('Tap a camera');
    } else {
      return Stack(
        fit: StackFit.expand,
        children: [
          Listener(
            onPointerDown: (_) => _pointers++,
            onPointerUp: (_) => _pointers--,
            child: CameraPreview(
              controller!,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onScaleStart: _handleScaleStart,
                    onScaleUpdate: _handleScaleUpdate,
                    onTapDown: (TapDownDetails details) =>
                        onViewFinderTap(details, constraints),
                  );
                },
              ),
            ),
          ),
          IgnorePointer(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: SvgPicture.asset(
                IconPath.cube.path,
                colorMapper: IconColorMapper(
                  appTheme: appTheme,
                  color: appTheme.invertedTextColor,
                  isActive: true,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale).clamp(
      _minAvailableZoom,
      _maxAvailableZoom,
    );

    await controller!.setZoomLevel(_currentScale);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final CameraController cameraController = controller!;

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _cameraPreviewWidget(context));
  }
}
