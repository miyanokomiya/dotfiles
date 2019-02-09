import re
from functools import cmp_to_key


def sort_csv(lines):
    """ CSV文字列のソート """

    splitedList = map(lambda s: s.strip(), lines.split(','))
    sortedList = sorted(splitedList)
    return ', '.join(sortedList)


def sort_object(lines):
    """ Object文字列のソート """

    return lines


def sort_by_number(lines):
    """ 数値付きテキストのソート """

    pattern = r'([+-]?[0-9]+\.?[0-9]*)'
    num_lines = []
    without_num_lines = []
    for line in lines:
        num_str = re.match(pattern, line)
        if num_str:
            num_lines.append(
                    {'num': float(num_str.group(0)), 'line': line})
        else:
            without_num_lines.append(line)

    sorted_num_lines = sorted(
            num_lines, key=cmp_to_key(lambda a, b: a['num'] - b['num']))
    sorted_with_num_lines = list(
            map(lambda data: data['line'], sorted_num_lines))
    sorted_without_num_lines = sorted(without_num_lines)

    return type(lines)(sorted_with_num_lines + sorted_without_num_lines)
