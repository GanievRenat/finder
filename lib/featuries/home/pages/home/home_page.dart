import 'package:flirta/common/ui/widgets/logo/logo.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'widgets/card_swipe.dart';
import 'widgets/cards_swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onFilter});

  final VoidCallback onFilter;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CardSwipe> cards = [
    CardSwipe(
      key: ValueKey(1),
      imageUrl:
          'https://pg11.ru/userfiles/picfullsize/img-53415-14964303316571.jpg',
      name: 'Jane Cooper',
      age: 25,
      job: 'Professional model',
    ),
    CardSwipe(
      key: ValueKey(2),
      imageUrl:
          'https://img.freepik.com/free-photo/portrait-blonde-woman-looking-photographer_23-2148348970.jpg?semt=ais_hybrid&w=740&q=80',
      name: 'Jane Cooper',
      age: 25,
      job: 'Professional model',
    ),
    CardSwipe(
      key: ValueKey(3),
      imageUrl:
          'https://img.freepik.com/free-photo/attractive-positive-elegant-young-woman-cafe_23-2148071691.jpg?semt=ais_hybrid&w=740&q=80',
      name: 'Jane Cooper',
      age: 25,
      job: 'Professional model',
    ),
  ];

  bool canUndo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const LogoFlirta(),
        actions: [
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Assets.images.icons.filter.svg(),
            ),
            onPressed: widget.onFilter,
          ),
        ],
      ),
      body: CardsSwiper(
        cards: cards,
        onEnd: () {},
        onLike: () {},
        onSkip: () {},
        onUndo: () {},
      ),
    );
  }
}
