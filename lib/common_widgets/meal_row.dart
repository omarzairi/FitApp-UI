import 'package:fitapp/classes/Aliment.dart';
import 'package:fitapp/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class MealRow extends StatelessWidget {
  final Aliment aliment;
  final bool selected;
  final VoidCallback onTap;

  const MealRow({
    Key? key,
    required this.aliment,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                    color: Colors.black26,
                    blurRadius: 5, // This adds the shadow
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(aliment.image!),
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
                    aliment.name,
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${aliment.calories} | ${aliment.servingSize} ${aliment.servingUnit}",
                    style: TextStyle(color: TColor.gray, fontSize: 12),
                  ),
                ],
              ),
            ),
            CustomCheckbox(
              value: selected,
              onChanged: (value) {
                onTap();
              },
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
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value ? TColor.secondaryColor1 : Colors.white,
          border: value ? null : Border.all(color: Colors.black26),
        ),
        child: Center(
          child: value
              ? const Icon(
                  Icons.check,
                  size: 18,
                  color: Colors.white,
                )
              : const Icon(Icons.add, size: 18, color: Colors.black26),
        ),
      ),
    );
  }
}
