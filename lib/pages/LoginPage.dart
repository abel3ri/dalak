import 'package:dalak_blog_app/controllers/AuthController.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dalak_blog_app/controllers/FormValidator.dart';
import 'package:dalak_blog_app/providers/LoginFormProvider.dart';
import 'package:dalak_blog_app/widgets/CustomAppBar.dart';
import 'package:dalak_blog_app/widgets/LoginSignupInput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailUsernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailUsernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginFormProvider>(context);
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
            key: loginProvider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  "Login to access all features",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                FormInputField(
                  controller: _emailUsernameController,
                  labelText: "Username or Email",
                  hintText: "Enter your username or email",
                  prefixIcon: Icons.person,
                  keyBoardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: FormValidator.usernameValidator,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                FormInputField(
                  controller: _passwordController,
                  labelText: "Password",
                  hintText: "Enter your password",
                  prefixIcon: Icons.lock,
                  sufficIcon: loginProvider.showPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  keyBoardType: TextInputType.visiblePassword,
                  obscureText: !loginProvider.showPassword,
                  onSuffixIconTap: loginProvider.toggleShowPassword,
                  textInputAction: TextInputAction.done,
                  validator: FormValidator.passwordValidator,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot password?",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: () async {
                    if (loginProvider.formKey.currentState!.validate()) {
                      loginProvider.toggleIsLoading();
                      final res = await AuthController.loginUser(
                        emailUsername: _emailUsernameController.text,
                        password: _passwordController.text,
                      );
                      loginProvider.toggleIsLoading();
                      res.fold((l) {
                        l.showError(context);
                      }, (r) {
                        GoRouter.of(context).pushReplacementNamed("homePage");
                      });
                    }
                  },
                  child: loginProvider.isLoading
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text("Login"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).pushReplacementNamed("signup");
                      },
                      child: Text(
                        "Create account",
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
