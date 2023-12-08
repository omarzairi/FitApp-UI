import 'package:fitapp/models/Aliment.dart';
import 'package:fitapp/models/Coach.dart';
import 'package:fitapp/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:food_icons/food_icons.dart';

class CoachRow extends StatelessWidget {
  final Coach coach;
  final bool selected;
  final VoidCallback onTap;

  const CoachRow({
    Key? key,
    required this.coach,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  String formatNumber(double num) {
    return num % 1 == 0 ? num.toInt().toString() : num.toString();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(

      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: TColor.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
        ),
        child: Row(
          children: [
            Container(
              width: 65, // Set your desired width here
              height: 65, // Set your desired height here
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // This makes the sides round
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6, // This adds the shadow
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(coach.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coach.nom.toUpperCase()! + " " + coach.prenom.toUpperCase()!,
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                onTap();
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomCheckbox(
                  value: selected,
                  onChanged: (value) {
                    onTap();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value ? TColor.primaryColor1 : Colors.white,
          border: value ? null : Border.all(color: TColor.primaryColor1),
        ),
        child: Center(
          child: value
              ?  Icon(
            Icons.remove_red_eye_outlined,
            size: 18,
            color: Colors.white,
          )
              :  Icon(Icons.remove_red_eye, size: 18, color: TColor.primaryColor1),
        ),
      ),
    );
  }
}
