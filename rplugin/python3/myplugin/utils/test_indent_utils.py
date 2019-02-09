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
            (' abc \t', 1),  # 末尾の空白は無視
            (' a b\tc', 1),  # 文中の空白は無視
        ]

        for line, result in test_patterns:
            with self.subTest(line=line, result=result):
                self.assertEqual(indent_utils.count(line), result)

    def test_get_next_block(self):
        """ get_next_blockのテスト """

        test_patterns = [
            (('abc', ' abc', 'abc', 'abc'), 2),
            (('abc', ' abc', '  abc', 'abc', 'abc'), 3),
            # 空行はスキップ
            (('abc', ' abc', '', '  abc', 'abc', 'abc'), 4),
            # インデントが減ったら終了
            (('  abc', ' abc', '  abc'), 1),
            # 開始から続く同レベルは無視
            ((' abc', ' abc', 'abc'), 2),
            (('abc', 'abc', 'abc', ' abc', 'abc'), 4),
            # 空行を挟んだ場合、開始から続く同レベルでも終了
            ((' abc', '', ' abc', 'abc'), 2),
            # 空行開始の場合、非空行で終了
            (('', '', ' abc', 'abc', 'abc'), 2),
        ]

        for i, (lines, result) in enumerate(test_patterns):
            with self.subTest(i=i, lines=lines, result=result):
                self.assertEqual(indent_utils.get_next_block(lines), result)

    def test_get_pre_block(self):
        """ get_pre_blockのテスト """

        test_patterns = [
            (('abc', 'abc', ' abc', 'abc'), 1),
            (('abc', 'abc', ' abc', '  abc', 'abc'), 1),
            (('abc', ' abc', ' abc', '  abc', 'abc'), 0),
        ]

        for i, (lines, result) in enumerate(test_patterns):
            with self.subTest(i=i, lines=lines, result=result):
                self.assertEqual(indent_utils.get_pre_block(lines), result)

    def test_get_not_empty_line(self):
        """ get_not_empty_lineのテスト """

        test_patterns = [
            (('abc', 'abc'), 0),
            (('', 'abc', 'abc'), 1),
            (('', '', 'abc', 'abc'), 2),
        ]

        for i, (lines, result) in enumerate(test_patterns):
            with self.subTest(i=i, lines=lines, result=result):
                self.assertEqual(
                        indent_utils.get_not_empty_line(lines), result)
