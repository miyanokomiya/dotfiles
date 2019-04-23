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
