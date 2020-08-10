library keicy_text_form_field;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class KeicyTextFormField extends StatelessWidget {
  KeicyTextFormField({
    Key key,
    this.initialValue,
    @required this.width,
    @required this.height,
    this.fixedHeightState = true,
    this.prefixIcons = const [],
    this.suffixIcons = const [],
    this.isPrefixIconOutofField = false,
    this.isSuffixIconOutofField = false,
    this.enableShowPassword = false,
    this.iconSpacing = 10,
    this.label = "",
    this.labelFontSize,
    this.labelColor,
    this.labelSpacing = 10,
    this.border = const Border(bottom: BorderSide(width: 1, color: Colors.black)),
    this.errorBorder = const Border(bottom: BorderSide(width: 1, color: Colors.red)),
    this.borderRadius = 0,
    this.textFontSize = 20,
    this.textColor = Colors.black,
    this.hintText = "",
    this.hintTextFontSize,
    this.hintTextColor = Colors.grey,
    this.fontFamily,
    this.contentHorizontalPadding = 5,
    this.contentVerticalPadding = 5,
    this.textAlign = TextAlign.left,
    this.keyboardType = TextInputType.text,
    this.validatorHandler,
    this.onSaveHandler,
    this.fillColor = Colors.white,
    this.autovalidate = false,
    this.obscureText = false,
    this.autofocus = false,
    this.controller,
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
  final String initialValue;
  final double width;
  final double height;
  final bool fixedHeightState;

  final List<Widget> prefixIcons;
  final List<Widget> suffixIcons;
  final bool isPrefixIconOutofField;
  final bool isSuffixIconOutofField;
  final bool enableShowPassword;
  final double iconSpacing;
  final String label;
  final double labelFontSize;
  final Color labelColor;
  final double labelSpacing;
  final Border border;
  final Border errorBorder;
  final double borderRadius;
  final double contentHorizontalPadding;
  final double contentVerticalPadding;

  final double textFontSize;
  final Color textColor;
  final String hintText;
  final Color hintTextColor;
  double hintTextFontSize;
  final Color fillColor;
  final String fontFamily;

  double errorStringFontSize;
  final focusNode;

  final TextAlign textAlign;
  final TextInputType keyboardType;

  final bool autovalidate;
  final bool obscureText;
  final Function validatorHandler;
  final Function onSaveHandler;
  final TextEditingController controller;
  final Function onChangeHandler;
  final Function onTapHandler;
  final Function onEditingCompleteHandler;
  final Function onFieldSubmittedHandler;
  final bool autofocus;
  final int maxLines;
  final TextInputAction textInputAction;
  final bool readOnly;
  final inputFormatters;

  @override
  Widget build(BuildContext context) {
    BorderSide hideBorderSide = BorderSide(width: 0, color: fillColor);
    if (errorStringFontSize == null) errorStringFontSize = textFontSize * 0.8;

    return Material(
      color: fillColor,
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

            if (enableShowPassword && !customTextFormFieldProvider.isShownPassword) {
              suffixIcon = FaIcon(FontAwesomeIcons.eye, size: textFontSize * 1.2, color: textColor);
            } else if (enableShowPassword && customTextFormFieldProvider.isShownPassword) {
              suffixIcon = FaIcon(FontAwesomeIcons.eyeSlash, size: textFontSize * 1.2, color: textColor);
            }

            return Container(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  (isPrefixIconOutofField) ? prefixIcon : SizedBox(),
                  (isPrefixIconOutofField && prefixIcons.length != 0) ? SizedBox(width: iconSpacing) : SizedBox(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        (label != "")
                            ? Text(label, style: TextStyle(fontSize: labelFontSize ?? textFontSize, color: labelColor ?? textColor))
                            : SizedBox(),
                        (label != "") ? SizedBox(height: labelSpacing) : SizedBox(),
                        Container(
                          width: double.maxFinite,
                          height: height,
                          padding: EdgeInsets.symmetric(horizontal: contentHorizontalPadding, vertical: contentVerticalPadding),
                          alignment: (keyboardType == TextInputType.multiline) ? Alignment.topLeft : Alignment.center,
                          decoration: BoxDecoration(
                            color: fillColor,
                            border: (customTextFormFieldProvider.errorText == "") ? border : errorBorder,
                            borderRadius: ((customTextFormFieldProvider.errorText == "" && border.isUniform) ||
                                    (customTextFormFieldProvider.errorText != "" && errorBorder.isUniform))
                                ? BorderRadius.circular(borderRadius)
                                : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              (!isPrefixIconOutofField && prefixIcons.length != 0) ? prefixIcon : SizedBox(),
                              (!isPrefixIconOutofField && prefixIcons.length != 0) ? SizedBox(width: iconSpacing) : SizedBox(),
                              Expanded(
                                child: TextFormField(
                                  focusNode: focusNode,
                                  initialValue: initialValue,
                                  style: TextStyle(color: textColor, fontSize: textFontSize, fontFamily: fontFamily),
                                  autofocus: autofocus,
                                  maxLines: maxLines,
                                  textInputAction: textInputAction,
                                  readOnly: readOnly,
                                  textAlign: textAlign,
                                  keyboardType: keyboardType,
                                  autovalidate: autovalidate,
                                  controller: controller,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(fontSize: 0, color: fillColor, height: 0),
                                    isDense: true,
                                    hintText: hintText,
                                    hintStyle: TextStyle(fontSize: hintTextFontSize ?? textFontSize, color: hintTextColor, fontFamily: fontFamily),
                                    border: UnderlineInputBorder(borderSide: hideBorderSide),
                                    enabledBorder: UnderlineInputBorder(borderSide: hideBorderSide),
                                    focusedBorder: UnderlineInputBorder(borderSide: hideBorderSide),
                                    focusedErrorBorder: UnderlineInputBorder(borderSide: hideBorderSide),
                                    errorBorder: UnderlineInputBorder(borderSide: hideBorderSide),
                                    disabledBorder: UnderlineInputBorder(borderSide: hideBorderSide),
                                    filled: true,
                                    fillColor: fillColor,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  inputFormatters: inputFormatters,
                                  obscureText: (!enableShowPassword) ? obscureText : !customTextFormFieldProvider.isShownPassword,
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
                              ((!isSuffixIconOutofField && suffixIcons.length != 0) || enableShowPassword)
                                  ? SizedBox(width: iconSpacing)
                                  : SizedBox(),
                              GestureDetector(
                                child: ((!isSuffixIconOutofField && suffixIcons.length != 0) || enableShowPassword) ? suffixIcon : SizedBox(),
                                onTap: () {
                                  if (enableShowPassword) {
                                    customTextFormFieldProvider.setIsShownPassword(!customTextFormFieldProvider.isShownPassword);
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        (customTextFormFieldProvider.errorText != "")
                            ? Container(
                                height: errorStringFontSize,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  customTextFormFieldProvider.errorText,
                                  style: TextStyle(fontSize: errorStringFontSize, color: Colors.red),
                                ),
                              )
                            : (fixedHeightState) ? SizedBox(height: errorStringFontSize) : SizedBox(),
                      ],
                    ),
                  ),
                  (isSuffixIconOutofField && suffixIcons.length != 0) ? SizedBox(width: iconSpacing) : SizedBox(),
                  (isSuffixIconOutofField && suffixIcons.length != 0) ? suffixIcon : SizedBox(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class KeicyTextFormFieldProvider extends ChangeNotifier {
  static KeicyTextFormFieldProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<KeicyTextFormFieldProvider>(context, listen: listen);

  bool _isValidated = false;
  bool get isValidated => _isValidated;

  String _errorText = "";
  String get errorText => _errorText;

  bool _isShownPassword = false;
  bool get isShownPassword => _isShownPassword;
  void setIsShownPassword(bool isShownPassword) {
    if (_isShownPassword != isShownPassword) {
      _isShownPassword = isShownPassword;
      notifyListeners();
    }
  }

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
