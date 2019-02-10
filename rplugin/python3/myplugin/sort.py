import neovim
from myplugin.utils import nvim_utils
from myplugin.utils import sort_utils


@neovim.plugin
class Sort(object):

    def __init__(self, nvim):
        self.nvim = nvim

    @neovim.command("Sort", range='', nargs='1')
    def sort(self, args, range):
        #  valid, mess = nvim_utils.valid_first_arg(args, ['num'])
        #  if not valid:
        #      self.nvim.err_write(mess)
        #      return

        #  start_r, end_r = nvim_utils.get_visual_pos(self.nvim)[::2]
        #  self.nvim.current.buffer[
        #      start_r-1:end_r-1] = sort_utils.sort_by_number(
        #          self.nvim.current.buffer[start_r-1:end_r-1])
        'aaa'
