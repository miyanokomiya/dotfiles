def get_cursor_pos(nvim):
    """ cursor行位置取得 """

    cursor_r, cursor_c = nvim.eval('getpos(".")[1:2]')
    return cursor_r, cursor_c


def get_visual_pos(nvim):
    """ visual範囲取得 """

    start_r, start_c = nvim.eval('getpos("\'<")[1:2]')
    end_r, end_c = nvim.eval('getpos("\'>")[1:2]')
    return start_r, start_c, end_r, end_c


def get_text(nvim, start_r, start_c, end_r, end_c):
    """ 指定範囲のテキスト取得 """

    lines = nvim.current.buffer.range(start_r, end_r)
    text = ''
    for c, line in enumerate(lines):
        if c == 0:
            if lines.__len__() == 1:
                text += line[start_c - 1:end_c]
            else:
                text += line[start_c - 1:]
        elif c < lines.__len__() - 1:
            text += '\n' + line
        else:
            text += '\n' + line[0:end_c]
    return text
