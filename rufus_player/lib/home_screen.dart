import 'package:rufus_player/playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:rufus_player/palette.dart' as palette;
// ignore: depend_on_referenced_packages
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _url = "https://www.youtube.com/watch?v=KTksi_VXGCk";
  var txtController = TextEditingController();

  late YoutubePlayerController _controller;

  late YoutubeMetaData _videoMetaData;

  @override
  void initState() {
    super.initState();
    var videoID = YoutubePlayer.convertUrlToId(_url);

    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    )..addListener(listener);

    _videoMetaData = const YoutubeMetaData();
  }

  void listener() {
    if (mounted && !_controller.value.isFullScreen) {
      setState(() {
        _videoMetaData = _controller.metadata;
      });
    }
  }

  void refreshPlayer(url) {
    _controller.load(YoutubePlayer.convertUrlToId(url).toString());
    txtController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: palette.highlight,
        progressColors: ProgressBarColors(
          backgroundColor: Colors.teal[900],
          handleColor: palette.highlight,
          playedColor: palette.highlight,
        ),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: palette.background,
          appBar: AppBar(
            title: Row(
              children: [
                Image.asset(
                  "assets/rufus-icon.png",
                  height: 45,
                ),
                const Text(
                  "Rufus Player",
                  style: TextStyle(
                      color: palette.highlight, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            backgroundColor: palette.secondarybg,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Playlist()));
                  },
                  icon: const Icon(Icons.insert_drive_file,
                      color: palette.highlight))
            ],
          ),
          body: ListView(
            children: [
              const SizedBox(height: 50),
              Container(
                color: palette.background,
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: txtController,
                  style: const TextStyle(color: palette.textColor),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: palette.highlight,
                      ),
                      onPressed: () {
                        setState(() {
                          if (txtController.text.isNotEmpty) {
                            refreshPlayer(txtController.text);
                          }
                        });
                      },
                    ),
                    hintText: 'www.youtube.com/watch?v=XXXXXXXXX',
                    hintStyle: const TextStyle(color: palette.buttonPrimary),
                    labelText: 'Youtube URL',
                    labelStyle: const TextStyle(color: palette.buttonPrimary),
                    fillColor: palette.widgetColor,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: palette.highlight, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: palette.widgetColor, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ), //OJO QUE ESTO
                  onSubmitted: (text) {
                    setState(() {
                      if (text.isNotEmpty) {
                        refreshPlayer(text);
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  color: palette.secondarybg,
                  borderRadius: BorderRadius.circular(35),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 5),
                child: Column(
                  children: [
                    player,
                    const SizedBox(height: 30),
                    Text(
                      _videoMetaData.title,
                      style: const TextStyle(color: palette.textColor),
                    ),
                    Text(
                      _videoMetaData.author,
                      style: const TextStyle(color: palette.textColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
