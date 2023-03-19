import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songs/model/song.dart';
import 'package:songs/providers/song_provider.dart';
import '../data/songs.dart';
class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          title: const Text("Bibliotheque Audio", style: TextStyle(color: Colors.white),),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Column(

          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: songs.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    title: Text(songs[i].name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.white70),),
                    leading: Icon(Icons.audiotrack, color: Colors.white,size: 20.0),
                    tileColor: Colors.black26,
                    onTap: () {
                      Provider.of<SongProvider>(context, listen: false).setSong(songs[i]);
                      Navigator.pushNamed(context, '/player');
                    },

                  );
                }
            )
          ],
        ),
      )
    );
  }
}
