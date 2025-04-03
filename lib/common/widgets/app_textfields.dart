import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitas_clone/common/widgets/text_widgets.dart';
import '../../pages/auth/presentation/providers/sign_in/sign_in_notifier.dart';
import '../../pages/auth/presentation/providers/sign_up/signup_notifier.dart';

final obscureTextProvider = StateProvider.family<bool, String>((ref, id) => true);

class AppTextField extends StatefulWidget {
  final String text;
  final String hintText;
  final bool obscureText;
  final void Function(String value)? func;
  final String? uniqueId;
  final WidgetRef ref;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;

  const AppTextField({
    super.key,
    required this.text,
    this.hintText = "",
    this.obscureText = false,
    this.func,
    this.uniqueId,
    required this.ref,
    this.validator,
    this.prefixIcon,
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasInteracted = false;

  @override
  void initState() {
    super.initState();
    // Detect when the user focuses on the field
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _hasInteracted = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text14Normal(text: widget.text),
          SizedBox(height: 5.h),
          SizedBox(
            width: 325.w,
            child: TextFormField(
              focusNode: _focusNode,
              onChanged: (value) {
                setState(() {
                  _hasInteracted = true; // Mark as interacted when user types
                });
                if (widget.func != null) widget.func!(value);
              },
              keyboardType: widget.hintText.toLowerCase().contains('email')
                  ? TextInputType.emailAddress
                  : TextInputType.text,
              maxLines: 1,
              style: TextStyle(fontSize: 16.sp),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                prefixIcon: widget.prefixIcon ?? (widget.hintText.toLowerCase().contains('email')
                    ? Icon(Icons.email, size: 20, color: Colors.grey)
                    : widget.obscureText
                    ? Icon(Icons.lock, size: 20, color: Colors.grey)
                    : null),
                suffixIcon: widget.obscureText && widget.uniqueId != null
                    ? GestureDetector(
                  onTap: () {
                    widget.ref.read(obscureTextProvider(widget.uniqueId!).notifier).state =
                    !widget.ref.read(obscureTextProvider(widget.uniqueId!));
                  },
                  child: Icon(
                    widget.ref.watch(obscureTextProvider(widget.uniqueId!)) ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                    color: Colors.grey,
                  ),
                )
                    : null,
                contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
              ),
              autocorrect: false,
              obscureText: widget.obscureText && widget.uniqueId != null
                  ? widget.ref.watch(obscureTextProvider(widget.uniqueId!))
                  : widget.obscureText,
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              String? errorMessage;
              if (_hasInteracted && widget.validator != null) {
                String currentValue = '';
                if (widget.text.toLowerCase().contains('email')) {
                  currentValue = ref.watch(signInNotifierProvider).email;
                  if (ref.watch(registerNotifierProvider).email.isNotEmpty) {
                    currentValue = ref.watch(registerNotifierProvider).email;
                  }
                } else if (widget.text.toLowerCase().contains('password')) {
                  currentValue = ref.watch(signInNotifierProvider).password;
                  if (widget.uniqueId == "sign_up_password") {
                    currentValue = ref.watch(registerNotifierProvider).password;
                  } else if (widget.uniqueId == "sign_up_confirm_password") {
                    currentValue = ref.watch(registerNotifierProvider).confirmPassword;
                  }
                } else if (widget.text.toLowerCase().contains('username')) {
                  currentValue = ref.watch(registerNotifierProvider).userName;
                }
                errorMessage = widget.validator!(currentValue);
              }
              return errorMessage != null
                  ? Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                  ),
                ),
              )
                  : SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}