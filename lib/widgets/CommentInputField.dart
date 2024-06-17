import 'package:flutter/material.dart';

class CommentInputField extends StatelessWidget {
  const CommentInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        hintText: "Write a comment",
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(100),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(100),
        ),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(Icons.send),
        ),
      ),
    );
  }
}
