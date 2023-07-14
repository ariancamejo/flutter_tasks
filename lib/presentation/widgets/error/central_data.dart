import 'package:flutter/material.dart';
import 'package:my_tasks/data/const.dart';
import 'package:url_launcher/url_launcher.dart';

centralData({
  required BoxConstraints constraints,
  required ColorScheme scheme,
  Function()? callBack,
  StackTrace? stackTrace,
  required String message,
  required String detail,
  bool small = false,
}) {
  double max = constraints.maxWidth > constraints.maxHeight ? constraints.maxWidth : constraints.maxHeight;
  double min = constraints.maxWidth > constraints.maxHeight ? constraints.maxHeight : constraints.maxWidth;

  return GestureDetector(
    onTap: () => callBack?.call(),
    child: SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber_rounded, size: min * 0.4, color: scheme.error),
          if (!small) Text(stackTrace?.toString() ?? message),
          if (callBack != null) Text(small ? "Press to retry" : "Press warning to retry"),
          if (stackTrace != null)
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Text(stackTrace.toString()),
            ),
          if (!small)
            Tooltip(
              message: "send email to developers",
              child: IconButton(
                onPressed: () => _launchUrl(message: message, detail: detail),
                icon: const Icon(Icons.email),
              ),
            ),
        ],
      ),
    ),
  );
}

Future<void> _launchUrl({StackTrace? stackTrace, required String message, required String detail}) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: kDeveloperEmail,
    queryParameters: {
      'subject': stackTrace ?? message,
      'body': detail,
    },
  );
  launchUrl(emailLaunchUri);
}
