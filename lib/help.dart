import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'topbar.dart';
import 'navbar.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/Green Pakistan with GreenCare.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: TopBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_controller.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller),
                    if (!_controller.value.isPlaying)
                      IconButton(
                        icon: Icon(Icons.play_circle_fill, color: Colors.white, size: 50.0),
                        onPressed: () {
                          setState(() {
                            _controller.play();
                          });
                        },
                      ),
                  ],
                ),
              )
            else
              Container(
                height: 200.0,
                color: Colors.black,
                child: Center(child: CircularProgressIndicator()),
              ),
            SizedBox(height: 16.0),
            Text(
              'How to use GreenCare?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(), // Use TopBar widget instead of direct implementation
    );
  }
}
