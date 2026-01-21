import "package:duckyapp/utils/const/font_weight.dart";
import "package:flutter/material.dart";
import "../../utils/const/error_alert_dialog.dart";
import "../../utils/const/note_space.dart";
import "../../utils/const/size/text_size.dart";

class ErrorDialog extends StatelessWidget {
  final String text;

  const ErrorDialog({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(NErrorAlertDialog.radius),
      ),
      titlePadding: EdgeInsets.zero,
      title: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(NErrorAlertDialog.radius),
        ),
        child: Container(
          height: NErrorAlertDialog.height / 3,
          width: double.infinity,
          color: Colors.lightBlue,
        ),
      ),
      content: SizedBox(
        height: NErrorAlertDialog.height,
        width: NErrorAlertDialog.width,
        child: Center(
          child: Column(
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 40 ,),
              SizedBox(height: NSpace.spaceBtwItems / 2),
              Text(
                text,
                style: TextStyle(
                  fontWeight: NFontWeight.boldFontWeight,
                  fontSize: NTextSize.subTitleFontSize,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
