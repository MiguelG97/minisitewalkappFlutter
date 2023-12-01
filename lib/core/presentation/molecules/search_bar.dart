import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';

class SearchBar extends StatefulWidget {
  final ValueChanged<String>? onTextChanged;
  final String? searchBarHintText;

  ///Default time is 400 ms
  final int? debounceTime;
  final TextInputType? keyboardType;

  const SearchBar({
    Key? key,
    this.onTextChanged,
    this.searchBarHintText,
    this.debounceTime,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounceTimer;

  void _onChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer =
        Timer(Duration(milliseconds: widget.debounceTime ?? 400), () {
      widget.onTextChanged?.call(value);
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43,
      child: TextField(
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        keyboardType: widget.keyboardType,
        controller: _searchController,
        onChanged: _onChanged,
        cursorColor: AppColors.greyIcon,
        style: AppTextStyles.display14w400.copyWith(color: AppColors.grey),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 4),
          hintText: widget.searchBarHintText ?? '',
          hintStyle:
              AppTextStyles.display14w400.copyWith(color: AppColors.greyIcon),
          prefixIcon: const Icon(Icons.search, color: AppColors.greyIcon),
          fillColor: AppColors.lightGrey,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.lightGrey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.lightGrey),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
