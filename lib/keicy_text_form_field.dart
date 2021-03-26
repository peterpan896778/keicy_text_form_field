library keicy_text_form_field;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeicyTextFormField extends StatelessWidget {
  KeicyTextFormField({
    Key key,
    @required this.width,
    @required this.height,
    this.initialValue,
    this.controller,
    this.fixedHeightState = false,
    this.prefixIcons = const [],
    this.suffixIcons = const [],
    this.isPrefixIconOutofField = false,
    this.isSuffixIconOutofField = false,
    this.enableShowPassword = false,
    this.iconSpacing = 10,
    this.label = "",
    this.labelStyle,
    this.labelSpacing,
    this.border = const Border(bottom: BorderSide(width: 1, color: Colors.black)),
    this.errorBorder = const Border(bottom: BorderSide(width: 1, color: Colors.red)),
    this.borderRadius = 0,
    this.textStyle = const TextStyle(fontSize: 20, color: Colors.black),
    this.hintStyle = const TextStyle(fontSize: 20, color: Colors.grey),
    this.hintText = "",
    this.contentHorizontalPadding = 5,
    this.contentVerticalPadding = 5,
    this.textAlign = TextAlign.left,
    this.keyboardType = TextInputType.text,
    this.validatorHandler,
    this.onSaveHandler,
    this.fillColor = Colors.transparent,
    this.autovalidate = false,
    this.obscureText = false,
    this.autofocus = false,
    this.onChangeHandler,
    this.onTapHandler,
    this.onFieldSubmittedHandler,
    this.onEditingCompleteHandler,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.done,
    this.readOnly = false,
    this.errorStringFontSize,
    this.inputFormatters,
    this.focusNode,
  }) : super(key: key);

  final double width;
  final double height;
  final String initialValue;
  final TextEditingController controller;
  final bool fixedHeightState;
  final List<Widget> prefixIcons;
  final List<Widget> suffixIcons;
  final bool isPrefixIconOutofField;
  final bool isSuffixIconOutofField;
  final bool enableShowPassword;
  final double iconSpacing;
  final String label;
  final TextStyle labelStyle;
  final double labelSpacing;
  final Border border;
  final Border errorBorder;
  final double borderRadius;
  final double contentHorizontalPadding;
  final double contentVerticalPadding;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final String hintText;
  final Color fillColor;
  double errorStringFontSize;
  FocusNode focusNode;

  final TextAlign textAlign;
  final TextInputType keyboardType;

  final bool autovalidate;
  final bool obscureText;
  final Function(String) validatorHandler;
  final Function(String) onSaveHandler;
  final Function(String) onChangeHandler;
  final Function(String) onFieldSubmittedHandler;
  final Function onTapHandler;
  final Function onEditingCompleteHandler;
  final bool autofocus;
  final int maxLines;
  final TextInputAction textInputAction;
  final bool readOnly;
  final inputFormatters;

  @override
  Widget build(BuildContext context) {
    if (errorStringFontSize == null) errorStringFontSize = textStyle.fontSize * 0.8;
    focusNode = focusNode ?? FocusNode();

    return Material(
      color: Colors.transparent,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => KeicyTextFormFieldProvider()),
        ],
        child: Consumer<KeicyTextFormFieldProvider>(
          builder: (context, customTextFormFieldProvider, _) {
            Widget prefixIcon = SizedBox();
            Widget suffixIcon = SizedBox();
            if (prefixIcons.length != 0 && customTextFormFieldProvider.isValidated) {
              prefixIcon = prefixIcons[0];
            } else if (prefixIcons.length != 0 && !customTextFormFieldProvider.isValidated) {
              prefixIcon = prefixIcons.length == 2 ? prefixIcons[1] : prefixIcons[0];
            }

            if (suffixIcons.length != 0 && customTextFormFieldProvider.isValidated) {
              suffixIcon = suffixIcons[0];
            } else if (suffixIcons.length != 0 && !customTextFormFieldProvider.isValidated) {
              suffixIcon = suffixIcons.length == 2 ? suffixIcons[1] : suffixIcons[0];
            }

            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(focusNode);
              },
              child: Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /// prefix Icon
                    (isPrefixIconOutofField && prefixIcons.length != 0)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              prefixIcon,
                              SizedBox(width: iconSpacing),
                            ],
                          )
                        : SizedBox(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /// label
                          (label != "")
                              ? Column(
                                  children: [
                                    Text(label, style: labelStyle ?? textStyle),
                                    SizedBox(height: labelSpacing ?? labelSpacing),
                                  ],
                                )
                              : SizedBox(),
                          Container(
                            width: double.maxFinite,
                            height: height,
                            padding: EdgeInsets.symmetric(
                              horizontal: contentHorizontalPadding,
                              vertical: contentVerticalPadding,
                            ),
                            alignment: (keyboardType == TextInputType.multiline) ? Alignment.topLeft : Alignment.center,
                            decoration: BoxDecoration(
                              color: fillColor,
                              border: (customTextFormFieldProvider.errorText == "") ? border : errorBorder,
                              borderRadius: ((customTextFormFieldProvider.errorText == "" && border.isUniform) || (customTextFormFieldProvider.errorText != "" && errorBorder.isUniform))
                                  ? BorderRadius.circular(borderRadius)
                                  : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                /// prefix icon
                                (!isPrefixIconOutofField && prefixIcons.length != 0) ? prefixIcon : SizedBox(),
                                (!isPrefixIconOutofField && prefixIcons.length != 0) ? SizedBox(width: iconSpacing) : SizedBox(),
                                Expanded(
                                  child: TextFormField(
                                    focusNode: focusNode,
                                    initialValue: controller == null ? initialValue : null,
                                    controller: controller,
                                    style: textStyle,
                                    autofocus: autofocus,
                                    maxLines: maxLines,
                                    textInputAction: textInputAction,
                                    readOnly: readOnly,
                                    textAlign: textAlign,
                                    keyboardType: keyboardType,
                                    autovalidate: autovalidate,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(fontSize: 0, color: Colors.transparent, height: 0),
                                      isDense: true,
                                      isCollapsed: true,
                                      hintText: hintText,
                                      hintStyle: hintStyle,
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    inputFormatters: inputFormatters,
                                    obscureText: obscureText,
                                    onTap: onTapHandler,
                                    onChanged: (input) {
                                      customTextFormFieldProvider.setErrorText("");
                                      if (onChangeHandler != null) onChangeHandler(input.trim());
                                    },
                                    validator: (input) {
                                      if (validatorHandler == null) return null;
                                      var result = validatorHandler(input.trim());
                                      if (result != null)
                                        customTextFormFieldProvider.setIsValidated(false, result);
                                      else
                                        customTextFormFieldProvider.setIsValidated(true, "");
                                      return result;
                                    },
                                    onSaved: (input) {
                                      if (onSaveHandler == null) return null;
                                      onSaveHandler(input.trim());
                                    },
                                    onEditingComplete: onEditingCompleteHandler,
                                    onFieldSubmitted: onFieldSubmittedHandler,
                                  ),
                                ),
                                ((!isSuffixIconOutofField && suffixIcons.length != 0) || enableShowPassword) ? SizedBox(width: iconSpacing) : SizedBox(),
                                ((!isSuffixIconOutofField && suffixIcons.length != 0) || enableShowPassword) ? suffixIcon : SizedBox()
                              ],
                            ),
                          ),
                          (customTextFormFieldProvider.errorText != "" && errorStringFontSize != 0)
                              ? Container(
                                  height: errorStringFontSize + 8,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    customTextFormFieldProvider.errorText,
                                    style: TextStyle(fontSize: errorStringFontSize, color: Colors.red),
                                  ),
                                )
                              : (fixedHeightState)
                                  ? SizedBox(height: errorStringFontSize + 8)
                                  : SizedBox(),
                        ],
                      ),
                    ),
                    (isSuffixIconOutofField && suffixIcons.length != 0) ? SizedBox(width: iconSpacing) : SizedBox(),
                    (isSuffixIconOutofField && suffixIcons.length != 0) ? suffixIcon : SizedBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class KeicyTextFormFieldProvider extends ChangeNotifier {
  static KeicyTextFormFieldProvider of(BuildContext context, {bool listen = false}) => Provider.of<KeicyTextFormFieldProvider>(context, listen: listen);

  bool _isValidated = false;
  bool get isValidated => _isValidated;

  String _errorText = "";
  String get errorText => _errorText;

  void setErrorText(String errorText) {
    if (_errorText != errorText) {
      _errorText = errorText;
      notifyListeners();
    }
  }

  void setIsValidated(bool isValidated, String errorText) {
    if (_isValidated != isValidated || _errorText != errorText) {
      _isValidated = isValidated;
      _errorText = errorText;
      notifyListeners();
    }
  }
}
