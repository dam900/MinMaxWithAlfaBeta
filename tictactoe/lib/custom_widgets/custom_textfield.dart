import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.width,
    required this.onValidateCallback,
    required this.onSavedCallback,
    this.onChangedCallback,
    required this.text,
  });
  final double width;
  final String hintText;
  final String text;
  final String? Function(String? v) onValidateCallback;
  final Function(String? v) onSavedCallback;
  final Function(String? v)? onChangedCallback;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: widget.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                cursorColor: Theme.of(context).cardColor,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide(
                        width: 3,
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    hintText: widget.hintText),
                validator: (value) {
                  return widget.onValidateCallback(value);
                },
                onSaved: (newValue) {
                  widget.onSavedCallback(newValue);
                },
                onChanged: (value) {
                  if (widget.onChangedCallback != null) {
                    widget.onChangedCallback!(value);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
