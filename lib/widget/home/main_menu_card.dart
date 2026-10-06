import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/global_functions.dart';
import '../../utils/style.dart';

class MainMenuCard extends StatelessWidget {
  final String title;
  final String count;
  final String icon;
  final Function() onClick;
  final int index;

  const MainMenuCard(
      this.title, this.count, this.icon, this.onClick, this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var colorsToShow = [
      primaryColor,
      secondaryColor,
      accentColor,
    ];
    Color color = Colors.white; // colorsToShow[index % colorsToShow.length];

    return InkWell(
      onTap: () {
        onClick();
      },
      child: Card(
        elevation: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    4,
                  ),
                  child: SvgPicture.asset(
                    icon,
                    height: 40,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    count,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
