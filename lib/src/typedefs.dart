import 'dart:ffi';
import 'package:ffi/ffi.dart';


typedef RegisterPostCObjectCXX = Void Function(Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> functionPointer);
typedef RegisterPostCObjectDart = void Function(Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>> functionPointer);

typedef RegisterCallbackPortCXX = Void Function(Int64 nativePort);
typedef RegisterCallbackPortDart = void Function(int nativePort);

typedef ToastServiceCreateCXX = Void Function(Pointer<Pointer<Utf16>>);
typedef ToastServiceCreateDart = void Function(Pointer<Pointer<Utf16>>);

typedef ToastServiceShowCXX = Void Function(Int32);
typedef ToastServiceShowDart = void Function(int);

typedef ToastServiceDisposeCXX = Void Function();
typedef ToastServiceDisposeDart = void Function();

typedef ToastCreateCXX = Int32 Function(Pointer<Pointer<Utf16>>, Int32);
typedef ToastCreateDart = int Function(Pointer<Pointer<Utf16>>, int);

typedef ToastDisposeCXX = Void Function(Int32);
typedef ToastDisposeDart = void Function(int);