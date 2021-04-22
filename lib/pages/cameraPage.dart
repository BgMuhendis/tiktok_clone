import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiktok/utils/utils.dart';

class CameraPage extends StatefulWidget {
  final PageController bottomPageController =
      PageController(viewportFraction: .3);
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool state = false;
  int _cameraIndex;
  bool _isRecording = false;
  String _filePath;
  CameraController _controller;
  Future<void> _controllerInizializer;
  Future<CameraDescription> getCamera() async {
    final c = await availableCameras();
    return c.first;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCamera().then((camera) {
      setState(() {
        _controller = CameraController(camera, ResolutionPreset.high);
        _controllerInizializer = this._controller.initialize();
      });
    });
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: FutureBuilder(
              future: _controllerInizializer,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            //  extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 50,
                    right: 20,
                    left: 20,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          height: 25,
                          child: ClipRRect(
                            child: Image.network(Utils.image()),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        Container(
                          height: 25,
                          child: Icon(Icons.flash_on,
                              color: Colors.black, size: 30),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              state = !state;
                            });
                            if (state) {
                              onRecord();
                            } else {
                              _onStop();
                            }
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(
                                color: Colors.black,
                                width: 3.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(35),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          child: Icon(
                            Icons.cached,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        Container(
                          height: 50,
                          child: Icon(Icons.tag_faces,
                              color: Colors.black, size: 30),
                        ),
                      ],
                    ),
                  ),
                  /*      Positioned(
                                                      right: 0,
                                                      left: 0,
                                                      bottom: 10,
                                                      height: 20,
                                                      child: PageView.builder(
                                                        controller: widget.bottomPageController,
                                                        itemCount: 10,
                                                        itemBuilder: (context, index) {
                                                          return Text(
                                                            "Item $index",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Colors.black
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ), */
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _onStop() async {
    await _controller.stopVideoRecording();
    setState(() => _isRecording = false);
    _onPlay();
  }

  void _onPlay() {
    OpenFile.open(_filePath);
  }

  void onRecord() async {
    var directory = await getTemporaryDirectory();
    _filePath = directory.path + '/${DateTime.now()}.mp4';
    //_controller.startVideoRecording(_filePath);
    _controller.startVideoRecording(_filePath);
    setState(() {
      _isRecording = true;
    });
  }
}
