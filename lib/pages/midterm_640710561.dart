import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCal extends StatefulWidget {
  const MyCal({Key? key}) : super(key: key);

  @override
  State<MyCal> createState() => _MyCalState();
}

class _MyCalState extends State<MyCal> {
  var _text = "0";

  static const addSign = "\u002B";
  static const subtractSign = "\u2212";
  static const multiplySign = "\u00D7";
  static const divideSign = "\u00F7";
  static const equalSign = "\u003D";

  bool isMathOperationSign(String character) {
    return character == addSign ||
        character == subtractSign ||
        character == multiplySign ||
        character == divideSign;
  }

  Widget buildItem({
    IconData? icon,
    String? label,
    required String number,
    Color color = Colors.black,
  }) {
    Widget childWidget;

    // Assign different colors based on the button type
    Color? buttonColor = Colors.lightBlue[200];

    if (number == "C" ||
        number == "" ||
        number == "=" ||
        number == addSign ||
        number == subtractSign ||
        number == multiplySign ||
        number == divideSign) {
      buttonColor =
          Colors.green; // Color for "C", backspace, and mathematical signs
    }

    if (number == equalSign) {
      buttonColor = Colors.orange; // Color for "="
    }

    double fontSize = (number == "0")
        ? 20.0
        : 24.0; // Adjust font size for "0" to match other numeric buttons

    if (number == "") {
      childWidget = Icon(icon, color: color);
    } else {
      childWidget = Text(
        number,
        textAlign: TextAlign.center,
        style: GoogleFonts.notoSansThai(
          color: color,
          fontSize: fontSize,
        ),
      );
    }

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            if (number == "C" || number == "=") {
              _text = "0";
            } else if (number == "" && icon == Icons.backspace) {
              _text =
                  _text.length > 1 ? _text.substring(0, _text.length - 1) : "0";
            } else if (_text == "0" || _text.contains('_')) {
              // If the displayed number is "0" or contains an underscore,
              // replace it with the selected number or sign
              _text = number;
            } else if (_text == "0" || _text.contains('_')) {
              // If the displayed number is "0" or contains an underscore,
              // replace it with the selected number only if the last character is not a sign
              _text = (_text == "0" && number != "0") ||
                      _text.contains('_') ||
                      _text.isEmpty
                  ? number
                  : (_text.endsWith(addSign) ||
                          _text.endsWith(subtractSign) ||
                          _text.endsWith(multiplySign) ||
                          _text.endsWith(divideSign)
                      ? (isMathOperationSign(number) ? _text : number)
                      : number);
            } else if (isMathOperationSign(number)) {
              // If the new character is a mathematical operation sign,
              // and the last character is not a mathematical operation sign, add it
              if (!isMathOperationSign(_text[_text.length - 1])) {
                _text += number;
              }
            } else {
              _text += number;
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          decoration: number.isNotEmpty
              ? BoxDecoration(
                  color: buttonColor,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                )
              : null,
          child: Center(child: childWidget),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var itemList = [
      SizedBox(height: 60.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            _text,
            style: GoogleFonts.poppins(
                fontSize: 50.0,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ],
      ),
      SizedBox(height: 50.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildItem(number: "C"),
          SizedBox(width: 10.0),
          buildItem(number: "", icon: Icons.backspace),
        ],
      ),
      SizedBox(height: 10.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildItem(number: "7"),
          SizedBox(width: 10.0),
          buildItem(number: "8"),
          SizedBox(width: 10.0),
          buildItem(number: "9"),
          SizedBox(width: 10.0),
          buildItem(number: divideSign),
        ],
      ),
      SizedBox(height: 10.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildItem(number: "4"),
          SizedBox(width: 10.0),
          buildItem(number: "5"),
          SizedBox(width: 10.0),
          buildItem(number: "6"),
          SizedBox(width: 10.0),
          buildItem(number: multiplySign),
        ],
      ),
      SizedBox(height: 10.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildItem(number: "1"),
          SizedBox(width: 10.0),
          buildItem(number: "2"),
          SizedBox(width: 10.0),
          buildItem(number: "3"),
          SizedBox(width: 10.0),
          buildItem(number: subtractSign),
        ],
      ),
      SizedBox(height: 10.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildItem(number: "0"),
          SizedBox(width: 10.0),
          buildItem(number: addSign),
        ],
      ),
      SizedBox(height: 10.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildItem(number: equalSign),
        ],
      ),
    ];
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Use the responsive layout for larger screens
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: itemList,
                ),
              ),
            );
          } else {
            // Use a different layout for smaller screens
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: itemList,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
