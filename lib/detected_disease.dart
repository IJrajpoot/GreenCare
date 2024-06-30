import 'package:flutter/material.dart';
import 'package:greencare/constants/colors.dart';
import 'package:greencare/widgets/custom_button.dart';

class DetectedDiseaseScreen extends StatefulWidget {
  const DetectedDiseaseScreen({super.key});

  @override
  State<DetectedDiseaseScreen> createState() => _DetectedDiseaseScreenState();
}

class _DetectedDiseaseScreenState extends State<DetectedDiseaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(5),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration:
              const BoxDecoration(color: darkGreen, shape: BoxShape.circle),
          child: const Icon(
            Icons.person_outline_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/wheat.jpg',
                  fit: BoxFit.cover,
                  // width: double.infinity,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Successfuly Detected Disease!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Black Chaff',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: darkGreen,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(text: 'Get First Aid', onPress: () {}),
              const SizedBox(
                height: 20,
              ),
              CustomButton(text: 'Save Results', onPress: () {}),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkGreen,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              label: '', icon: Icon(Icons.question_mark_outlined)),
          BottomNavigationBarItem(
              label: '', icon: Icon(Icons.question_mark_outlined)),
          BottomNavigationBarItem(label: '', icon: Icon(Icons.camera_alt)),
          BottomNavigationBarItem(
              label: '', icon: Icon(Icons.question_mark_outlined)),
          BottomNavigationBarItem(
              label: '', icon: Icon(Icons.question_mark_outlined)),
        ],
      ),
    );
  }
}
