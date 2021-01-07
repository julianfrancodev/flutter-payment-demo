part of 'helpers.dart';

showLoading(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            title: Text("Espere..."),
            content: LinearProgressIndicator(),
          ));
}

showAlert(BuildContext context, String title, String message) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Ok"),
              )
            ],
          ));
}
