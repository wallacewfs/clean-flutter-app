import 'package:flutter/material.dart';

import '../components/component.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          loginHeader(),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 32),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight)
                      ),
                      obscureText: true,
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