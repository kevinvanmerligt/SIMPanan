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
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: key == 'DEL'
                ? const Icon(Icons.backspace_outlined, size: 20)
                : Text(
                    key,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
          ),
        );
      },
    );
  }
}