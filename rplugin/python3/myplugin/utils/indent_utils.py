def count(line):
    """ インデント数取得 """

    return len(line) - len(line.lstrip())


def get_next_block(lines):
    """ 次のブロック取得 """

    # 空行開始の場合は非空行で終了
    if lines[0].strip() == '':
        return get_not_empty_line(lines)

    target_indent = count(lines[0])
    changed = False
    for i, line in enumerate(lines[1:]):
        if line.strip() == '':
            changed = True
            continue
        indent = count(line)
        if indent < target_indent:
            return i + 1
        elif indent == target_indent:
            if changed:
                return i + 1
        else:
            changed = True
    return len(lines)


def get_pre_block(lines):
    """ 前のブロック取得 """

    return len(lines) - 1 - get_next_block(lines[::-1])


def get_not_empty_line(lines):
    """ 非空行取得 """

    for i, line in enumerate(lines):
        if line.strip() != '':
            return i
