import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> shareUrl(Uri uri, BuildContext context, TextScaler scaler) async {
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 3.0,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: EdgeInsetsGeometry.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 8.0,
            children: [
              Text(
                'Something went wrong, please try again later.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: scaler.scale(20.0)),
              ),
              Text(
                'Tried to launch URL: $uri',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: scaler.scale(14.0)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      'Okay',
                      style: TextStyle(fontSize: scaler.scale(20.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
