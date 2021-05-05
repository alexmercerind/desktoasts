<h1 align="center"><a href="https://github.com/alexmercerind/desktoasts">desktoasts</a></h1>
<h4 align="center">A Dart package to send native :speech_balloon: toasts on Windows.</h4>


## Installation

#### For Flutter

```yaml
dependencies:
  ...
  desktoasts: ^0.0.1
```

#### For Dart CLI

[here](https://github.com/alexmercerind/desktoasts#cli)

## Documentation

##### Initialize the toasts service.

```dart
ToastService? service;

void main() {
  service = new ToastService(
    appName: 'desktoasts',
    companyName: 'alexmercerind',
    productName: 'desktoasts_example',
  );
  runApp(MyApp());
}
```

#### Show a toast containing subtitle.

```dart
Toast toast = new Toast(
  type: ToastType.text02,
  title: 'Hello World!',
  subtitle: 'This toast contains a subtitle.',
);
service?.show(toast);
```

<img src="https://github.com/alexmercerind/desktoasts/blob/assets/Capture01.PNG?raw=true" height="256"></img>

#### Show a toast containing an image.

```dart
Toast toast = new Toast(
  type: ToastType.imageAndText02,
  title: 'Hello World!',
  subtitle: 'This toast contains an image.',
  image: new File('C:/Windows/Web/Screen/img100.jpg')
);
service?.show(toast);
```

<img src="https://github.com/alexmercerind/desktoasts/blob/assets/Capture02.PNG?raw=true" height="256"></img>

#### Show a toast with actions in it.

```dart
Toast toast = new Toast(
  type: ToastType.imageAndText02,
  title: 'Hello World!',
  subtitle: 'This toast contains actions in it.',
  image: new File('C:/Windows/Web/Screen/img100.jpg'),
  actions: [
    'Accept',
    'Decline',
  ]
);
service?.show(toast
```

<img src="https://github.com/alexmercerind/desktoasts/blob/assets/Capture03.PNG?raw=true" height="256"></img>

## Progress

##### Done.
- Simple toasts.
- Toasts with image.
- Toasts with actions.

##### Yet to be done.
- Event handling.
- Progress bar toasts.
- Large image toasts.
- Linux support.

## CLI

Currently only Flutter plugin is published to the [pub.dev](https://pub.dev).

For sending toasts from Dart console apps, you may do as follows for now.

```bash
git clone https://github.com/alexmercerind/desktoasts.git
cd desktoasts/cli/example
dart main.dart
```

## Workings

Although, this might seem like a Flutter plugin, but this is internally based on FFI instead. 

[This](https://github.com/alexmercerind/desktoasts/tree/master/desktoasts) section of the repository, contains C++ code that I compile to a shared library (which both Dart package & Flutter plugin pack along with them) for sending toasts.

Currently, features are limited. I definitely plan to improve upon this.

## License

MIT License. Contributions welcomed.

## Acknowledgements

Current package's functionality is solely based upon [WinToast](https://github.com/mohabouje/WinToast). Thanks to [mohabouje](https://github.com/mohabouje).
