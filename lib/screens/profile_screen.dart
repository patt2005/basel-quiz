import 'dart:io';
import 'package:basel_quiz_app/providers/game_provider.dart';
import 'package:basel_quiz_app/utils/utils.dart';
import 'package:basel_quiz_app/widgets/background_image.dart';
import 'package:basel_quiz_app/widgets/gold_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? imageFile;

  TextEditingController nicknameController = TextEditingController();

  void _showNicknameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Set Your Nickname'),
          content: TextField(
            controller: nicknameController,
            decoration: const InputDecoration(
              hintText: 'Enter your nickname',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red),
              ),
              onPressed: () async {
                String nickname = nicknameController.text;
                Provider.of<GameProvider>(context, listen: false)
                    .setNickname(nickname);
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init(context));
  }

  void _init(BuildContext context) async {
    final provider = Provider.of<GameProvider>(context, listen: false);
    await provider.loadImagePath();
    await provider.getNickname();
    if (provider.profileImagePath.isNotEmpty) {
      imageFile = File(provider.profileImagePath);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context, listen: false);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.07),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: imageFile != null
                      ? Image.file(
                          imageFile!,
                          width: screenSize.width,
                          fit: BoxFit.cover,
                          height: screenSize.height * 0.225,
                        )
                      : Image.asset(
                          "assets/images/ui/profile_image.png",
                          width: screenSize.width,
                          fit: BoxFit.cover,
                          height: screenSize.height * 0.225,
                        ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                Container(
                  padding: const EdgeInsets.all(13),
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF737373),
                        Color(0xFFD9D9D9),
                        Color(0xFF737373)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Consumer<GameProvider>(
                      builder: (context, value, child) => Text(
                        value.nickName.isNotEmpty ? value.nickName : "Nickname",
                        style: const TextStyle(
                          fontSize: 23,
                          color: Color(0xFFA01D48),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GoldButton(
                  text: "Set nickname",
                  onPressed: () {
                    _showNicknameDialog(context);
                  },
                ),
                const SizedBox(height: 15),
                GoldButton(
                  text: "Set profile picture",
                  onPressed: () async {
                    final imagePicker = ImagePicker();
                    final image = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (image != null) {
                      final cacheDir = await getTemporaryDirectory();
                      final filePath =
                          path.join(cacheDir.path, 'profile_picture.png');
                      final savedImage = await File(image.path).copy(filePath);
                      setState(() {
                        imageFile = savedImage;
                      });
                      provider.setProfileImagePath(filePath);
                    }
                  },
                ),
                const SizedBox(height: 15),
                GoldButton(
                  text: "Back",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: screenSize.height * 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
