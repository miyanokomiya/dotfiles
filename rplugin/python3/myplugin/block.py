import neovim
from myplugin.utils import nvim_utils
from myplugin.utils import indent_utils

@neovim.plugin
class Block(object):

    def __init__(self, nvim):
        self.nvim = nvim

    @neovim.command("Block", range='', nargs='1')
    def block_jump(self, args, range):
        if args[0] not in ('d', 'u'):
            self.nvim.err_write('Invalid args: only "d" or "u"\n')
            return

        cursor_r, cursor_c = self.get_next_block() if args[0] == 'd' else self.get_pre_block()
        self.nvim.call('cursor', (cursor_r, cursor_c))

    def get_next_block(self):
        cursor_r, cursor_c = nvim_utils.get_cursor_pos(self.nvim)
        lines = self.nvim.current.buffer[cursor_r - 1:]
        return cursor_r + indent_utils.get_next_block(lines) , cursor_c

    def get_pre_block(self):
        cursor_r, cursor_c = nvim_utils.get_cursor_pos(self.nvim)
        lines = self.nvim.current.buffer[:cursor_r]
        return indent_utils.get_pre_block(lines) + 1, cursor_c
