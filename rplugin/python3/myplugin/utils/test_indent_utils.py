from unittest import TestCase
from utils import indent_utils

class TestIndentModule(TestCase):
    """ indent汎用処理のテスト """

    def test_count(self):
        """ countのテスト """

        test_patterns = [
            ('abc', 0),
            (' abc', 1),
            ('  abc', 2),
            ('\tabc', 1),
            ('\t\tabc', 2),
            (' \tabc', 2),
            (' abc \t', 1), # 末尾の空白は無視
            (' a b\tc', 1), # 文中の空白は無視
        ]

        for line, result in test_patterns:
            with self.subTest(line = line, result = result):
                self.assertEqual(indent_utils.count(line), result)

    def test_get_next_block(self):
        """ get_next_blockのテスト """

        test_patterns = [
            (('abc', ' abc', 'abc', 'abc'), 2),
            (('abc', ' abc', '  abc', 'abc', 'abc'), 3),
            (('abc', ' abc', '', '  abc', 'abc', 'abc'), 4), # 空行はスキップ
        ]

        for lines, result in test_patterns:
            with self.subTest(lines = lines, result = result):
                self.assertEqual(indent_utils.get_next_block(lines), result)

    def test_get_pre_block(self):
        """ get_pre_blockのテスト """

        test_patterns = [
            (('abc', 'abc', ' abc', 'abc'), 1),
            (('abc', 'abc', ' abc', '  abc', 'abc'), 1),
            (('abc', ' abc', ' abc', '  abc', 'abc'), 0),
        ]

        for lines, result in test_patterns:
            with self.subTest(lines = lines, result = result):
                self.assertEqual(indent_utils.get_pre_block(lines), result)
