import 'package:flutter/cupertino.dart';
import '../model/song.dart';
import '../data/songs.dart';

class SongProvider with ChangeNotifier{
   late Song _currentSong;


   setSong(Song s){
     _currentSong = s;
     notifyListeners();
   }

   Song get currentSong => _currentSong;

   setNext(){
     int i = songs.indexOf(_currentSong);
     if( (songs.length - i )<= 1 ){
       return setSong(songs[0]);
     }
     return setSong(songs[i+1]);
   }

   setPrevious(){
     int i = songs.indexOf(_currentSong);
     if((i-0) == 0){
       return setSong(songs[songs.length-1]);
     }
     return setSong(songs[i-1]);
   }

}