import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Padding field(Icon icon, String labelText){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ConstrainedBox(
      constraints: BoxConstraints.tight(const Size(200, 50)),
      child: TextFormField(
        decoration: InputDecoration(
            icon: icon,
            labelText: labelText
        ),
        onSaved: (String? value) {
        },
      ),
    ),
  );
}

Center loginPage(GlobalKey<FormState> formKey){
  return Center(
    child: Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.enter): NextFocusIntent(),
      },
      child: FocusTraversalGroup(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          onChanged: () {
            Form.of(primaryFocus!.context!)!.save();
          },
          child: Wrap(children: <Widget>[
            field(const Icon(Icons.login), 'Login'),
            field(const Icon(Icons.password), 'Password'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (formKey.currentState!.validate()) {
                    // Process data.
                  }
                },
                child: const Text('Submit'),
              ),
            )
          ]),
        ),
      ),
    ),
  );
}