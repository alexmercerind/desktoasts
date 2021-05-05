import 'dart:ffi';
import 'dart:isolate';

import 'package:desktoasts_cli/src/dynamic_library.dart';
import 'package:desktoasts_cli/src/typedefs.dart';


ReceivePort receiver = new ReceivePort();


abstract class CallbackFFI {

  static void initialize(DynamicLibrary library) {
    dynamicLibrary = library;
    RegisterPostCObjectDart registerPostCObject = dynamicLibrary!.lookup<NativeFunction<RegisterPostCObjectCXX>>('RegisterDart_PostCObject').asFunction();
    RegisterCallbackPortDart registerCallbackPort = dynamicLibrary!.lookup<NativeFunction<RegisterCallbackPortCXX>>('RegisterDart_CallbackPort').asFunction();
    registerPostCObject(NativeApi.postCObject);
    registerCallbackPort(receiver.sendPort.nativePort);
  }
}


abstract class ToastServiceFFI {

  static final ToastServiceShowDart show = dynamicLibrary!.lookupFunction<ToastServiceShowCXX, ToastServiceShowDart>('ToastService_show');

  static final ToastServiceDisposeDart dispose = dynamicLibrary!.lookupFunction<ToastServiceDisposeCXX, ToastServiceDisposeDart>('ToastService_dispose');

  static final ToastServiceCreateDart create = dynamicLibrary!.lookupFunction<ToastServiceCreateCXX, ToastServiceCreateDart>('ToastService_create');
}


abstract class ToastFFI {

  static final ToastDisposeDart dispose = dynamicLibrary!.lookupFunction<ToastDisposeCXX, ToastDisposeDart>('Toast_dispose');

  static final ToastCreateDart create = dynamicLibrary!.lookupFunction<ToastCreateCXX, ToastCreateDart>('Toast_create');
}