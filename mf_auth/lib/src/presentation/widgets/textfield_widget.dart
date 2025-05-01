import 'package:flutter/material.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class TextFieldWidget extends StatefulWidget {
  final IconData? icon;
  final String? hint;
  final String? errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final EdgeInsets padding;
  final Color? hintColor;
  final Color? iconColor;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? inputAction;
  final bool autoFocus;
  final bool enabled;

  const TextFieldWidget({
    Key? key,
    this.icon,
    this.hint,
    this.errorText,
    this.isObscure = false,
    this.isIcon = true,
    this.inputType,
    this.textController,
    this.padding = const EdgeInsets.all(0),
    this.hintColor,
    this.iconColor,
    this.focusNode,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputAction,
    this.autoFocus = false,
    this.enabled = true,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        controller: widget.textController,
        focusNode: widget.focusNode,
        keyboardType: widget.inputType,
        textInputAction: widget.inputAction,
        obscureText: _obscureText,
        enabled: widget.enabled,
        autofocus: widget.autoFocus,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: widget.hintColor ?? Theme.of(context).hintColor,
            fontSize: 13.0,
          ),
          errorText: _getTranslatedError(context, widget.errorText),
          prefixIcon: widget.isIcon ? Icon(widget.icon, color: widget.iconColor) : null,
          suffixIcon: widget.isObscure 
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: 0, 
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        ),
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
      ),
    );
  }

  // Traduce el mensaje de error si es necesario
  String? _getTranslatedError(BuildContext context, String? errorText) {
    if (errorText == null || errorText.isEmpty) {
      return null;
    }
    
    return AppLocalizations.of(context).translate(errorText);
  }
} 