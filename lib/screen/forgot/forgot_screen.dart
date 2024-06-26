import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant.dart';
import 'package:snap_network/helper/button_widget.dart';
import 'package:snap_network/helper/text_widget.dart';
import 'package:snap_network/provider/login_signup/login_signup_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _sendResetLink() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final authProvider = Provider.of<LoginSignupProvider>(context, listen: false);

      try {
        await authProvider.sendPasswordResetEmail(email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reset link sent to $email')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send reset link: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextWidget(text: "Reset Password", size: 18.0),
              SizedBox(height: 50),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 50),
              ButtonWidget(text: "Send Request", onClicked: _sendResetLink, width: Get.width, height: 50.0)
            ],
          ),
        ),
      ),
    );
  }
}
