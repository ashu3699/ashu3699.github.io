import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';

final androidDevice = DeviceInfo(
  identifier: const DeviceIdentifier(
    TargetPlatform.android,
    DeviceType.phone,
    'android',
  ),
  name: 'Android',
  pixelRatio: 4,
  safeAreas: const EdgeInsets.only(top: 40, bottom: 20),
  rotatedSafeAreas: const EdgeInsets.only(left: 40, top: 24, right: 40),
  framePainter: const _FramePainter(),
  screenPath: _screenPath,
  frameSize: const Size(852, 1865),
  screenSize: const Size(360, 800),
);

class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final path_0 = Path();
    path_0.moveTo(6.5205, 675.949);
    path_0.lineTo(4.34704, 675.949);
    path_0.cubicTo(1.94629, 675.949, 0, 673.934, 0, 671.447);
    path_0.lineTo(0.000118933, 460.931);
    path_0.cubicTo(0.000119151, 458.445, 1.94631, 456.429, 4.34706, 456.429);
    path_0.lineTo(6.52053, 456.429);
    path_0.lineTo(6.5205, 675.949);
    path_0.close();

    final paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff121515);
    canvas.drawPath(path_0, paint0Fill);

    final path_1 = Path();
    path_1.moveTo(845.479, 654.214);
    path_1.lineTo(847.653, 654.214);
    path_1.cubicTo(850.054, 654.214, 852, 656.23, 852, 658.717);
    path_1.lineTo(852, 784.467);
    path_1.cubicTo(852, 786.954, 850.054, 788.969, 847.653, 788.969);
    path_1.lineTo(845.479, 788.969);
    path_1.lineTo(845.479, 654.214);
    path_1.close();

    final paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xff121515);
    canvas.drawPath(path_1, paint1Fill);

    final path_2 = Path();
    path_2.moveTo(845.479, 471.643);
    path_2.lineTo(847.653, 471.643);
    path_2.cubicTo(850.054, 471.643, 852, 473.659, 852, 476.145);
    path_2.lineTo(852, 538.865);
    path_2.cubicTo(852, 541.352, 850.054, 543.368, 847.653, 543.368);
    path_2.lineTo(845.479, 543.368);
    path_2.lineTo(845.479, 471.643);
    path_2.close();

    final paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = const Color(0xff121515);
    canvas.drawPath(path_2, paint2Fill);

    final path_3 = Path();
    path_3.moveTo(6.52051, 147.796);
    path_3.cubicTo(6.52051, 90.8783, 6.52051, 62.4195, 19.3318, 41.5134);
    path_3.cubicTo(26.5004, 29.8153, 36.3358, 19.9799, 48.0339, 12.8113);
    path_3.cubicTo(68.94, 0, 97.3988, 0, 154.316, 0);
    path_3.lineTo(697.684, 0);
    path_3.cubicTo(754.601, 0, 783.06, 0, 803.966, 12.8113);
    path_3.cubicTo(815.664, 19.9799, 825.5, 29.8153, 832.668, 41.5134);
    path_3.cubicTo(845.48, 62.4195, 845.48, 90.8783, 845.48, 147.796);
    path_3.lineTo(845.48, 1717.04);
    path_3.cubicTo(845.48, 1773.96, 845.48, 1802.42, 832.668, 1823.32);
    path_3.cubicTo(825.5, 1835.02, 815.664, 1844.86, 803.966, 1852.03);
    path_3.cubicTo(783.06, 1864.84, 754.601, 1864.84, 697.684, 1864.84);
    path_3.lineTo(154.316, 1864.84);
    path_3.cubicTo(97.3988, 1864.84, 68.94, 1864.84, 48.0339, 1852.03);
    path_3.cubicTo(36.3358, 1844.86, 26.5004, 1835.02, 19.3318, 1823.32);
    path_3.cubicTo(6.52051, 1802.42, 6.52051, 1773.96, 6.52051, 1717.04);
    path_3.lineTo(6.52051, 147.796);
    path_3.close();

    final paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = const Color(0xff3A4245);
    canvas.drawPath(path_3, paint3Fill);

    final path_4 = Path();
    path_4.moveTo(10.8672, 142.362);
    path_4.cubicTo(10.8672, 92.5595, 10.8672, 67.6581, 22.0771, 49.3652);
    path_4.cubicTo(28.3496, 39.1294, 36.9556, 30.5234, 47.1914, 24.2509);
    path_4.cubicTo(65.4843, 13.041, 90.3857, 13.041, 140.189, 13.041);
    path_4.lineTo(711.811, 13.041);
    path_4.cubicTo(761.614, 13.041, 786.515, 13.041, 804.808, 24.2509);
    path_4.cubicTo(815.044, 30.5234, 823.65, 39.1294, 829.923, 49.3652);
    path_4.cubicTo(841.132, 67.6581, 841.132, 92.5595, 841.132, 142.362);
    path_4.lineTo(841.132, 1722.47);
    path_4.cubicTo(841.132, 1772.28, 841.132, 1797.18, 829.923, 1815.47);
    path_4.cubicTo(823.65, 1825.71, 815.044, 1834.31, 804.808, 1840.59);
    path_4.cubicTo(786.515, 1851.8, 761.614, 1851.8, 711.811, 1851.8);
    path_4.lineTo(140.189, 1851.8);
    path_4.cubicTo(90.3857, 1851.8, 65.4843, 1851.8, 47.1914, 1840.59);
    path_4.cubicTo(36.9556, 1834.31, 28.3496, 1825.71, 22.0771, 1815.47);
    path_4.cubicTo(10.8672, 1797.18, 10.8672, 1772.28, 10.8672, 1722.47);
    path_4.lineTo(10.8672, 142.362);
    path_4.close();

    final paint4Fill = Paint()..style = PaintingStyle.fill;
    paint4Fill.color = const Color(0xff121515);
    canvas.drawPath(path_4, paint4Fill);

    final path_5 = Path();
    path_5.moveTo(319.5, 26.0815);
    path_5.cubicTo(315.53, 26.0815, 315.186, 20.6429, 311.845, 19.6997);
    path_5.cubicTo(311.472, 19.5945, 311.295, 19.1147, 311.602, 18.8783);
    path_5.cubicTo(312.429, 18.241, 313.791, 17.3877, 315.153, 17.3877);
    path_5.lineTo(536.847, 17.3877);
    path_5.cubicTo(538.209, 17.3877, 539.571, 18.241, 540.398, 18.8783);
    path_5.cubicTo(540.705, 19.1147, 540.528, 19.5945, 540.155, 19.6997);
    path_5.cubicTo(536.814, 20.6429, 536.47, 26.0815, 532.5, 26.0815);
    path_5.lineTo(319.5, 26.0815);
    path_5.close();

    final paint5Fill = Paint()..style = PaintingStyle.fill;
    paint5Fill.color = const Color(0xff262C2D);
    canvas.drawPath(path_5, paint5Fill);

    final path_6 = Path();
    path_6.moveTo(108.673, 110.847);
    path_6.cubicTo(120.677, 110.847, 130.408, 101.116, 130.408, 89.1121);
    path_6.cubicTo(130.408, 77.1084, 120.677, 67.3774, 108.673, 67.3774);
    path_6.cubicTo(96.6694, 67.3774, 86.9385, 77.1084, 86.9385, 89.1121);
    path_6.cubicTo(86.9385, 101.116, 96.6694, 110.847, 108.673, 110.847);
    path_6.close();

    final paint6Fill = Paint()..style = PaintingStyle.fill;
    paint6Fill.color = const Color(0xff262C2D);
    canvas.drawPath(path_6, paint6Fill);

    final path_7 = Path();
    path_7.moveTo(108.673, 102.696);
    path_7.cubicTo(116.175, 102.696, 122.257, 96.6144, 122.257, 89.112);
    path_7.cubicTo(122.257, 81.6097, 116.175, 75.5278, 108.673, 75.5278);
    path_7.cubicTo(101.171, 75.5278, 95.0889, 81.6097, 95.0889, 89.112);
    path_7.cubicTo(95.0889, 96.6144, 101.171, 102.696, 108.673, 102.696);
    path_7.close();

    final paint7Fill = Paint()..style = PaintingStyle.fill;
    paint7Fill.color = const Color(0xff121515);
    canvas.drawPath(path_7, paint7Fill);

    final path_8 = Path();
    path_8.moveTo(108.673, 86.3951);
    path_8.cubicTo(110.173, 86.3951, 111.39, 85.1787, 111.39, 83.6783);
    path_8.cubicTo(111.39, 82.1778, 110.173, 80.9614, 108.673, 80.9614);
    path_8.cubicTo(107.172, 80.9614, 105.956, 82.1778, 105.956, 83.6783);
    path_8.cubicTo(105.956, 85.1787, 107.172, 86.3951, 108.673, 86.3951);
    path_8.close();

    final paint8Fill = Paint()..style = PaintingStyle.fill;
    paint8Fill.color = const Color(0xff636F73);
    canvas.drawPath(path_8, paint8Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

final _screenPath = Path()
  ..moveTo(30.3263, 75.7513)
  ..cubicTo(21.7354, 91.0915, 21.7354, 111.551, 21.7354, 152.469)
  ..lineTo(21.7354, 1708.02)
  ..cubicTo(21.7354, 1748.94, 21.7354, 1769.4, 30.3263, 1784.74)
  ..cubicTo(36.3978, 1795.58, 45.3492, 1804.53, 56.1908, 1810.6)
  ..cubicTo(71.531, 1819.19, 91.9901, 1819.19, 132.908, 1819.19)
  ..lineTo(719.093, 1819.19)
  ..cubicTo(760.011, 1819.19, 780.47, 1819.19, 795.81, 1810.6)
  ..cubicTo(806.652, 1804.53, 815.603, 1795.58, 821.675, 1784.74)
  ..cubicTo(830.266, 1769.4, 830.266, 1748.94, 830.266, 1708.02)
  ..lineTo(830.266, 152.469)
  ..cubicTo(830.266, 111.551, 830.266, 91.0915, 821.675, 75.7513)
  ..cubicTo(815.603, 64.9098, 806.652, 55.9584, 795.81, 49.8868)
  ..cubicTo(780.47, 41.2959, 760.011, 41.2959, 719.093, 41.2959)
  ..lineTo(132.908, 41.2959)
  ..cubicTo(91.9901, 41.2959, 71.531, 41.2959, 56.1908, 49.8868)
  ..cubicTo(45.3492, 55.9584, 36.3978, 64.9098, 30.3263, 75.7513)
  ..close()
  ..moveTo(130.47, 88.7347)
  ..cubicTo(130.47, 100.738, 120.739, 110.469, 108.736, 110.469)
  ..cubicTo(96.7319, 110.469, 87.001, 100.738, 87.001, 88.7347)
  ..cubicTo(87.001, 76.731, 96.7319, 67, 108.736, 67)
  ..cubicTo(120.739, 67, 130.47, 76.731, 130.47, 88.7347)
  ..close()
  ..fillType = PathFillType.evenOdd;
