def count(line):
    """ インデント数取得 """

    return len(line) - len(line.lstrip())

def get_next_block(lines):
    """ 次のブロック取得 """

    target_indent = count(lines[0])
    for i, line in enumerate(lines[1:]):
        if line.strip() == '': continue

        if count(line) == target_indent:
            return i + 1
    return len(lines)

def get_pre_block(lines):
    """ 前のブロック取得 """

    return len(lines) -1 - get_next_block(lines[::-1])
