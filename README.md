# Todos

A Todo application, written in clean architechture, connected to Hive as local database

The project's structure is based on clean architecture, based on this article: 
https://devmuaz.medium.com/flutter-clean-architecture-series-part-1-d2d4c2e75c47

The state management library used is flutter_bloc, and this project also based on Todo example of Felix Angelov: 
https://github.com/felangel/Bloc/tree/master/examples/flutter_todos

## Getting Started

First run the code generator:  
``` 
dart run build_runner build 
```

Then you might run Flutter app:
``` 
flutter run
```

To run unit test
```
flutter test test/test.dart
```

To run integration test
```
flutter test integration_test/app_test.dart
```