/*
 * MIT License
 * 
 * Copyright (c) 2021 Hitesh Kumar Saini
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
*/

import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

import 'package:desktoasts_cli/src/abstractions.dart';
import 'package:desktoasts_cli/src/dynamic_library.dart';


extension on List<String> {
  Pointer<Pointer<Utf8>> toNativeUtf8Array() {
    final List<Pointer<Utf8>> listPointer = this.map((String string) => string.toNativeUtf8()).toList().cast<Pointer<Utf8>>();
    final Pointer<Pointer<Utf8>> pointerPointer = calloc.allocate(this.join('').length);
    for (int index = 0; index < this.length; index++) pointerPointer[index] = listPointer[index];
    return pointerPointer;
  }
}

/// Declares the type of [Toast].
enum ToastType {
  /// A large image and a single string wrapped across three lines of text.
  imageAndText01,
  /// A large image, one string of bold text on the first line, one string of regular text wrapped across the second and third lines.
  imageAndText02,
  /// A large image, one string of bold text wrapped across the first two lines, one string of regular text on the third line.
  imageAndText03,
  /// A large image, one string of bold text on the first line, one string of regular text on the second line, one string of regular text on the third line.
  imageAndText04,
  /// Single string wrapped across three lines of text.
  text01,
  /// One string of bold text on the first line, one string of regular text wrapped across the second and third lines.
  text02,
  /// One string of bold text wrapped across the first two lines, one string of regular text on the third line.
  text03,
  /// One string of bold text on the first line, one string of regular text on the second line, one string of regular text on the third line.
  text04,
}


/// A [Toast]. Use [ToastService.show] to display a toast.
class Toast {
  /// Type of [Toast].
  final ToastType type;
  /// Title of [Toast].
  final String title;
  /// Subtitle of the [Toast].
  final String? subtitle;
  /// Image [File] to show inside the [Toast].
  final File? image;
  /// [List] of actions to be shown on the [Toast].
  final List<String>? actions;
  /// Unique ID of this [Toast].
  late int id;

  Toast({
    required this.type,
    required this.title,
    this.subtitle,
    this.image,
    this.actions,
  }) {
    List<String> data = [
      this.type.index.toString(),
      this.title,
      this.subtitle ?? '',
      this.image?.path ?? ''
    ]..addAll(actions ?? []);
    this.id = ToastFFI.create(
      data.toNativeUtf8Array(),
      data.length,
    );
  }

  /// Releases resources allocated to the instance of [Toast].
  void dispose() => ToastFFI.dispose(this.id);
}


class ToastService {
  /// Name of the application.
  final String appName;
  /// Name of the company.
  final String companyName;
  /// Name of the product.
  final String productName;
  /// (Optional) Name of the sub product.
  final String? subProductName;
  /// (Optional) Version information.
  final String? versionInformation;

  ToastService({
    required this.appName,
    required this.companyName,
    required this.productName,
    this.subProductName,
    this.versionInformation,
    }) {
    List<String> scriptDirectory = Platform.script.path.split('/')..removeLast();
    CallbackFFI.initialize(
      DynamicLibrary.open(path.joinAll(scriptDirectory + ['..', 'desktoasts.dll']))
    );
    print(dynamicLibrary);
    ToastServiceFFI.create(
      [
        this.appName,
        this.companyName,
        this.productName,
        this.subProductName ?? '',
        this.versionInformation ?? '',
      ].toNativeUtf8Array()
    );
  }

  /// Shows a [Toast] on the desktop.
  void show(Toast toast) => ToastServiceFFI.show(toast.id);

  /// Releases resources allocated to the instance of [ToastService].
  void dispose() => ToastServiceFFI.dispose();
}

