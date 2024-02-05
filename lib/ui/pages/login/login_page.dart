import 'package:flutter/material.dart';

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
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red[900],
              content: Text(error,textAlign: TextAlign.center, )
              )
           );   
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
                  child: Form(
                    child: Column(children: <Widget>[
                      StreamBuilder<String>(
                          stream: widget.presenter.emailErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  icon: Icon(Icons.email,
                                      color:
                                          Theme.of(context).primaryColorLight),
                                  errorText: snapshot.data?.isEmpty == true
                                      ? null
                                      : snapshot.data),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: widget.presenter.validateEmail,
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 32),
                        child: StreamBuilder<String>(
                            stream: widget.presenter.passwordErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Senha',
                                    icon: Icon(Icons.lock,
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                    errorText: snapshot.data?.isEmpty == true
                                        ? null
                                        : snapshot.data),
                                obscureText: true,
                                onChanged: widget.presenter.validatePassword,
                              );
                            }),
                      ),
                      StreamBuilder<bool>(
                          stream: widget.presenter.isFormValidStream,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed: snapshot.data == true ? widget.presenter.auth : null,
                              child: Text('Entrar'.toUpperCase()),
                            );
                          }),
                      TextButton.icon(
                        icon: const Icon(Icons.person),
                        onPressed: () {},
                        label: const Text('Criar Conta'),
                      ),
                    ]),
                  ),
                )
              ]),
        );
      },
    ));
  }
}
