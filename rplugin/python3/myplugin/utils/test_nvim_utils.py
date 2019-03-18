from unittest import TestCase
from utils import nvim_utils


class TestNvimModule(TestCase):
    """ nvim汎用処理のテスト """

    def test_get_visual_pos(self):
        """ get_visual_posのテスト """

        class Nvim():
            def __init__(self, start_r, start_c, end_r, end_c):
                self.start_r = start_r
                self.start_c = start_c
                self.end_r = end_r
                self.end_c = end_c

            def eval(self, command):
                if command == 'getpos("\'<")[1:2]':
                    return self.start_r, self.start_c
                elif command == 'getpos("\'>")[1:2]':
                    return self.end_r, self.end_c
                else:
                    raise ValueError("invalid command!")

        test_patterns = [
            (1, 2, 1, 3),
            (1, 2, 2, 6),
            (1, 2, 3, 1),
        ]

        for start_r, start_c, end_r, end_c in test_patterns:
            with self.subTest(start_r=start_r,
                              start_c=start_c,
                              end_r=end_r,
                              end_c=end_c):
                nvim = Nvim(start_r, start_c, end_r, end_c)
                self.assertEqual(
                        nvim_utils.get_visual_pos(nvim),
                        (start_r, start_c, end_r, end_c))

    def test_get_text(self):
        """ get_textのテスト """

        class Nvim():
            def __init__(self, lines):
                self.lines = lines

                class Current:
                    def __init__(self):
                        class Buffer:
                            def range(self, start_r, end_r):
                                return lines
                        self.buffer = Buffer()
                self.current = Current()

        lines = ['1234567890', 'abcdefgh', '0987654321']
        test_patterns = [
            (1, 2, 1, 3, '23'),
            (1, 2, 2, 6, '234567890\nabcdef'),
            (1, 2, 3, 1, '234567890\nabcdefgh\n0'),
        ]

        for start_r, start_c, end_r, end_c, text in test_patterns:
            with self.subTest(start_r=start_r,
                              start_c=start_c,
                              end_r=end_r,
                              end_c=end_c,
                              text=text):
                nvim = Nvim(lines[start_r - 1:end_r])
                self.assertEqual(
                        nvim_utils.get_text(nvim,
                                            start_r,
                                            start_c,
                                            end_r,
                                            end_c),
                        text)

    def test_get_buffer_names(self):
        """ get_buffer_namesのテスト """

        class Nvim():
            def __init__(self, bufnr):
                self.bufnr = bufnr

            def eval(self, command):
                if command == 'bufnr("$")':
                    return bufnr
                elif command == 'bufname(1)':
                    return '1_name'
                elif command == 'bufname(3)':
                    return '3_name'
                else:
                    return None

        test_patterns = [
            (1, ['1_name']),
            (2, ['1_name']),
            (3, ['1_name', '3_name']),
        ]

        for bufnr, buffers in test_patterns:
            with self.subTest(bufnr=bufnr, buffers=buffers):
                nvim = Nvim(bufnr)
                self.assertEqual(nvim_utils.get_buffer_names(nvim), buffers)
