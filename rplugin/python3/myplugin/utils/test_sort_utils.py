from unittest import TestCase
from utils import sort_utils

class TestSortModule(TestCase):
    """ sort汎用処理のテスト """

    def test_sort_csv(self):
        """ sort_csvのテスト """

        test_patterns = [
            ('c, a, d, b', 'a, b, c, d'), # 基本型
            ('c: a, a: c, d: 1, b: 11', 'a: c, b: 11, c: a, d: 1'), # json型
        ]

        for text, result in test_patterns:
            with self.subTest(text = text, result = result):
                self.assertEqual(sort_utils.sort_csv(text), result)
