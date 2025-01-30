import 'package:flutter/material.dart';

class PageIndicator {
  static indicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: const Color(0XFF2FB7B2).withValues(alpha: .72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0.0, 0.0),
                  )
                : const BoxShadow(color: Colors.transparent)
          ],
          shape: BoxShape.circle,
          color: isActive ? const Color(0XFF6BC4C9) : const Color(0XFFEAEAEA),
        ),
      ),
    );
  }
}
