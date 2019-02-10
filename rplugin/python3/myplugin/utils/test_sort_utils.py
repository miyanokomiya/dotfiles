from unittest import TestCase
from utils import sort_utils


class TestSortModule(TestCase):
    """ sort汎用処理のテスト """

    def test_sort_csv(self):
        """ sort_csvのテスト """

        test_patterns = [
            ('c, a, d, b', 'a, b, c, d'),  # 基本型
            ('c: a, a: c, d: 1, b: 11', 'a: c, b: 11, c: a, d: 1'),  # json型
        ]

        for lines, result in test_patterns:
            with self.subTest(lines=lines, result=result):
                self.assertEqual(sort_utils.sort_csv(lines), result)

    def test_sort_by_number(self):
        """ sort_by_numberのテスト """

        test_patterns = [
            # 基本型
            (('2c', '1a', '3d', '0b'), ('0b', '1a', '2c', '3d')),
            # 引数の型を維持
            (['2c', '1a', '3d', '0b'], ['0b', '1a', '2c', '3d']),
            # 文字のみは末尾
            (['2c', 'g', 'f', '0b'], ['0b', '2c', 'f', 'g']),
            # 同じ数値は後ろの文字でソート
            (['2c', '2g', '3', '1f', '1b'], ['1b', '1f', '2c', '2g', '3']),
            # 小数点あり
            (('2.1c', '2.0a', '2d', '2.2b'), ('2.0a', '2d', '2.1c', '2.2b')),
        ]

        for lines, result in test_patterns:
            with self.subTest(lines=lines, result=result):
                self.assertEqual(sort_utils.sort_by_number(lines), result)
