import 'package:flutter/material.dart';
import 'package:flutter_presensi_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_presensi_app/presentation/home/pages/main_page.dart';
import '../../../core/core.dart';
import 'login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      // () => context.pushReplacement(const LoginPage()),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: FutureBuilder(
        future: AuthLocalDatasource().isAuth(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Assets.images.logoWhite.image(),
                ),
                const Spacer(),
                Assets.images.logoCodeWithBahri.image(height: 70),
                const SpaceHeight(20.0),
              ],
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data! == true) {
              Future.delayed(
                const Duration(seconds: 2),
                () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ),
                ),
              );
            } else {
              Future.delayed(
                const Duration(seconds: 2),
                () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                ),
              );
            }
          }
          return Column(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Assets.images.logoWhite.image(),
              ),
              const Spacer(),
              Assets.images.logoCodeWithBahri.image(height: 70),
              const SpaceHeight(20.0),
            ],
          );
        },
      ),
    );
  }
}
