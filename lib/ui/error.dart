import 'package:robo_coffee_app/lang/translator.dart';
import 'package:flutter/material.dart';

class ErrorRetry extends StatelessWidget {
  final Function onRetry;
  final bool isNetworkError;

  ErrorRetry({@required this.onRetry, this.isNetworkError = false});

  @override
  Widget build(BuildContext context) {
    var trans = Translator.of(context);
    var theme = Theme.of(context);
    var errorTitle;
    var errorText;
    var errorIcon;

    if (isNetworkError) {
      errorTitle = trans.trans("network_error_title");
      errorText = trans.trans("network_error_text");
      errorIcon = Icon(Icons.signal_wifi_off, color: Colors.grey, size: 80);
    } else {
      errorTitle = trans.trans("unknown_error_title");
      errorText = trans.trans("unknown_error_text");
      errorIcon = Icon(Icons.error, color: Colors.grey, size: 80);
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            errorIcon,
            SizedBox(height: 16),
            Text(errorTitle, style: theme.textTheme.title),
            SizedBox(height: 8),
            Text(errorText),
            SizedBox(height: 16),
            FlatButton(
                color: theme.primaryColor,
                textColor: theme.accentTextTheme.title.color,
                child: Text(trans.trans("try_to_refresh_button_title")),
                onPressed: () {
                  onRetry();
                })
          ],
        ),
      ),
    );
  }
}


