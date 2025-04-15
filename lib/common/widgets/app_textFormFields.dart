import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/core/constants/app_colors.dart';


class AppTextFormField extends ConsumerStatefulWidget {
  final String text;
  final String? errorText;
  final String? Function(String?, bool)? validator;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final bool? autofocus;
  final bool readonly;
  final bool autocorrect;
  final String? Function(String?)? onchanged;
  final VoidCallback? onTap;
  final String? hintText;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final bool isRequired;

  const AppTextFormField(
      {super.key,
      required this.text,
      this.errorText,
      this.validator,
      this.keyboardType,
      this.style,
      this.autofocus,
      this.readonly = false,
      this.autocorrect = false,
      this.onchanged,
      this.onTap,
      this.hintText,
      required this.controller,
      this.inputFormatters,
      required this.isRequired});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AppTextForrmFieldState();
  }
}

class AppTextForrmFieldState extends ConsumerState<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.text,
            style: TextStyle(
              fontSize: 13,
              color: grayscale[600],
            ),
          ),
          TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide:
                        BorderSide(color: colorGrayscale[500]!, width: 0.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: Colors.red, width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide(color: colorPurple, width: 0.5),
                    gapPadding: 10.0,
                  ),
                  filled: true,
                  fillColor: Colors.white),
              validator: (value) {
                print('Validating field: ${widget.text} => $value');
                if (widget.validator != null) {
                  return widget.validator!(value, widget.isRequired);
                }
                return null;
              },
              style: widget.style,
              onChanged: widget.onchanged,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: widget.inputFormatters,
              controller: widget.controller)
        ],
      ),
    );
  }
}
