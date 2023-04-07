// ignore_for_file: must_be_immutable

import '../state/search_result_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'search_result_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  String searchQuery = "";

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("画像スクロール検索"),
      ),

      //

      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    onChanged: (value) {
                      searchQuery = value;
                    },
                    decoration: const InputDecoration(
                      hintText: '検索する画像',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    //

                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: ElevatedButton(
                        onPressed: () {
                          ref.watch(searchQeuryProvider.notifier).state =
                              searchQuery;
                          ref.read(pageProvider.notifier).state = 1;

                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return const SearchResultScreen();
                              },

                              //

                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const Offset begin = Offset(1.0, 0.0);

                                const Offset end = Offset.zero;

                                final Animatable<Offset> tween =
                                    Tween(begin: begin, end: end).chain(
                                  CurveTween(curve: Curves.easeInOut),
                                );

                                final Animation<Offset> offsetAnimation =
                                    animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },

                              //
                            ),
                          );
                        },
                        child: const Text("検索"),
                      ),
                    );

                    //
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),

      //
    );
  }
}
