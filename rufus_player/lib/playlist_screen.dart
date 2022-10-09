import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rufus_player/palette.dart' as palette;

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  List<String> urls = [];
  var txtController = TextEditingController();

  TextEditingController textarea = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        backgroundColor: palette.secondarybg,
      ),
      body: Column(
        children: [
          const Divider(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
                controller: txtController,
                style: const TextStyle(color: palette.textColor),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        urls.add(txtController.text);
                        txtController.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      color: palette.highlight,
                    ),
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
                    urls.add(text);
                    txtController.clear();
                  });
                }),
          ),
          const Divider(height: 10),
          Flexible(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView.builder(
              itemCount: urls.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ListTile(
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          urls.remove(urls[index]);
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: palette.buttonPrimary,
                      ),
                    ),
                    hoverColor: palette.highlight,
                    style: ListTileStyle.list,
                    tileColor: palette.secondarybg,
                    title: Center(
                      child: Text(
                        urls[index],
                        style: const TextStyle(color: palette.highlight),
                      ),
                    ),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: urls[index]));
                    },
                  ),
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}
