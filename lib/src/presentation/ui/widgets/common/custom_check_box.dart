import 'package:flutter/material.dart';
import 'package:jnote/src/utils/constants/jnote_icons.dart';
import 'package:jnote/src/utils/constants/strings.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    Key? key,
    this.isChecked = false,
    this.onChanged,
  }) : super(key: key);

  final bool isChecked;
  final void Function(bool isChecked)? onChanged;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.onChanged?.call(isChecked);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          children: [
            Icon(
              isChecked ? JNoteIcons.checked : JNoteIcons.check,
              color: isChecked
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).unselectedWidgetColor,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                markAsCompleted,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
