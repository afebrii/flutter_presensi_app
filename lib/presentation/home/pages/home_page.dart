import 'package:flutter/material.dart';
import 'package:flutter_presensi_app/core/core.dart';
import 'package:flutter_presensi_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_presensi_app/presentation/home/pages/register_face_attendance_page.dart';
import 'package:flutter_presensi_app/presentation/home/pages/setting_page.dart';

import '../widgets/menu_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? faceEmbedding;

  @override
  void initState() {
    _initializeFaceEmbedding();
    super.initState();
  }

  Future<void> _initializeFaceEmbedding() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      setState(() {
        faceEmbedding = authData?.user?.faceEmbedding;
      });
    } catch (e) {
      // Tangani error di sini jika ada masalah dalam mendapatkan authData
      print('Error fetching auth data: $e');
      setState(() {
        faceEmbedding = null; // Atur faceEmbedding ke null jika ada kesalahan
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.bgHome.provider(),
              alignment: Alignment.topCenter,
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://i.pinimg.com/originals/1b/14/53/1b14536a5f7e70664550df4ccaa5b231.jpg',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SpaceWidth(12),
                  const Expanded(
                    child: Text(
                      'Hello, Andika Febriansyah',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.white,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Assets.icons.notificationRounded.svg(),
                  ),
                ],
              ),
              const SpaceHeight(24),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      DateTime.now().toFormattedTime(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      DateTime.now().toFormattedDate(),
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                    const SpaceHeight(18.0),
                    const Divider(),
                    const SpaceHeight(30.0),
                    Text(
                      DateTime.now().toFormattedDate(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                    const SpaceHeight(6.0),
                    Text(
                      '${DateTime(2024, 3, 14, 8, 0).toFormattedTime()} - ${DateTime(2024, 3, 14, 16, 0).toFormattedTime()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SpaceHeight(80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    MenuButton(
                      iconPath: Assets.icons.menu.datang.path,
                      label: "Datang",
                      onPressed: () {},
                    ),
                    MenuButton(
                      iconPath: Assets.icons.menu.datang.path,
                      label: "Pulang",
                      onPressed: () {},
                    ),
                    MenuButton(
                      iconPath: Assets.icons.menu.datang.path,
                      label: "Izin",
                      onPressed: () {},
                    ),
                    MenuButton(
                      iconPath: Assets.icons.menu.datang.path,
                      label: "Catatan",
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SpaceHeight(24),
              faceEmbedding != null
                  ? Button.filled(
                      onPressed: () {
                        // context.push(const SettingPage());
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const SettingPage()),
                        );
                      },
                      label: 'Attendance Using Face ID',
                      icon: Assets.icons.attendance.svg(),
                      color: AppColors.primary,
                    )
                  : Button.filled(
                      onPressed: () {
                        showBottomSheet(
                          backgroundColor: AppColors.white,
                          context: context,
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  width: 60.0,
                                  height: 8.0,
                                  child: Divider(color: AppColors.lightSheet),
                                ),
                                const CloseButton(),
                                const Center(
                                  child: Text(
                                    'Oops !',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                                const SpaceHeight(4.0),
                                const Center(
                                  child: Text(
                                    'Aplikasi ingin mengakses Kamera',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                                const SpaceHeight(36.0),
                                Button.filled(
                                  onPressed: () {},
                                  label: 'Tolak',
                                  color: AppColors.secondary,
                                ),
                                const SpaceHeight(16.0),
                                Button.filled(
                                  onPressed: () {
                                    // context.pop();
                                    // context.push(const AttendancePage());
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterFaceAttendancePage(),
                                      ),
                                    );
                                  },
                                  label: 'Izinkan',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      label: 'Attendance Using Face ID',
                      icon: Assets.icons.attendance.svg(),
                      color: AppColors.red,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
