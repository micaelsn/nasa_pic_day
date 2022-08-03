import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../infra/models/planetary_model.dart';

class PlanetaryListItem extends StatelessWidget {
  final PlanetaryModel planetaryModel;

  const PlanetaryListItem({Key? key, required this.planetaryModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Modular.to.pushNamed('/picture-details', arguments: planetaryModel),
      child: Stack(
        children: [
          Hero(
            tag: planetaryModel.title,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/gifs/giphy.gif',
                image: planetaryModel.url,
                fit: BoxFit.fill,
                placeholderFit: BoxFit.scaleDown,
                width: MediaQuery.of(context).size.width * .9,
                height: 200.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${planetaryModel.title}\n${planetaryModel.date}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
