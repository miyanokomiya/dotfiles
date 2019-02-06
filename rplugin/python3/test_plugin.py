import neovim
import base64

@neovim.plugin
class TestPlugin(object):

    def __init__(self, nvim):
        self.nvim = nvim

    @neovim.command("DecodeBase64", range='', nargs='?')
    def decodebase64(self, args, range):
        # visual or 引数でbase64文字列を指定
        text = self.getVisualText() if len(args) == 0 else args[0]
        try:
            decoded = base64.b64decode(text).decode('utf-8')
            self.nvim.out_write(decoded + '\n')
        except Exception as e:
            self.nvim.out_write('Failed to decode: {}\n'.format(e.args))

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
