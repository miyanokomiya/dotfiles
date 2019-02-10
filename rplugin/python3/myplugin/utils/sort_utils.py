import re
from functools import cmp_to_key


def sort_csv(lines):
    """ CSV文字列のソート """

    splitedList = map(lambda s: s.strip(), lines.split(','))
    sortedList = sorted(splitedList)
    return ', '.join(sortedList)


def sort_object(lines):
    """ TODO Object文字列のソート """

    return lines


class _LineWithNumInfo():
    """ 数値始まり行情報 """

    def __init__(self, line):
        self.line = line

        num_str = re.match(r'([+-]?[0-9]+\.?[0-9]*)', line)
        if num_str:
            self.num = float(num_str.group(0))
            self.str = line[len(num_str.group(0)):]
        else:
            self.num = float('inf')
            self.str = line

    def compare(self, other):
        if self.num != other.num:
            return self.num - other.num

        if self.str > other.str:
            return 1
        elif self.str == other.str:
            return 0
        else:
            return -1


def sort_by_number(lines):
    """ 数値付きテキストのソート """

    infos = map(_LineWithNumInfo, lines)
    sorted_infos = sorted(infos, key=cmp_to_key(lambda a, b: a.compare(b)))
    return type(lines)(map(lambda info: info.line, sorted_infos))
