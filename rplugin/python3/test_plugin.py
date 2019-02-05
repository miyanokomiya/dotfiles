import neovim

@neovim.plugin
class TestPlugin(object):

    def __init__(self, nvim):
        self.nvim = nvim

    @neovim.function("TestFunction", sync=True)
    def testfunction(self, args):
        return 3

    @neovim.command("TestCommand", range='', nargs='*')
    def testcommand(self, args, range):
        #  self.nvim.current.line = ('Command with args: {}, <: {}, >: {}'
        #          .format(args, self.nvim.eval('getpos("\'<")[1:2]'), self.nvim.eval('getpos("\'>")[1:2]')))
        #  print(self.nvim.current.range)
        start_r, start_c = self.nvim.eval('getpos("\'<")[1:2]')
        end_r, end_c = self.nvim.eval('getpos("\'>")[1:2]')
        self.nvim.out_write('start_r: {}, start_c: {}, '.format(start_r, start_c))
        self.nvim.out_write('end_r: {}, end_c: {} \n'.format(end_r, end_c))

    @neovim.autocmd('BufEnter', pattern='*.py', eval='expand("<afile>")', sync=True)
    def on_bufenter(self, filename):
        self.nvim.out_write("testplugin is in " + filename + "\n")
