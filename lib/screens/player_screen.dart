import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songs/model/song.dart';
import 'package:songs/providers/song_provider.dart';
import 'package:audioplayers/audioplayers.dart';



class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  final player = AudioPlayer();


  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    await player.stop();
  }

  @override
  Widget build(BuildContext context) {
    Song s = context.read<SongProvider>().currentSong;

    player.onDurationChanged.listen((Duration d)  {
      setState(() => duration = d);
    });

    player.onPositionChanged.listen((Duration  p)  {
        setState(() => position = p);
    });
    
    player.onPlayerStateChanged.listen((PlayerState event) {
      if(mounted) {
        setState(() {
          if(event.name == "stopped" || event.name == "paused") {
            isPlaying = false;
          } else {
            isPlaying = true;
          }
        });
      }

    });

    player.onPlayerComplete.listen((event) {
      setState(() {
        position = Duration.zero;
        isPlaying = false;
      });
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text("Playing ${s.name}", style: TextStyle(color: Colors.white),),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(s.name, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30.0, color: Colors.white),),

            SizedBox(
              width: 250,
              height: 250,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/${s.img}"),
              ),
            ),
            Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                inactiveColor: Colors.grey,
                activeColor: Theme.of(context).colorScheme.primary,
                onChanged:  (val) => {

            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${duration.inSeconds.toInt()}", style: const TextStyle(color: Colors.white, fontSize: 30),),
                Text("${position.inSeconds.toInt()}",  style: const TextStyle(color: Colors.white, fontSize: 30)),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(icon:Icon(Icons.skip_previous_sharp, color: Theme.of(context).colorScheme.primary, size: 50), onPressed: () {
                  player.release();
                  Provider.of<SongProvider>(context, listen: false).setPrevious();
                  position = Duration.zero;
                  duration = Duration.zero;
                  Song newSong = context.read<SongProvider>().currentSong;
                  player.play(AssetSource('audios/${newSong.filename}'));
                },),
                IconButton(icon: Icon(isPlaying? Icons.pause : Icons.play_arrow_sharp, color: Theme.of(context).colorScheme.primary, size: 70), onPressed: () async {
                  await player.setSource(AssetSource('audios/${s.filename}'));
                  await player.setVolume(0.5);
                  if(!isPlaying){
                   // setState(() {
                      if (duration.inSeconds.toInt()>0) {
                        await player.resume();

                      }
                      else {
                        await player.play(AssetSource('audios/${s.filename}'));
                      }

                   // });
                  } else {
                    await player.pause();
                  }
                },
                ),
                IconButton(icon: Icon(Icons.skip_next_sharp, color: Theme.of(context).colorScheme.primary, size: 50,), onPressed: () {
                  player.release();
                  Provider.of<SongProvider>(context, listen: false).setNext();
                  position = Duration.zero;
                  duration = Duration.zero;
                  Song newSong = context.read<SongProvider>().currentSong;
                  player.play(AssetSource('audios/${newSong.filename}'));
                },),
              ],
            )
          ],
        ),
      ),
    );
  }


}
