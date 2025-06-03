import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const SearchFormField(
      {super.key, required this.onChanged, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Enter Location ....',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
