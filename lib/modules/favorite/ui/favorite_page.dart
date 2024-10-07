import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_on_restaurant/modules/favorite/viewmodel/favorite_view_model.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite_page';

  const FavoritePage({super.key});
  
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteViewModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Your Favorites'
          ),
        ),
      ),
    );
  }
}