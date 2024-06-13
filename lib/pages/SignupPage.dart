import 'package:dalak_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:dalak_app/controllers/FormValidator.dart';
import 'package:dalak_app/providers/SignupFormProvider.dart';
import 'package:dalak_app/widgets/CustomAppBar.dart';
import 'package:dalak_app/widgets/LoginSignupInput.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

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
                  controller: signupProvider.usernameController,
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
                  controller: signupProvider.emailController,
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
                  controller: signupProvider.passwordController,
                  labelText: "Password",
                  hintText: "Enter your password",
                  prefixIcon: Icons.lock,
                  keyBoardType: TextInputType.visiblePassword,
                  obscureText: signupProvider.showPassword,
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
                      try {
                        await auth.signInWithEmailAndPassword(
                          email: signupProvider.emailController.text,
                          password: signupProvider.passwordController.text,
                        );
                      } catch (err) {
                        print(err);
                      }
                    }
                  },
                  style: const ButtonStyle(),
                  child: const Text("Create account"),
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
