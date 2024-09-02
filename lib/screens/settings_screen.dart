import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:basel_quiz_app/providers/game_provider.dart';
import 'package:basel_quiz_app/screens/profile_screen.dart';
import 'package:basel_quiz_app/utils/utils.dart';
import 'package:basel_quiz_app/widgets/background_image.dart';
import 'package:basel_quiz_app/widgets/gold_button.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _vibrationValue = 0.5;

  Widget _buildSlider(
      String label, double value, ValueChanged<double> onChanged) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 25),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.orange,
            inactiveTrackColor: Colors.grey,
            trackHeight: 8.0,
            thumbColor: Colors.white,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 20.0,
            ),
            overlayColor: Colors.orange.withOpacity(0.2),
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 1,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.225),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(color: Colors.white, blurRadius: 6),
                    ],
                    borderRadius: BorderRadius.circular(25),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/ui/intro_image.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildSlider("Music", musicVolume, (value) {
                        setState(() {
                          FlameAudio.bgm.audioPlayer.setVolume(value);
                          musicVolume = value;
                        });
                      }),
                      const SizedBox(height: 40),
                      _buildSlider("Vibration", _vibrationValue, (value) {
                        setState(() {
                          _vibrationValue = value;
                        });
                      }),
                    ],
                  ),
                ),
                const Spacer(),
                GoldButton(
                  text: "Profile",
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                GoldButton(
                  text: "Reset Progress",
                  onPressed: () async {
                    final provider =
                        Provider.of<GameProvider>(context, listen: false);
                    await AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'Reset Progress?',
                      desc:
                          'Are you sure you want to reset your progress? This action cannot be undone, and all your current achievements will be lost.',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        await provider.resetProgress();
                      },
                    ).show();
                  },
                ),
                const SizedBox(height: 20),
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
