import 'dart:io';
import 'package:desktoasts_cli/desktoasts_cli.dart';


Future main() async {
  var service = ToastService(
    appName: 'desktoasts_cli',
    companyName: 'alexmercerind',
    productName: 'desktoasts_cli',
  );
  service.show(Toast(
    type: ToastType.imageAndText02,
    title: 'Hello!',
    subtitle: 'How are you?',
    image: File('C:/Windows/Web/Screen/img100.jpg')
  ));
  await Future.delayed(Duration(seconds: 10));
}
