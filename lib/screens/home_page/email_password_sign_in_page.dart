part of email_password_sign_in_ui;

class EmailPasswordSignInPage extends StatefulWidget {
  const EmailPasswordSignInPage(
      {Key? key, required this.model, this.onSignedIn})
      : super(key: key);

  final EmailPasswordSignInModel model;
  final VoidCallback? onSignedIn;

  @override
  _EmailPasswordSignInPageState createState() =>
      _EmailPasswordSignInPageState();
}

class _EmailPasswordSignInPageState extends State<EmailPasswordSignInPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
