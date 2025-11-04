import 'package:flirta/common/ui/widgets/logo/logo.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'widgets/card_swipe.dart';
import 'widgets/cards_swiper.dart';

class DatingPage extends StatefulWidget {
  const DatingPage({
    super.key,
    required this.onFilter,
    required this.onDetailPerson,
    required this.onMatch,
  });

  final VoidCallback onFilter;
  final Function(String imageUrl) onMatch;
  final Function({
    required String imageUrl,
    required String name,
    required int age,
    required String job,
  })
  onDetailPerson;

  @override
  State<DatingPage> createState() => _DatingPageState();
}

class _DatingPageState extends State<DatingPage> {
  List<Widget> cards = [];

  @override
  void initState() {
    super.initState();
    cards = [
      GestureDetector(
        onTap: () {
          widget.onDetailPerson(
            imageUrl:
                'https://pg11.ru/userfiles/picfullsize/img-53415-14964303316571.jpg',
            name: 'Jane Cooper',
            age: 25,
            job: 'Professional model',
          );
        },
        child: CardSwipe(
          key: ValueKey(1),
          imageUrl:
              'https://pg11.ru/userfiles/picfullsize/img-53415-14964303316571.jpg',
          name: 'Jane Cooper',
          age: 25,
          job: 'Professional model',
        ),
      ),
      GestureDetector(
        onTap: () {
          widget.onDetailPerson(
            imageUrl:
                'https://img.freepik.com/free-photo/portrait-blonde-woman-looking-photographer_23-2148348970.jpg?semt=ais_hybrid&w=740&q=80',
            name: 'Jane Cooper',
            age: 25,
            job: 'Professional model',
          );
        },
        child: CardSwipe(
          key: ValueKey(2),
          imageUrl:
              'https://img.freepik.com/free-photo/portrait-blonde-woman-looking-photographer_23-2148348970.jpg?semt=ais_hybrid&w=740&q=80',
          name: 'Jane Cooper',
          age: 25,
          job: 'Professional model',
        ),
      ),
      GestureDetector(
        onTap: () {
          widget.onDetailPerson(
            imageUrl:
                'https://img.freepik.com/free-photo/attractive-positive-elegant-young-woman-cafe_23-2148071691.jpg?semt=ais_hybrid&w=740&q=80',
            name: 'Jane Cooper',
            age: 25,
            job: 'Professional model',
          );
        },
        child: CardSwipe(
          key: ValueKey(3),
          imageUrl:
              'https://img.freepik.com/free-photo/attractive-positive-elegant-young-woman-cafe_23-2148071691.jpg?semt=ais_hybrid&w=740&q=80',
          name: 'Jane Cooper',
          age: 25,
          job: 'Professional model',
        ),
      ),
    ];
  }

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
        onLike: () {
          widget.onMatch(
            'https://pg11.ru/userfiles/picfullsize/img-53415-14964303316571.jpg',
          );
        },
        onSkip: () {},
        onUndo: () {},
        onOpenDetail: () {
          widget.onDetailPerson(
            imageUrl:
                'https://pg11.ru/userfiles/picfullsize/img-53415-14964303316571.jpg',
            name: 'Jane Cooper',
            age: 25,
            job: 'Professional model',
          );
        },
      ),
    );
  }
}
