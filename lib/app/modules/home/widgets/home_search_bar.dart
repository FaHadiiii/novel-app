import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel/app/modules/home/controllers/home_controller.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    required this.searchBarFocusNode,
  });

  final FocusNode searchBarFocusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: TextField(
        focusNode: searchBarFocusNode,
        onTapOutside: (_) {
          searchBarFocusNode.unfocus();
        },
        cursorColor: Get.textTheme.bodyLarge?.color,
        onChanged: (val) {
          Get.find<HomeController>().novelQuery.value = val;
          Get.find<HomeController>().searchNovels();
        },
        autofocus: false,
        style: Get.textTheme.bodyMedium?.copyWith(height: 1.2),
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Search novel by title',
          hintStyle: Get.textTheme.bodySmall?.copyWith(
            height: 3,
            color: Get.textTheme.bodySmall?.color?.withOpacity(0.6),
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: Get.textTheme.bodySmall?.color?.withOpacity(0.6),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Get.theme.primaryColor,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }
}
