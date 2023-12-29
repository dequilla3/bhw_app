import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

abstract class ProviderBase extends ChangeNotifier {
  final Localstore db = Localstore.instance;
}
