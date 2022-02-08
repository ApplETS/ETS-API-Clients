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
- `authenticate({String username, String password})`

SignetsAPI:
- `authenticate({String username, String password})`
- `getCoursesActivities({String username, String password, String session = "", String courseGroup = "", DateTime startDate, DateTime endDate})`
- `getScheduleActivities({String username, String password, String session = ""})`
- `getCourses({String username, String password})`
- `getCourseSummary({String username, String password, Course course})`
- `getStudentInfo({String username, String password})`
- `getStudentInfo({String username, String password})`
- `getPrograms({String username, String password})`
- `getCourseReviews({String username, String password, Session session})`

## Getting started

To start using this package, it's as simple as to import the package in your pubspec.yaml file using the git tg of the desired version:
```yaml
dependencies:
  ...
  signets_api_client: 
    git:
      url: https://github.com/ApplETS/ETS-API-Clients.git
      ref: v0.3.1
```

## Usage

To use this library you can create an instance of the `SignetsApiClient` class. You will first need to import the clients file from the package. Then, call any function that you whish to use.

```dart

import 'package:signets_api_client/clients.dart';

  // ...
  
  final programs = await SignetsAPIClient().getPrograms(username: "user", password: "pwd");
  final monEtsUser = await MonETSAPIClient().getPrograms(username: "user", password: "pwd");
```

Or using getIt:
```dart
  locator.registerLazySingleton(() => SignetsAPIClient());
  
  // from anywhere in your code (and easily mockable)
  
  locator<SignetsAPIClient>().getStudentInfo(username: "user", password: "pwd");
```

To import models or exceptions used in this package you can use these simples imports:
```dart
import 'package:signets_api_client/models.dart';
import 'package:signets_api_client/exceptions.dart';
```
## Mock

Mocks are provided by this package for each client if you import:
```dart
import 'package:signets_api_client/testing.dart';

SignetsAPIClientMock.stubGetCourseSummary(mock, "username", course,
      summaryToReturn: mySummary);
```

You can use the static class to stub any function present in the [Features](#Features) section of this doc. Couples of things to know:
- The password is `anyNamed` which means it could be any password passed as parameter to stub this entry.
- You can also stub Exception:
```dart
SignetsAPIClientMock.stubGetCourseSummaryException(mock, "username", course,
      exceptionToThrow: MyException("An exception occurs while accessing get course summary"));
```

## Additional information

This package is the property of App|ETS, an ÉTS club. It is licensed under the [Apache 2.0](LICENSE). 
