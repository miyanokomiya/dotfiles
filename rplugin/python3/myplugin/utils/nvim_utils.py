def get_visual_pos(nvim):
    """ visual範囲取得 """

    start_r, start_c = nvim.eval('getpos("\'<")[1:2]')
    end_r, end_c = nvim.eval('getpos("\'>")[1:2]')
    return start_r, start_c, end_r, end_c

