import 'package:flutter/material.dart';
import 'package:plate_post/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class ServingsAndReadyInSection extends StatelessWidget {
  const ServingsAndReadyInSection(
      {super.key, required this.readyInMinutes, required this.servings});
  final int readyInMinutes;
  final int servings;
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return SizedBox(
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    'Servings  ',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 14,
                          color: settingsManager.darkMode
                              ? Colors.grey
                              : Colors.grey.shade800,
                        ),
                  ),
                  Text(
                    '$servings pp',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Ready In  ',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 14,
                          color: settingsManager.darkMode
                              ? Colors.grey
                              : Colors.grey.shade800,
                        ),
                  ),
                  Text(
                    '${readyInMinutes}m',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
