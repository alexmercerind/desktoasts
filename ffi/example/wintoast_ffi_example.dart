import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

import 'package:wintoast_ffi/wintoast_ffi.dart';
import 'package:path/path.dart' as path;


extension on List<String> {
  Pointer<Pointer<Utf8>> toNativeUtf8Array() {
    final List<Pointer<Utf8>> listPointer = this.map((String string) => string.toNativeUtf8()).toList().cast<Pointer<Utf8>>();
    final Pointer<Pointer<Utf8>> pointerPointer = calloc.allocate(this.join('').length);
    for (int index = 0; index < this.length; index++) pointerPointer[index] = listPointer[index];
    return pointerPointer;
  }
}

void main() {
  receiver.listen((event) {});
  CallbackFFI.initialize(
    DynamicLibrary.open(path.join(Directory.current.path, '..', 'source', 'main.dll'))
  );
  ToastServiceFFI.create(
    ['wintoasts.dart', 'alexmercerind', 'alexmercerind', '', ''].toNativeUtf8Array()
  );
  ToastFFI.create(
    ['2', 'Hello World!', 'This toast is sent by wintoast.dart', 'C:/Windows/System32/SecurityAndMaintenance.png', 'Yes', 'No'].toNativeUtf8Array(),
    6
  );
  ToastServiceFFI.show(0);
}