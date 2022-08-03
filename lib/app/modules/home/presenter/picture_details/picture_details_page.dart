import 'package:flutter/material.dart';

import '../../infra/models/planetary_model.dart';

class PictureDetailsPage extends StatelessWidget {
  final PlanetaryModel planetaryModel;

  const PictureDetailsPage({Key? key, required this.planetaryModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: planetaryModel.title,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/gifs/giphy.gif',
              image: planetaryModel.url,
              fit: BoxFit.fill,
              placeholderFit: BoxFit.scaleDown,
              width: MediaQuery.of(context).size.width,
              height: 200.0,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${planetaryModel.title}\n${planetaryModel.date}',
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
            planetaryModel.explanation,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
