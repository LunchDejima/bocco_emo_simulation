import 'package:bocco_emo_simulation/etc/style.dart';
import 'package:bocco_emo_simulation/etc/utils.dart';
import 'package:bocco_emo_simulation/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    print('set up all');
  });
  setUp(() {
    print('set up');
  });
  tearDown(() {
    print('tear down');
  });
  tearDownAll(() {
    print('tear down all');
  });

  test('style test', () {
    const lightStyle = Style.light;
    expect(lightStyle.colorSheme.primary, const Color(0xFF9439C4));
  });

  test('router test', () {
    expect(routerState.state, Uri(path: '/'));

    routerState.change(Uri(path: '/nextpage'));
    expect(routerState.state, Uri(path: '/nextpage'));
    
    routerState.pop();
    expect(routerState.state, Uri(path: '/'));
  });

  test('utils test', () {
    expect(Utils.validateEmail('val'), false);
    expect(Utils.validateEmail('test@test.com'), true);
  });
}
