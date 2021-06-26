import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_notes_app/routing/app_routes.dart';
import 'package:workout_notes_app/services/keys.dart';
import 'package:workout_notes_app/services/providers.dart';
import 'package:workout_notes_app/services/sign_in.dart';

final signInModelProvider = ChangeNotifierProvider<SignInViewModel>(
  (ref) => SignInViewModel(
    auth: ref.watch(firebaseAuthProvider),
  ),
);

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final signInModel = watch(signInModelProvider);
    return ProviderListener<SignInViewModel>(
      provider: signInModelProvider,
      onChange: (context, model) async {
        if (model.error != null) {
          await Text(
            "Sign In failed",
          ); //TODO: make it pretty

        }
      },
      child: SignInPageContents(
        viewModel: signInModel,
      ),
    );
  }
}

class SignInPageContents extends StatelessWidget {
  const SignInPageContents({Key? key, required this.viewModel})
      : super(key: key);

  final SignInViewModel viewModel;

  static const Key emailPasswordButtonKey = Key(Keys.emailPassword);
  static const Key anonymousButtonKey = Key(Keys.anonymous);

  Future<void> _showEmailPasswordSignInPage(BuildContext context) async {
    final navigator = Navigator.of(context);
    await navigator.pushNamed(
      AppRoutes.emailPasswordSignInPage,
      arguments: () => navigator.pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSignIn(context),
    );
  }

  Widget _buildHeader() {
    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return const Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: min(constraints.maxWidth, 600),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 32.0,
                ),
                SizedBox(
                  height: 50.0,
                  child: _buildHeader(),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                TextButton(
                  key: emailPasswordButtonKey,
                  child: Text("Sign In With Email and Password"),
                  onPressed: viewModel.isLoading
                      ? null
                      : () => _showEmailPasswordSignInPage(context),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "or",
                  style: TextStyle(fontSize: 14.0, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextButton(
                  key: anonymousButtonKey,
                  child: Text(
                    "anonymously",
                  ),
                  onPressed:
                      viewModel.isLoading ? null : viewModel.signInAnonymously,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
