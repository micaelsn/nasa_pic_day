import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_pic_day/app/modules/home/domain/entities/planetary.dart';

class PlanetaryListItem extends StatelessWidget {
  final Planetary planetary;

  const PlanetaryListItem({Key? key, required this.planetary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Modular.to.pushNamed('/picture-details', arguments: planetary),
      child: Stack(
        children: [
          Hero(
            tag: planetary.title,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/gifs/giphy.gif',
                image: planetary.url,
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
                  '${planetary.title}\n${planetary.date}',
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
