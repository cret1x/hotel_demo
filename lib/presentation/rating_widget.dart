import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final int rating;
  final String ratingName;
  const RatingWidget({super.key, required this.rating, required this.ratingName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 150,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color.fromARGB(30, 255, 199, 0),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                color: Color.fromARGB(255, 255, 168, 0),
              ),
              Text(
                "$rating $ratingName",
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 168, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}