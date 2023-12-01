import 'package:api_client/api_client.dart';
import 'package:api_client/src/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './helper/helper.dart';

part 'resources/platform_resource_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  platformResourceIntegrationTest();
}
