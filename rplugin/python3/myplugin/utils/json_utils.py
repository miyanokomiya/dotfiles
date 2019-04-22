import json
from collections import OrderedDict


def parse(lines):
    """ パース """

    decoder = json.JSONDecoder(object_pairs_hook=OrderedDict)
    return decoder.decode('\n'.join(lines))


def valid_line(line):
    """ json行バリデーション """

    lstriped = line.lstrip()
    if len(lstriped) == 0:
        return False

    if lstriped[0] == '#':
        return False

    if lstriped[0] == '/':
        return False

    return True


def seek_key(lines, index):
    """ キー階層シーク """

    ret = '.'
    current_indent = 10000  # 十分に大きなインデントを初期値としておく

    for line in lines[:index + 1][::-1]:
        if not valid_line(line):
            continue

        indent = len(line) - len(line.lstrip())
        if indent >= current_indent:
            continue

        splited = line.split(':')
        if len(splited) <= 1:
            continue

        ret = '.' + splited[0].strip().replace("'", '').replace('"', '') + ret
        current_indent = indent
        if current_indent == 0:
            break

    # . が余分に付くので削除
    return ret[1:-1]
