import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class ImprintView extends StatefulWidget {
  const ImprintView({super.key});

  @override
  State<ImprintView> createState() => _ImprintViewState();
}

class _ImprintViewState extends State<ImprintView> {
  TextScaler scaler = TextScaler.linear(1.0);

  @override
  Widget build(BuildContext context) {
    scaler = MediaQuery.textScalerOf(context);

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Imprint',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: scaler.scale(32.0),
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            "Dominique Bauer",
            textScaler: scaler,
            style: TextStyle(
              fontFamily: 'YuseiMagic',
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Text(
            "Austr. 11",
            textScaler: scaler,
            style: TextStyle(
              fontFamily: 'YuseiMagic',
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Text(
            "67378 Zeiskam",
            textScaler: scaler,
            style: TextStyle(
              fontFamily: 'YuseiMagic',
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Text(
            "Germany",
            textScaler: scaler,
            style: TextStyle(
              fontFamily: 'YuseiMagic',
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4.0,
            children: [
              Icon(
                TablerIcons.at,
                size: scaler.scale(16.0),
                color: Theme.of(context).colorScheme.secondary,
              ),
              Text(
                "dom@rottendev.net",
                textScaler: scaler,
                style: TextStyle(
                  fontFamily: 'YuseiMagic',
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.all(4.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4.0,
            children: [
              Icon(
                TablerIcons.world_www,
                size: scaler.scale(16.0),
                color: Theme.of(context).colorScheme.secondary,
              ),
              Text(
                "rottendev.net",
                textScaler: scaler,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
