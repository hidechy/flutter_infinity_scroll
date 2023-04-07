import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard(
      {super.key,
      required this.imageUrl,
      required this.likes,
      required this.views});

  final String imageUrl;
  final int likes;
  final int views;

  ///
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: Colors.black,
      elevation: 15,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Image.network(
              imageUrl,
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.3,
              fit: BoxFit.cover,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text("$likes")
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.remove_red_eye,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text("$views")
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
