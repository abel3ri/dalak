import 'package:dalak_blog_app/controllers/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:dalak_blog_app/controllers/FormValidator.dart';
import 'package:dalak_blog_app/providers/SignupFormProvider.dart';
import 'package:dalak_blog_app/widgets/CustomAppBar.dart';
import 'package:dalak_blog_app/widgets/LoginSignupInput.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupFormProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.03,
          horizontal: MediaQuery.of(context).size.width * 0.06,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: signupProvider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Create Account",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  "Follow the simple steps",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                FormInputField(
                  controller: _usernameController,
                  labelText: "Username",
                  hintText: "Enter your username",
                  prefixIcon: Icons.person,
                  keyBoardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: FormValidator.usernameValidator,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                FormInputField(
                  controller: _emailController,
                  labelText: "Email",
                  hintText: "Enter your E-mail",
                  prefixIcon: Icons.email,
                  keyBoardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: FormValidator.emailValidator,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                FormInputField(
                  controller: _passwordController,
                  labelText: "Password",
                  hintText: "Enter your password",
                  prefixIcon: Icons.lock,
                  keyBoardType: TextInputType.visiblePassword,
                  obscureText: !signupProvider.showPassword,
                  sufficIcon: signupProvider.showPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  onSuffixIconTap: signupProvider.toggleShowPassword,
                  textInputAction: TextInputAction.done,
                  validator: FormValidator.passwordValidator,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                FilledButton(
                  onPressed: () async {
                    if (signupProvider.formKey.currentState!.validate()) {
                      signupProvider.toggleIsLoading();
                      final res = await AuthController.signupUser(
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      signupProvider.toggleIsLoading();

                      res.fold((l) => {l.showError(context)}, (r) {
                        GoRouter.of(context).pushReplacementNamed("homePage");
                      });
                    }
                  },
                  child: signupProvider.isLoading
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text("Create account"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).pushReplacementNamed("login");
                      },
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
