<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Adaptive Ticket View

A customizable Flutter widget for creating beautiful ticket views with dynamic content and styling options.

## Features

- 🎨 Customizable background and border colors
- 📱 Dynamic content area for any widget
- ✨ Optional bottom message and ticket code
- 🎯 Customizable dotted line style
- 📐 Automatic height calculation
- 🎭 Beautiful ticket shape with cutouts

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  adaptive_ticket_view: ^0.0.1
```

## Usage

```dart
import 'package:adaptive_ticket_view/adaptive_ticket_view.dart';

// Basic usage
AdaptiveTicketView(
  ticketBgColor: Colors.blue[100]!,
  ticketBorderColor: Colors.blue,
  ticketInfoWidget: YourCustomContent(),
)

// Full example with all options
AdaptiveTicketView(
  ticketBgColor: const Color(0xffcaf0f8),
  ticketBorderColor: const Color(0xff00b4d8),
  ticketInfoWidget: Column(
    children: [
      // Your custom content here
    ],
  ),
  ticketBottomMessage: "Enjoy your journey!",
  ticketCode: "123456789",
  showFooter: true,
  dottedLineColor: const Color(0xff0077b6),
)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| ticketBgColor | Color | Yes | Background color of the ticket |
| ticketBorderColor | Color | Yes | Border color of the ticket |
| ticketInfoWidget | Widget? | No | Main content widget to be displayed in the ticket |
| ticketBottomMessage | String? | No | Optional message to be displayed at the bottom |
| ticketCode | String? | No | Optional ticket code to be displayed at the bottom |
| showFooter | bool | No | Whether to show the footer section (default: true) |
| dottedLineColor | Color | No | Color of the dotted line separator |

## Example

Check out the [example](example) directory for a complete example of how to use this package.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
