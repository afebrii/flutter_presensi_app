import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_presensi_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_presensi_app/presentation/home/pages/main_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/core.dart';
import '../bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool isShowPassword = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpaceHeight(50),
            Image.asset(
              Assets.images.logo.path,
              width: MediaQuery.of(context).size.width,
              height: 100,
            ),
            const SpaceHeight(107),
            CustomTextField(
              controller: emailController,
              label: "Email Address",
              showLabel: false,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  Assets.icons.email.path,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
            const SpaceHeight(20),
            CustomTextField(
              controller: passwordController,
              label: "Password",
              showLabel: false,
              obscureText: !isShowPassword,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  Assets.icons.password.path,
                  height: 20,
                  width: 20,
                ),
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  icon: Icon(
                    isShowPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.grey,
                  )),
            ),
            const SpaceHeight(104),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  sucess: (data) {
                    AuthLocalDatasource().saveAuthData(data);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                    );
                  },
                  error: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error),
                        backgroundColor: AppColors.red,
                      ),
                    );
                  },
                );
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button.filled(
                          onPressed: () {
                            // Navigator.of(context).pushReplacement(MaterialPageRoute(
                            //     builder: (context) => const MainPage()));
                            context.read<LoginBloc>().add(
                                  LoginEvent.login(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                );
                          },
                          label: "Sign In");
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
