import 'package:abersoft_test_case/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CTTextField extends StatefulWidget {
  const CTTextField._({
    Key? key,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.autofocus = false,
    this.keyboardType,
    this.enabled = true,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.placeholder,
    this.readOnly = false,
    this.inputFormatters,
    this.onChanged,
    bool isTextArea = false,
    this.onTap,
    this.style,
    this.labelText,
    this.contentPadding,
    this.labelStyle,
    this.hintStyle,
    this.onEditingComplete,
    this.textCapitalization = TextCapitalization.none,
    this.textAlignVertical,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.textInputAction,
    this.focusNode,
    this.borderColor,
    this.onFieldSubmitted,
    this.showOptionalTag = false,
    this.maxLength,
    this.initialValue,
  })  : _isTextArea = isTextArea,
        super(key: key);

  /// A custom text field
  ///
  /// Brings out the same behavior from [TextFormField]
  const CTTextField({
    Key? key,
    TextEditingController? controller,
    bool autofocus = false,
    TextInputType? keyboardType,
    bool enabled = true,
    String? errorText,
    String? helperText,
    TextStyle? helperStyle,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? placeholder,
    bool readOnly = false,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    FormFieldValidator<String>? validator,
    TextStyle? style,
    EdgeInsets? contentPadding,
    String? labelText,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextAlignVertical textAlignVertical = TextAlignVertical.top,
    AutovalidateMode? autovalidateMode = AutovalidateMode.disabled,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    Color? borderColor,
    ValueChanged<String>? onFieldSubmitted,
    bool showOptionalTag = false,
    int? maxLength,
    String? initialValue,
  }) : this._(
          key: key,
          controller: controller,
          obscureText: obscureText,
          autofocus: autofocus,
          keyboardType: keyboardType,
          enabled: enabled,
          errorText: errorText,
          helperText: helperText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          placeholder: placeholder,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          isTextArea: false,
          onTap: onTap,
          style: style,
          contentPadding: contentPadding,
          validator: validator,
          labelText: labelText,
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          textCapitalization: textCapitalization,
          autovalidateMode: autovalidateMode,
          textInputAction: textInputAction,
          focusNode: focusNode,
          borderColor: borderColor,
          onFieldSubmitted: onFieldSubmitted,
          showOptionalTag: showOptionalTag,
          maxLength: maxLength,
          initialValue: initialValue,
        );

  /// A custom text area
  ///
  /// Brings out the same behavior from [TextFormField] with larger input area
  /// and suitable for bulk character input and multiline support.
  const CTTextField.area({
    Key? key,
    TextEditingController? controller,
    bool autofocus = false,
    bool enabled = true,
    String? errorText,
    String? helperText,
    TextStyle? helperStyle,
    String? placeholder,
    bool readOnly = false,
    ValueChanged<String>? onChanged,
    TextStyle? style,
    EdgeInsets? contentPadding,
    String? labelText,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    Function(String)? onEditingComplete,
    TextAlignVertical textAlignVertical = TextAlignVertical.top,
    AutovalidateMode? autovalidateMode = AutovalidateMode.disabled,
    FormFieldValidator<String>? validator,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    ValueChanged<String>? onFieldSubmitted,
    bool showOptionalTag = false,
    int? maxLength,
    String? initialValue,
  }) : this._(
          key: key,
          controller: controller,
          autofocus: autofocus,
          keyboardType: TextInputType.multiline,
          enabled: enabled,
          errorText: errorText,
          helperText: helperText,
          placeholder: placeholder,
          readOnly: readOnly,
          onChanged: onChanged,
          isTextArea: true,
          style: style,
          contentPadding: contentPadding,
          labelText: labelText,
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          textAlignVertical: textAlignVertical,
          autovalidateMode: autovalidateMode,
          validator: validator,
          textInputAction: textInputAction,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          showOptionalTag: showOptionalTag,
          maxLength: maxLength,
          initialValue: initialValue,
        );

  final TextEditingController? controller;
  final bool autofocus;
  final TextInputType? keyboardType;
  final bool enabled;
  final String? errorText;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? placeholder;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Function()? onEditingComplete;
  final TextCapitalization textCapitalization;
  final TextAlignVertical? textAlignVertical;
  final AutovalidateMode? autovalidateMode;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Color? borderColor;
  final ValueChanged<String>? onFieldSubmitted;
  final bool showOptionalTag;
  final int? maxLength;

  /// The base style of placeholder and text value.
  final TextStyle? style;

  /// The padding for the input decoration's container.
  ///
  /// Defaults to `EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w)`.
  /// If [suffixIcon] or [prefixIcon] is not-null, each padding will be
  /// reduced.
  final EdgeInsets? contentPadding;

  final bool _isTextArea;
  final String? initialValue;

  @override
  State<CTTextField> createState() => _CTTextFieldState();
}

class _CTTextFieldState extends State<CTTextField> {
  /// being true if the validator is not null
  bool isValidatorError = false;

  /// prevent [isValidatorError] from being true at initial time due to the [validator] checking for an empty string
  bool isInitialValue = false;
  bool isEnableToListen = false;
  @override
  void initState() {
    if (widget.maxLength != null &&
        widget.controller != null &&
        widget.validator == null) {
      widget.controller!.addListener(() {
        setState(() {});
      });
    }

    if (widget.controller == null || widget.validator == null) return;
    if (widget.controller!.text.isNotEmpty) isInitialValue = true;

    /// listen for changes to the controller
    widget.controller?.addListener(() {
      setState(() {
        if (widget.controller!.text.isNotEmpty && !isInitialValue) {
          isEnableToListen = true;
        }

        /// validator validation is allowed only when [isEnableToListen] and [isInitialValue] are true
        if (isEnableToListen || isInitialValue) {
          isValidatorError =
              widget.validator!.call(widget.controller?.text) != null;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // define default border
    InputBorder defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: primaryColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    );

    if (widget.borderColor != null) {
      defaultBorder = defaultBorder.copyWith(
          borderSide: BorderSide(
        color: widget.borderColor!,
        width: 1,
      ));
    }

    final TextStyle baseTextStyle = widget.style ??
        const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        );

    // icon wrapper size for all icons in this widget
    const double iconSquareSize = 24;

    // gap between prefix/suffix icon & input field
    const double iconToInputFieldGap = 10;

    // gap between prefix text & input field
    const double textPrefixToInputFieldGap = 16;

    // initial value to content padding
    const EdgeInsets defaultContentPadding = EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 16,
    );

    // clear horizontal content padding
    final EdgeInsets? clearedHorizontalContentPadding =
        widget.contentPadding?.copyWith(
      left: 0,
      right: 0,
    );

    // clear horizontal default content padding
    final EdgeInsets clearedHorizontalDefaultContentPadding =
        defaultContentPadding.copyWith(
      left: 0,
      right: 0,
    );

    // set default padding if null (horizontal padding removed)
    EdgeInsets baseContentPadding = clearedHorizontalContentPadding ??
        clearedHorizontalDefaultContentPadding;

    // get individual padding value, left & right will be set to
    // padding before prefix & after suffix sizedbox.
    final double leftContentPadding =
        (widget.contentPadding ?? defaultContentPadding).left;
    final double rightContentPadding =
        (widget.contentPadding ?? defaultContentPadding).right;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(builder: (context) {
          Widget textFormFieldWidget = TextFormField(
            initialValue: widget.initialValue,
            maxLength: widget.maxLength,
            maxLengthEnforcement: widget.maxLength == null
                ? MaxLengthEnforcement.none
                : MaxLengthEnforcement.enforced,
            maxLines: !widget._isTextArea ? 1 : 8,
            minLines: !widget._isTextArea ? 1 : 8,
            autofocus: widget.autofocus,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            onChanged: widget.onChanged,
            textAlignVertical: widget.textAlignVertical,
            readOnly: widget.readOnly,
            inputFormatters: widget.inputFormatters,
            textCapitalization: widget.textCapitalization,
            enabled: widget.enabled,
            validator: (String? value) {
              if (widget.validator != null) {
                String? validateResult = widget.validator!(value);
                isValidatorError = validateResult != null;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {});
                });
                return validateResult;
              }
              return null;
            },
            onEditingComplete: widget.onEditingComplete,
            autovalidateMode: widget.autovalidateMode,
            textInputAction: widget.textInputAction,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onFieldSubmitted,
            style: baseTextStyle.copyWith(
              color: !widget.enabled ? Colors.grey : null,
            ),
            onTap: widget.onTap,
            decoration: InputDecoration(
              isCollapsed: widget.prefixIcon is Text,
              labelText: widget.labelText,
              labelStyle: widget.labelStyle,
              filled: true,
              fillColor: widget.readOnly || !widget.enabled
                  ? Colors.grey
                  : Colors.white,
              helperText: widget.helperText,
              helperMaxLines: 5,
              errorText: widget.errorText,
              errorStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10,
                color: Colors.red.shade400,
              ),
              errorMaxLines: 5,
              prefixIconConstraints: (widget.prefixIcon != null &&
                      widget.prefixIcon is Text)
                  ? const BoxConstraints(minWidth: 0, minHeight: 0)
                  : BoxConstraints.tight(
                      Size(
                        () {
                          double prefixWidth = leftContentPadding;
                          if (widget.prefixIcon != null) {
                            prefixWidth += iconSquareSize + iconToInputFieldGap;
                          }
                          return prefixWidth;
                        }(),
                        iconSquareSize,
                      ),
                    ),
              suffixIconConstraints: BoxConstraints.tight(
                Size(
                  [
                    rightContentPadding,
                    if (widget.suffixIcon != null ||
                        widget.errorText != null ||
                        isValidatorError) ...[
                      if (widget.suffixIcon != null) iconSquareSize,
                      if (widget.errorText != null || isValidatorError)
                        iconSquareSize,
                      iconToInputFieldGap,
                    ]
                  ].reduce((value, element) => value + element),
                  iconSquareSize,
                ),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  left: leftContentPadding,
                  right: widget.prefixIcon == null
                      ? 0
                      : widget.prefixIcon is! Text
                          ? iconToInputFieldGap
                          : textPrefixToInputFieldGap,
                ),
                child: widget.prefixIcon == null
                    ? null
                    : widget.prefixIcon is! Text
                        ? SizedBox.square(
                            dimension: iconSquareSize,
                            child: widget.prefixIcon,
                          )
                        : DefaultTextStyle(
                            softWrap: false,
                            style: baseTextStyle.copyWith(
                              overflow: TextOverflow.visible,
                            ),
                            child: widget.prefixIcon!,
                          ),
              ),
              suffixIcon: () {
                return Padding(
                  padding: EdgeInsets.only(
                    right: rightContentPadding,
                    left: widget.suffixIcon == null ? 0 : 10,
                  ),
                  child: (widget.suffixIcon != null)
                      ? FittedBox(child: widget.suffixIcon!)
                      : null,
                );
              }(),
              isDense: true,
              contentPadding: baseContentPadding,
              hintText: widget.placeholder,
              hintStyle: widget.hintStyle ??
                  baseTextStyle.copyWith(color: Colors.grey.shade200),
              enabledBorder: defaultBorder.copyWith(
                borderSide: BorderSide(
                  color: widget.errorText != null
                      ? Colors.red.shade400
                      : Colors.grey,
                ),
              ),
              errorBorder: widget.readOnly
                  ? defaultBorder
                  : defaultBorder.copyWith(
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                        width: 1,
                      ),
                    ),
              focusedBorder: widget.borderColor != null
                  ? defaultBorder
                  : widget.readOnly
                      ? defaultBorder.copyWith(
                          borderSide: BorderSide(
                            color: widget.errorText != null
                                ? Colors.red.shade400
                                : Colors.grey,
                          ),
                        )
                      : defaultBorder.copyWith(
                          borderSide: BorderSide(
                            color: widget.errorText != null
                                ? Colors.red.shade400
                                : primaryColor,
                            width: 1.5,
                          ),
                        ),
              disabledBorder: defaultBorder,
              focusedErrorBorder: widget.readOnly
                  ? defaultBorder
                  : defaultBorder.copyWith(
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                        width: 1.5,
                      ),
                    ),
            ),
          );

          if (widget._isTextArea) {
            return SizedBox(
              height: 96,
              child: textFormFieldWidget,
            );
          }
          return textFormFieldWidget;
        }),
      ],
    );
  }
}
