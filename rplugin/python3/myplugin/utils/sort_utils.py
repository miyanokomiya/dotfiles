def sort_csv(text):
    """ CSV文字列のソート """

    splitedList = map(lambda s: s.strip(), text.split(','))
    sortedList = sorted(splitedList)
    return ', '.join(sortedList)


def sort_object(text):
    """ Object文字列のソート """

    return text
