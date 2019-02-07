import neovim
import base64
from myplugin.utils import nvim_utils

@neovim.plugin
class Base64(object):

    def __init__(self, nvim):
        self.nvim = nvim

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
