//! Use => Image.asset('logo'.toPng)
extension ImageExtension on String {
  String get toPng => 'assets/images/img_$this.png';
  String get toJpeg => 'assets/images/img_$this.jpg';
  String get toIcon => 'assets/icons/ic_$this.png';
  String get toLottie => 'assets/lottie/lottie_$this.json';
}
