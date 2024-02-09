import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/components.dart';
import 'login_presenter.dart';
import '../../components/component.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;
  // ignore: use_key_in_widget_constructors
  const LoginPage(this.presenter);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(
      builder: (context) {
        widget.presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        },);

        widget.presenter.mainErrorStream.listen((error) {
          // ignore: unnecessary_null_comparison
          if (error != null) {
           showErrorMessage(context, error);
          }
        });

        return SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const loginHeader(),
                const HeadLine1(text: 'Login'),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Provider(
                    create: (_) => widget.presenter,
                    child: Form(
                      child: Column(children: <Widget>[
                        const EmailInput(),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 32),
                          child: PasswordInput(),
                        ),
                        const LoginButton(),
                        TextButton.icon(
                          icon: const Icon(Icons.person),
                          onPressed: () {},
                          label: const Text('Criar Conta'),
                        ),
                      ]),
                    ),
                  ),
                )
              ]),
        );
      },
    ));
  }
}

