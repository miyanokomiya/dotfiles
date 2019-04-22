from unittest import TestCase
from utils import json_utils


class TestJsonModule(TestCase):
    """ json汎用処理のテスト """

    def test_parse(self):
        """ parseのテスト """

        test_patterns = [
                (['{"a": 1, "b": 2}'], {'a': 1, 'b': 2}), ]

        for lines, result in test_patterns:
            with self.subTest(lines=lines, result=result):
                self.assertEqual(json_utils.parse(lines), result)

    def test_seek_key(self):
        """ seek_keyのテスト """

        test_patterns = [
                (
                    ['{',
                     '  "a": "aaa"',
                     '}',
                     ],
                    1, 'a'),
                (
                    ['{',
                     '  "a": "aaa"',
                     '  "b": "bbb"',
                     '}',
                     ],
                    2, 'b'),
                (
                    ['{',
                     '  "a": "aaa"',
                     '  "b": {',
                     '    "c": "ccc"',
                     '  }',
                     '}',
                     ],
                    3, 'b.c'),
                (
                    ['{',
                     '  "b": {',
                     '    "c": "ccc"',
                     '  }',
                     '  "d": {',
                     '    "f": "fff"',
                     '  }',
                     '  "a": "aaa"',
                     '}',
                     ],
                    5, 'd.f'),
                (
                    ['// abcd: abcd',
                     '{',
                     '',
                     '  "a": "a:a:a"',
                     '  "b": {',
                     '  }',
                     "  'd': {",
                     '    "f": "fff"',
                     '    "g": "ggg"',
                     '  }',
                     '}',
                     ],
                    9, 'd.g'),
                ]

        for lines, index, result in test_patterns:
            with self.subTest(lines=lines, index=index, result=result):
                self.assertEqual(json_utils.seek_key(lines, index), result)
