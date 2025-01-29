import 'dart:io';
import 'package:camera/camera.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

final selfiePath = StateProvider((state) => "");

final switchCamera = StateProvider((state) => false);

class TakePictureScreen extends ConsumerStatefulWidget {
  final CameraDescription camera;
  final CameraDescription backcamera;
  const TakePictureScreen(
      {super.key, required this.camera, required this.backcamera});

  @override
  ConsumerState<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends ConsumerState<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraController _backcontroller;
  late Future<void> _initializeBackControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _backcontroller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.backcamera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeBackControllerFuture = _backcontroller.initialize();
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    _backcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      // ignore: unused_local_variable
      var swcam = ref.watch(switchCamera);
      return Scaffold(
        // You must wait until the controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner until the
        // controller has finished initializing.
        body: Stack(
          children: [
            Visibility(
              visible: !ref.read(switchCamera),
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview.
                    var padding = Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () async {
                                  HapticFeedback.lightImpact();

                                  // Take the Picture in a try / catch block. If anything goes wrong,
                                  // catch the error.
                                  try {
                                    // Ensure that the camera is initialized.
                                    await _initializeControllerFuture;

                                    // Attempt to take a picture and get the file `image`
                                    // where it was saved.
                                    final image =
                                        await _controller.takePicture();

                                    if (!context.mounted) return;

                                    // If the picture was taken, display it on a new screen.
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DisplayPictureScreen(
                                                    image: image)));
                                  } catch (e) {
                                    // If an error occurs, log the error to the console.
                                    print(e);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100))),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: 48,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () async {
                                  HapticFeedback.lightImpact();
                                  _initializeBackControllerFuture =
                                      _backcontroller.initialize();
                                  ref.read(switchCamera.notifier).update(
                                      (state) => !ref.read(switchCamera));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100))),
                                  child: Icon(
                                    Icons.swap_horizontal_circle_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    return SafeArea(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.flip(
                            flipX: true, child: CameraPreview(_controller)),
                        const SizedBox(
                          height: 40,
                        ),
                        padding
                      ],
                    ));
                  } else {
                    // Otherwise, display a loading indicator.
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Visibility(
              visible: ref.read(switchCamera),
              child: FutureBuilder<void>(
                future: _initializeBackControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview.
                    var padding = Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () async {
                                  HapticFeedback.lightImpact();

                                  // Take the Picture in a try / catch block. If anything goes wrong,
                                  // catch the error.
                                  try {
                                    // Ensure that the camera is initialized.
                                    await _initializeBackControllerFuture;

                                    // Attempt to take a picture and get the file `image`
                                    // where it was saved.
                                    final image =
                                        await _backcontroller.takePicture();

                                    if (!context.mounted) return;

                                    // If the picture was taken, display it on a new screen.
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DisplayPictureScreen(
                                                    image: image)));
                                  } catch (e) {
                                    // If an error occurs, log the error to the console.
                                    print(e);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100))),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: 48,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () async {
                                  HapticFeedback.lightImpact();
                                  _initializeControllerFuture =
                                      _controller.initialize();
                                  ref.read(switchCamera.notifier).update(
                                      (state) => !ref.read(switchCamera));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100))),
                                  child: Icon(
                                    Icons.swap_horizontal_circle_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    return SafeArea(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.flip(
                            flipX: false,
                            child: CameraPreview(_backcontroller)),
                        const SizedBox(
                          height: 40,
                        ),
                        padding
                      ],
                    ));
                  } else {
                    // Otherwise, display a loading indicator.
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final XFile image;
  const DisplayPictureScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        appBar: AppBar(),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.file(File(image.path)),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () async {
                HapticFeedback.lightImpact();
                final Directory appDocumentsDir =
                    await getApplicationDocumentsDirectory();
                final String filePath =
                    path.join(appDocumentsDir.path, 'selfie.jpg');

                // Move the file to the local storage
                final File savedFile = await File(image.path).copy(filePath);
                ref
                    .read(appSettingsDatabaseProvider.notifier)
                    .editSetting(2, "SelfiePath", savedFile.path);
                ref.read(selfiePath.notifier).update((state) => image.path);

                if (!context.mounted) return;
                ref.read(switchCamera.notifier).update((state)=>false);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(100))),
                child: Icon(
                  Icons.done_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 48,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
