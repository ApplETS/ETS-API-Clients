<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A dart package to be able to handle all API calls from a main source. The code in this package was initially written by apomalyn inside our main project Notre-Dame. It was then ported to pub package by MysticFragilist. 

This package is also a way of standardized the models used across all projects that needs an access to SignETS API.

Also, it's now possible to use null safety on models and functions from this package. It's a good start in implementing null safety without refactoring all existing code :smile:

## Features
 With this package you can call specific method from multiple sources:

MonETSAPI:
- `authenticate()`

SignetsAPI:
- `authenticate()`
- `getCoursesActivities({String session = "", String courseGroup = "", DateTime startDate, DateTime endDate})`
- `getScheduleActivities({String session = ""})`
- `getCourses()`
- `getCourseSummary({Course course})`
- `getStudentInfo()`
- `getStudentInfo()`
- `getPrograms()`
- `getCourseReviews({Session session})`

## Getting started

To start using this package, it's as simple as to import the package in your pubspec.yaml file:
```yaml
dependencies:
  ...
  signets_api_client: ^0.1.0
```

## Usage

To use this library you can create an instance of the `SignetsApiClient` class. You will first need to import the clients file from the package. Then, call any function that you whish to use.

```dart

import 'package:signets_api_client/clients.dart';

// ...

  final signetsAPIClient = SignetsAPIClient(username, password);
  final programs = await signetsAPIClient.getPrograms();
```

To import models or exceptions used in this package you can use these simples imports:
```dart
import 'package:signets_api_client/models.dart';
import 'package:signets_api_client/exceptions.dart';
```
## Mock

TODO: Add a way to easily mock the clients.

## Additional information

This package is the property of App|ETS, an ÉTS club. It is licensed under the [Apache 2.0](LICENSE). 