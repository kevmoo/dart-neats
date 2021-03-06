// Copyright 2020 Garett Tok Ern Liang
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:yaml_edit/yaml_edit.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

void main() {
  test(
      'throws RangeError if invalid index + deleteCount combination is passed in',
      () {
    final doc = YamlEditor('[0, 0]');
    expect(() => doc.spliceList([], 1, 5, [1, 2]), throwsRangeError);
  });

  group('block list', () {
    test('(1)', () {
      final doc = YamlEditor('''
- 0
- 0
''');
      final nodes = doc.spliceList([], 1, 1, [1, 2]);
      expect(doc.toString(), equals('''
- 0
- 1
- 2
'''));

      expectDeepEquals(nodes.toList(), [0]);
    });

    test('(2)', () {
      final doc = YamlEditor('''
- 0
- 0
''');
      final nodes = doc.spliceList([], 0, 2, [0, 1, 2]);
      expect(doc.toString(), equals('''
- 0
- 1
- 2
'''));

      expectDeepEquals(nodes.toList(), [0, 0]);
    });

    test('(3)', () {
      final doc = YamlEditor('''
- Jan
- March
- April
- June
''');
      final nodes = doc.spliceList([], 1, 0, ['Feb']);
      expect(doc.toString(), equals('''
- Jan
- Feb
- March
- April
- June
'''));

      expectDeepEquals(nodes.toList(), []);

      final nodes2 = doc.spliceList([], 4, 1, ['May']);
      expect(doc.toString(), equals('''
- Jan
- Feb
- March
- April
- May
'''));

      expectDeepEquals(nodes2.toList(), ['June']);
    });
  });

  group('flow list', () {
    test('(1)', () {
      final doc = YamlEditor('[0, 0]');
      final nodes = doc.spliceList([], 1, 1, [1, 2]);
      expect(doc.toString(), equals('[0, 1, 2]'));

      expectDeepEquals(nodes.toList(), [0]);
    });

    test('(2)', () {
      final doc = YamlEditor('[0, 0]');
      final nodes = doc.spliceList([], 0, 2, [0, 1, 2]);
      expect(doc.toString(), equals('[0, 1, 2]'));

      expectDeepEquals(nodes.toList(), [0, 0]);
    });
  });
}
