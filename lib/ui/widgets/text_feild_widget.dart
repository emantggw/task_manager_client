import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final String? hintText;
  final IconData? prefixIcon;
  final Color? fillColor;
  final TextInputType textInputType;
  final bool obscureText;
  final bool onlyUnderlineBorder;
  final bool enableMultiLine;
  final bool isReadOnly;
  final double borderRadius;
  final Widget? suffixWidget;
  final String? initialValue;
  final TextEditingController? controller;
  const TextFieldWidget(
      {super.key,
      this.onChanged,
      this.onTap,
      this.prefixIcon,
      this.initialValue,
      this.isReadOnly = false,
      this.textInputType = TextInputType.name,
      this.hintText = "",
      this.obscureText = false,
      this.onlyUnderlineBorder = false,
      this.enableMultiLine = false,
      this.borderRadius = 20,
      this.fillColor,
      this.validator,
      this.suffixWidget,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: controller != null ? null : initialValue,
        controller: controller,
        readOnly: isReadOnly,
        onChanged: onChanged,
        validator: validator,
        autofocus: false,
        obscureText: obscureText,
        onTap: onTap,
        // style: kfBodyMedium(context),
        keyboardType: textInputType,
        maxLines: enableMultiLine ? null : 1,
        decoration: InputDecoration(
            hintText: hintText,
            // hintStyle: AppTheme.getTextStyle(themeData.textTheme.subtitle2,
            //     letterSpacing: 0.1, color: Colors.black54, fontWeight: 500),
            border: onlyUnderlineBorder
                ? UnderlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius),
                    ),
                    borderSide: BorderSide(
                        width: 2, color: Theme.of(context).primaryColor))
                : UnderlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius),
                    ),
                    borderSide: const BorderSide(width: 5),
                  ),
            enabledBorder: onlyUnderlineBorder
                ? UnderlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius),
                    ),
                    borderSide: BorderSide(
                        width: 2, color: Theme.of(context).primaryColor))
                : OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius),
                    ),
                    borderSide: BorderSide.none),
            focusedBorder: onlyUnderlineBorder
                ? UnderlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius),
                    ),
                    borderSide: BorderSide(
                        width: 2, color: Theme.of(context).primaryColor))
                : OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius),
                    ),
                    borderSide: BorderSide.none,
                  ),
            filled: true,
            // fillColor: kcPrimary(context).withOpacity(0.1),
            prefixIcon: Icon(
              prefixIcon,
            ),
            suffixIcon: suffixWidget));
  }
}
