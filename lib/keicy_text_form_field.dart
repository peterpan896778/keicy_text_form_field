library keicy_text_form_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KeicyTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? width;
  final InputBorder border;
  final InputBorder? focusedBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final EdgeInsetsGeometry contentPadding;
  final bool autofocus;
  final bool readOnly;
  final bool obscureText;
  final TextStyle? style;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final bool isImpot;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextStyle? errorStyle;
  final int errorMaxLines;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final int maxLines;
  final Widget? prefix;
  final Widget? prefixIcon;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final BoxConstraints? prefixIconConstraints;
  final Widget? suffix;
  final Widget? suffixIcon;
  final String? suffixText;
  final TextStyle? suffixStyle;
  final BoxConstraints? suffixIconConstraints;
  final double? passIconSize;
  final Color? passIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String)? validator;
  final Function(String)? onSaved;
  final Function()? onTap;

  const KeicyTextFormField({
    Key? key,
    this.controller,
    this.focusNode,
    this.width,
    this.border = const OutlineInputBorder(),
    this.focusedBorder,
    this.disabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    this.autofocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.style,
    this.hintText,
    this.hintStyle,
    this.isImpot = false,
    this.labelText,
    this.labelStyle,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.errorStyle,
    this.errorMaxLines = 1,
    this.textAlign = TextAlign.start,
    this.textInputAction = TextInputAction.done,
    this.keyboardType,
    this.maxLines = 1,
    this.prefix,
    this.prefixIcon,
    this.prefixText,
    this.prefixStyle,
    this.prefixIconConstraints,
    this.suffix,
    this.suffixIcon,
    this.suffixText,
    this.suffixStyle,
    this.suffixIconConstraints,
    this.passIconSize = 20,
    this.passIconColor = Colors.black,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.onSaved,
    this.onTap,
  }) : super(key: key);

  @override
  State<KeicyTextFormField> createState() => _KeicyTextFormFieldState();
}

class _KeicyTextFormFieldState extends State<KeicyTextFormField> {
  bool isShowPass = true;

  @override
  void initState() {
    super.initState();

    isShowPass = true;
  }

  @override
  Widget build(BuildContext context) {
    InputBorder? focusedBorder;
    InputBorder? errorBorder;
    InputBorder? focusedErrorBorder;
    if (widget.focusedBorder == null) {
      focusedBorder = widget.border;
      focusedBorder = focusedBorder.copyWith(
        borderSide: focusedBorder.borderSide.copyWith(width: 1.5),
      );
    } else {
      focusedBorder = widget.focusedBorder;
    }
    if (widget.errorBorder == null) {
      errorBorder = widget.border;
      errorBorder = errorBorder.copyWith(borderSide: errorBorder.borderSide.copyWith(color: Colors.red));
    } else {
      errorBorder = widget.errorBorder;
    }

    if (widget.focusedErrorBorder == null) {
      focusedErrorBorder = errorBorder;
      focusedErrorBorder = focusedErrorBorder!.copyWith(
        borderSide: focusedErrorBorder.borderSide.copyWith(width: 1.5),
      );
    } else {
      focusedErrorBorder = widget.focusedErrorBorder;
    }

    return SizedBox(
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        style: widget.style,
        decoration: InputDecoration(
          border: widget.border,
          focusedBorder: focusedBorder,
          enabledBorder: widget.border,
          disabledBorder: widget.disabledBorder ?? widget.border,
          errorBorder: errorBorder,
          focusedErrorBorder: focusedErrorBorder,
          isCollapsed: true,
          isDense: true,
          contentPadding: widget.contentPadding,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          label: widget.isImpot && widget.labelText != null
              ? Wrap(
                  children: [
                    Text("${widget.labelText}", style: widget.labelStyle),
                    Text(
                      "  *",
                      style: widget.labelStyle != null
                          ? widget.labelStyle!.copyWith(color: Colors.red, fontWeight: FontWeight.bold)
                          : Theme.of(context).inputDecorationTheme.labelStyle!.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : null,
          labelText: widget.isImpot && widget.labelText != null ? null : widget.labelText,
          labelStyle: widget.labelStyle,
          floatingLabelBehavior: widget.floatingLabelBehavior,
          errorStyle: widget.errorStyle,
          errorMaxLines: widget.errorMaxLines,
          prefix: widget.prefix,
          prefixIcon: widget.prefixIcon,
          prefixText: widget.prefixText,
          prefixStyle: widget.prefixStyle,
          prefixIconConstraints: widget.prefixIconConstraints,
          suffix: widget.suffix,
          suffixIcon: widget.obscureText
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isShowPass = !isShowPass;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        isShowPass ? FontAwesomeIcons.solidEye : FontAwesomeIcons.solidEyeSlash,
                        size: widget.passIconSize,
                        color: widget.passIconColor,
                      ),
                    ],
                  ),
                )
              : widget.suffixIcon,
          suffixText: widget.suffixText,
          suffixStyle: widget.suffixStyle,
        ),
        readOnly: widget.readOnly,
        obscureText: widget.obscureText ? isShowPass : widget.obscureText,
        textAlign: widget.textAlign,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        inputFormatters: widget.inputFormatters,
        onChanged: (input) {
          if (widget.onChanged != null) {
            widget.onChanged!(input.trim());
          }
        },
        onEditingComplete: () {
          if (widget.onEditingComplete != null) {
            widget.onEditingComplete!();
          }
        },
        onFieldSubmitted: (input) {
          if (widget.onFieldSubmitted != null) {
            widget.onFieldSubmitted!(input.trim());
          }
        },
        validator: (input) {
          if (widget.validator != null) {
            return widget.validator!(input!.trim());
          } else {
            return null;
          }
        },
        onSaved: (input) {
          if (widget.onSaved != null && input != null) {
            widget.onSaved!(input.trim());
          }
        },
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
      ),
    );
  }
}
