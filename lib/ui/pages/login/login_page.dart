import 'package:flutter/material.dart';

import 'login_presenter.dart';
import '../../components/component.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;
  // ignore: use_key_in_widget_constructors
  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const loginHeader(),
          const HeadLine1(text: 'Login'),
           Padding(
             padding: const EdgeInsets.all(32),
             child: Form(
              child: Column(
                children: <Widget>[
                  StreamBuilder<dynamic>(
                    stream: presenter.emailErrorStream,
                    builder: (context, snapshot) {
                      return TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
                          errorText: snapshot.data?.isEmpty == true ? null : snapshot.data                
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged:  presenter.validateEmail,
                      );
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 32),
                    child: StreamBuilder<dynamic>(
                      stream: presenter.passwordErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                          ),
                          obscureText: true,
                          onChanged:  presenter.validatePassword,
                        );
                      }
                    ),
                  ),
                  ElevatedButton(onPressed: null,                      
                    child: Text('Entrar'.toUpperCase()),
                  ),
                  TextButton.icon(icon: const Icon(Icons.person),
                                  onPressed: () {},
                                  label: const Text('Criar Conta'),
                  ),
                ]),),
           )
        ]),
    )
    );
  }
}