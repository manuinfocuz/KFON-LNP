import 'package:flutter/material.dart';
import 'package:kfon_lnp/utils/style.dart';
import 'package:kfon_lnp/widget/focus_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeEnterScreen extends StatefulWidget {
  const PinCodeEnterScreen({super.key});

  @override
  _PinCodeEnterScreenState createState() => _PinCodeEnterScreenState();
}

class _PinCodeEnterScreenState extends State<PinCodeEnterScreen> {
  String enteredPin = '';
  TextEditingController pinEditingController = TextEditingController();

  void _onKeyTap(String key) {
    setState(() {
      if (key == '12') {
        enteredPin = '';
      } else {
        if (key == "11") {
          if (enteredPin.isNotEmpty) {
            enteredPin = enteredPin.substring(0, enteredPin.length - 1);
          }
        } else {
          enteredPin += key;
        }

        pinEditingController.text = enteredPin;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Image.asset(
                  'assets/images/splash_logo.png',
                  // Replace with your logo image asset
                  width: 150,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Enter Pin",
                style: appTextStyle(),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: PinCodeTextField(
                  controller: pinEditingController,
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  obscuringCharacter: '*',
                  keyboardAppearance: Brightness.dark,
                  keyboardType: TextInputType.none,
                  onChanged: (pin) {},
                  onCompleted: (pin) {
                    setState(() {
                      enteredPin = pin;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: 11,
                itemBuilder: (BuildContext context, int index) {
                  final key = index == 9 ? '0' : '${index + 1}';
                  return GestureDetector(
                    onTap: () => _onKeyTap(key),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: index == 10 || index == 11 ? Colors.grey : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        index == 10 ? "X" : key,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(right: 10, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FocusWidgetGlobal(
                      builder: (bool focus) => Text(
                        "Forgot Pin?",
                        style: appTextStyle(),
                      ),
                      onFocusChange: (bool value) {},
                      onClick: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
