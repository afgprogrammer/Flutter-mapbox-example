import 'package:flutter/material.dart';

class BaseInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final Widget? prefixIcon;
  final void Function()? onClick;
  final void Function(String)? onChanged;
  const BaseInput({super.key, this.label, this.onChanged, this.hint, this.prefixIcon, this.onClick});

  @override
  State<BaseInput> createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null ? Text(widget.label!, style: theme.textTheme.titleMedium,) : SizedBox(),
        SizedBox(height: 4,),
        TextField(
          cursorColor: Colors.orange,
          onTap: widget.onClick,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            filled: true,
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon,
            contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.grey.shade700,
              letterSpacing: 0
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
