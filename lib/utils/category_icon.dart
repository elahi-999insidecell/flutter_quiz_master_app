import 'package:flutter/material.dart';

IconData getCategoryIcon(int id) {
  switch (id) {
    case 9:
      return Icons.lightbulb; // General Knowledge

    case 10:
      return Icons.book; // Books

    case 11:
      return Icons.movie; // Film

    case 12:
      return Icons.music_note; // Music

    case 13:
      return Icons.music_video; // Video Games

    case 14:
      return Icons.tv;
    
    case 15:
      return Icons.sports_esports;

    case 16:
      return Icons.sports_tennis_outlined;

    case 17:
      return Icons.science; // Science

    case 18:
      return Icons.computer; // Computers

    case 19:
      return Icons.calculate;

    case 20:
      return Icons.shield;
  
    case 21:
      return Icons.sports_soccer; // Sports

    case 22:
      return Icons.public; // Geography

    case 23:
      return Icons.history_edu; 
   
   case 24:
      return Icons.how_to_vote;
   
   case 25:
      return Icons.brush;
 
  case 26:
      return Icons.star;
  
    case 27:
      return Icons.pets; 

    case 28:
      return Icons.motorcycle; 

    case 29:
      return Icons.mood; 
   
   case 30:
      return Icons.smartphone;
   
   case 31:
      return Icons.live_tv;
   
   case 32:
      return Icons.videogame_asset;

    default:
      return Icons.quiz;
  }
}
