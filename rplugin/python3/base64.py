import neovim
import base64

@neovim.plugin
class Base64(object):

    def __init__(self, nvim):
        self.nvim = nvim

    @neovim.command("Base64Decode", range='', nargs='?')
    def decode(self, args, range):
        try:
            decoded = base64.b64decode(self.getText(args)).decode('utf-8')
            self.nvim.out_write(decoded + '\n')
        except Exception as e:
            self.nvim.err_write('Failed to decode: {}\n'.format(e.args))

    def getText(self, args):
        # visual or 引数でbase64文字列を指定
        return self.getVisualText() if len(args) == 0 else args[0]

    def getVisualText(self):
        start_r, start_c = self.nvim.eval('getpos("\'<")[1:2]')
        end_r, end_c = self.nvim.eval('getpos("\'>")[1:2]')
        lines = self.nvim.current.buffer.range(start_r, end_r)
        text = ''
        for c, line in enumerate(lines):
            if c == 0:
                if lines.__len__() == 1:
                    text += line[start_c - 1:end_c]
                else:
                    text += line[start_c - 1:]
            elif c < lines.__len__() - 1:
                text += line
            else:
                text += line[0:end_c]
        return text
