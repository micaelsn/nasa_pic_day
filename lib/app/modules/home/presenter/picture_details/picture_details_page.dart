import 'package:flutter/material.dart';

import '../../domain/entities/planetary.dart';

class PictureDetailsPage extends StatelessWidget {
  final Planetary planetary;

  const PictureDetailsPage({Key? key, required this.planetary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: planetary.title,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/gifs/giphy.gif',
                image: planetary.url,
                fit: BoxFit.fill,
                placeholderFit: BoxFit.scaleDown,
                width: MediaQuery.of(context).size.width,
                height: 200.0,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${planetary.title}\n${planetary.date}',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Explanation ',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Expanded(
                    child: Divider(
                  color: Theme.of(context).primaryColor,
                )),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              planetary.explanation,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
