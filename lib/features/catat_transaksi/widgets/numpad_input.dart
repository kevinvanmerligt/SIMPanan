import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class NumpadInput extends StatelessWidget {
  final ValueChanged<String> onNumberTap;
  final VoidCallback onBackspace;

  const NumpadInput({
    super.key,
    required this.onNumberTap,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '000', '0', 'DEL'];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: keys.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final key = keys[index];
        return InkWell(
          onTap: () {
            if (key == 'DEL') {
              onBackspace();
            } else {
              onNumberTap(key);
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.inputBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.cardBorder),
            ),
            child: key == 'DEL'
                ? Icon(Icons.backspace_outlined, size: 20, color: colors.textPrimary)
                : Text(
                    key,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
          ),
        );
      },
    );
  }
}