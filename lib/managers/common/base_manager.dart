import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/locator.dart';

abstract class BaseManager<T extends Object> {
  @protected
  late T api;

  BaseManager({mockedApi}) {
    api = mockedApi ?? getSingleton<T>();
  }
}
