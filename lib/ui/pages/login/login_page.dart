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
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged:  presenter.validateEmail,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 32),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight)
                      ),
                      obscureText: true,
                      onChanged:  presenter.validatePassword,
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