# API Client

A package for interacting with the Blueprint APIs

## Overview

The API Client package provides a set of tools for interacting with the Blueprints APIs. It offers a set of `resources`, ideally one for each domain context we have on the app. For now, you can find 2 resources on the app:

- PlaformResource: the resource in charge of accessing the Platform database to retrieve all the available platforms the user has for integrating with.
- UserResource: the resource in charge of accessing user specific data on the database. 


## Installation

To use the API Client package in your project, add it as a dependency in your `pubspec.yaml` file:
```yaml
dependencies:
  api_client: ^1.0.0
```

```bash
flutter pub get
```

## Usage
To use the API Client package in your code, import it as follows:
```dart
import 'package:api_client/api_client.dart';
```


Then, you can start using the provided classes and utilities to interact with API clients in your application. 

### Models

This package makes use of the newly implemented `records` on dart 3 to define data structure. With the records we can deconstruct easier, which is good for parsing, and we also avoid shadowing on the names since `Records` are equal by structure. 

You can find all the models under the `models` folder.


### Resources

This package exposes a collection of resources for accessing the apis of Blueprint. You can find all the resources under the `resources` folder. 

### Usage Example
```dart
class UserRepository {
  final UserResource _userResource;

  UserRepository({
    required UserResource userResource,
  }) : _userResource = userResource;

  Stream<List<Authenticator>> getConnectedAuthenticators() {
    final authenticatorsStream = _userResource.getConnectedAuthenticators();

    return authenticatorsStream.map(
      (authenticators) {
        return authenticators.map(
          (authenticator) {
            final (:id, :platformName, :type, user: user) = authenticator;

            return Authenticator(
              id: id,
              platformName: platformName,
              type: type,
              user: User(
                email: user.email,
                name: user.name,
              ),
            );
          },
        ).toList();
      },
    );
  }

  void connectAuthenticator(Map<String, dynamic> params) {
    _userResource.connectAuthenticator(params);
  }
}
```

## Testing

Testing is a crucial part on this package. Since this package is the connection point between external sources and internal code, it's crucial that we ensure everything works as expected. To achieve that, we are using 2 types of tests. 


### Unit Tests

Located on the `test` folder. This tests are the ones ensuring that the resources are working as expected as small unit pieces. 
To run the tests, run the following command:
```bash
flutter test .
```

### End To End Tests

Located on the `integration_test` folder, by leveraging the use of local env using firebase emulators, we have a collection of tests that control the entire system. This tests are not part of the ci pipeline yet, but may be in a future. The main idea with this type of tests, is ensuring that the system works correctly and that the `api_client` dependent packages will work correctly in compiling time. 

To achieve that, this package depends on `firebase_dev_access`, a package with some utils to firebase local env.

#### Installing dependencies

To run these tests, you will have to install some external dependencies first:

- [NodeJS](https://nodejs.org/en/download/)
- [Chrome](https://www.google.com/chrome/)
- [Chromedriver](https://sites.google.com/chromium.org/driver/)
- [FirebaseCLI](https://firebase.google.com/docs/cli)

#### Running tests

- First start your local emulators. See main project Readme in case of doubts.
- Start `chromedriver` service: 

```bash 
chromedriver --port=4444
```

- Run the tests:
```bash
flutter drive --driver=integration_driver/integration_test_driver.dart --target=integration_test/main.dart --dart-define-from-file=../.././firebase.json  -d chrome
```

This should open a chrome instance and run all the tests from the file. Please note that we are using relative imports, so in order to run this test you will have to be inside `packages/api_client`. 
