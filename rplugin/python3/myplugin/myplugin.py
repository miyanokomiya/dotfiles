import neovim
import base64
from myplugin.utils import indent_utils
from myplugin.utils import nvim_utils
from myplugin.utils import sort_utils


@neovim.plugin
class MyPlugin(object):

    def __init__(self, nvim):
        self.nvim = nvim
        self.cursor_hash = {}

    @neovim.command("Base64Decode", range='', nargs='?')
    def decode(self, args, range):
        try:
            decoded = base64.b64decode(self.get_text(args)).decode('utf-8')
            self.nvim.out_write(decoded + '\n')
        except Exception as e:
            self.nvim.err_write('Failed to decode: {}\n'.format(e.args))

    def get_text(self, args):
        # visual or 引数でbase64文字列を指定
        return self.get_visual_text() if len(args) == 0 else args[0]

    def get_visual_text(self):
        start_r, start_c, end_r, end_c = nvim_utils.get_visual_pos(self.nvim)
        return nvim_utils.get_text(self.nvim, start_r, start_c, end_r, end_c)

    @neovim.command("Block", range='', nargs='1')
    def block_jump(self, args, range):
        valid, mess = nvim_utils.valid_first_arg(args, ['d', 'u'])
        if not valid:
            self.nvim.err_write(mess)
            return

        r, c = 1, 1
        if args[0] == 'd':
            r, c = self.get_next_block()
        else:
            r, c = self.get_pre_block()
        nvim_utils.set_cursor_pos(self.nvim, r, c)

    def get_next_block(self):
        cursor_r, cursor_c = nvim_utils.get_cursor_pos(self.nvim)
        lines = self.nvim.current.buffer[cursor_r - 1:]
        return cursor_r + indent_utils.get_next_block(lines), cursor_c

    def get_pre_block(self):
        cursor_r, cursor_c = nvim_utils.get_cursor_pos(self.nvim)
        lines = self.nvim.current.buffer[:cursor_r]
        return indent_utils.get_pre_block(lines) + 1, cursor_c

    @neovim.command("Sort", range='', nargs='1')
    def sort(self, args, range):
        valid, mess = nvim_utils.valid_first_arg(args, ['num'])
        if not valid:
            self.nvim.err_write(mess)
            return

        start_r, end_r = nvim_utils.get_visual_pos(self.nvim)[::2]
        self.nvim.current.buffer[
            start_r-1:end_r-1] = sort_utils.sort_by_number(
                self.nvim.current.buffer[start_r-1:end_r-1])

    @neovim.autocmd(
            'BufWinLeave', pattern='*', eval='expand("<afile>")', sync=True)
    def save_cursor(self, filename):
        self.cursor_hash[filename] = nvim_utils.get_cursor_pos(self.nvim)

    @neovim.autocmd(
        'BufWinEnter', pattern='*', eval='expand("<afile>")', sync=True)
    def restore_cursor(self, filename):
        # bufferに残っていない情報を削除
        buffer_names = nvim_utils.get_buffer_names(self.nvim)
        for key in list(self.cursor_hash.keys()):
            if key not in buffer_names:
                del self.cursor_hash[key]
        # カーソル復元
        if filename in self.cursor_hash:
            nvim_utils.set_cursor_pos(self.nvim, *self.cursor_hash[filename])
