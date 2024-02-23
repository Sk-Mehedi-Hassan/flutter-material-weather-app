import 'package:flutter/material.dart';

class CentralMessage extends StatelessWidget {
  const CentralMessage({
    required this.iconData,
    required this.message,
    super.key,
  });

  final IconData iconData;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: Theme.of(context).colorScheme.secondary,
            size: MediaQuery.of(context).size.width * .3,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            message,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
            ),
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
