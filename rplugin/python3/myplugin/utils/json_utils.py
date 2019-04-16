import json
from collections import OrderedDict


def parse(lines):
    """ パース """

    decoder = json.JSONDecoder(object_pairs_hook=OrderedDict)
    return decoder.decode('\n'.join(lines))
