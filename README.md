Create fully customizable square or rectangle progress indicators like native flutter CircularProgressIndicator widget!

## Features

<p align="center">
  <img src="https://raw.githubusercontent.com/amir14a/square_progress_indicator/main/screenshots/screenshot1.gif" width="350" title="Full example of SquareProgressIndicator">
</p>
## Usage

Simple usage:
```dart
const SquareProgressIndicator(),
```

Customize usage:
```dart
SquareProgressIndicator(
    value: _value,
    width: 100,
    height: 100,
    borderRadius: 0,
    startPosition: StartPosition.leftCenter,
    strokeCap: StrokeCap.square,
    clockwise: true,
    color: Colors.purple,
    emptyStrokeColor: Colors.purple.withOpacity(.5),
    strokeWidth: 16,
    emptyStrokeWidth: 16,
    strokeAlign: SquareStrokeAlign.center,
    child: Text("${(_value * 100).toStringAsFixed(0)}%"),
),
```

## Additional information
|    **Parameter**   |      **Type**     |                 **Default**                 |                                                                                     **Info**                                                                                    |
|:------------------:|:-----------------:|:-------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
|       `value`      |      double?      |                    `null`                   | The value of the progress, it should be between 0 and 1. don't pass it to use Indeterminate mode                                                                                |
|       `width`      |       double      |                     `38`                    | The width of rectangle that the progress line is drawn around it.                                                                                                               |
|      `height`      |       double      |                     `38`                    | The height of rectangle that the progress line is drawn around it.                                                                                                              |
|   `borderRadius`   |       double      |                     `8`                     | The border radius of the rectangle, it is applied to all four corners.                                                                                                          |
|       `color`      |       Color?      |        `progressIndicatorTheme.color`       | The color of the progress line.                                                                                                                                                 |
| `emptyStrokeColor` |       Color?      | `progressIndicatorTheme.circularTrackColor` | The color of the line behind the progress line which show for reminding progress.                                                                                               |
|    `strokeWidth`   |       double      |                     `4`                     | The width of the progress line.                                                                                                                                                 |
| `emptyStrokeWidth` |       double      |                     `4`                     | The width of the line behind the progress line which show for reminding progress.                                                                                               |
|     `clockwise`    |      boolean      |                    `true`                   | The direction of turn of progress line, if you pass false, the progress line will be reversed, default value is true.                                                           |
|   `startPosition`  |       double      |       `0` (`StartPosition.topCenter`)       | Start position of progress line relative to the topCenter, you can pass a value from [StartPosition] class or custom double value you need.                                     |
|    `strokeAlign`   | SquareStrokeAlign |          `SquareStrokeAlign.inside`         | The stroke align of the progress line, pass a value from [SquareStrokeAlign] and read it's documents. see: https://api.flutter.dev/flutter/painting/BorderSide/strokeAlign.html |
|     `strokeCap`    |     StrokeCap?    |              `StrokeCap.round`              | The stroke cap of the progress line and empty line, see: https://api.flutter.dev/flutter/dart-ui/StrokeCap.html                                                                 |
|       `child`      |      Widget?      |                    `null`                   | The child widget, it can be a text or everything you need.                                                                                                                      |

Feel free to create issue or pull requests in [github repository](https://github.com/amir14a/square_progress_indicator)!