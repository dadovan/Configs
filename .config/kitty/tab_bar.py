# https://github.com/kovidgoyal/kitty/discussions/4447
import datetime

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.rgb import Color
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_title,
)
from kitty.utils import color_as_int

timer_id = None

# TODO: Better way to do these
color_080808: int = as_rgb(color_as_int(Color(8, 8, 8)))
color_3b4252: int = as_rgb(color_as_int(Color(59, 66, 82)))
color_5e81ac: int = as_rgb(color_as_int(Color(94, 129, 172)))
color_88c0d0: int = as_rgb(color_as_int(Color(136, 192, 208)))
color_e4e4e4: int = as_rgb(color_as_int(Color(228, 228, 228)))
color_black: int = as_rgb(color_as_int(Color(0, 0, 0, 0)))
color_white: int = as_rgb(color_as_int(Color(255, 255, 255)))


def calc_draw_spaces(*args) -> int:
    length = 0
    for i in args:
        if not isinstance(i, str):
            i = str(i)
        length += len(i)
    return length


def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    screen.cursor.bold = screen.cursor.italic = False

    if draw_data.leading_spaces:
        screen.draw(" " * draw_data.leading_spaces)
    # TODO: Improve this
    if tab.layout_name == "splits":
        layout_icon = ''
    elif tab.layout_name == 'fat':
        layout_icon = ''
    elif tab.layout_name == "tall":
        layout_icon = ''
    elif tab.layout_name == "stack":
        layout_icon = ''
    else:
        layout_icon = tab.layout_name

    if tab.is_active:
        cells = [
            (color_88c0d0, color_3b4252, ''),
            (color_black, color_88c0d0, f'{index} {layout_icon}  {tab.title}'),
            (color_88c0d0, color_3b4252, '')
        ]
    else:
        cells = [
            (color_5e81ac, color_3b4252, ''),
            (color_white, color_5e81ac, f'{index} {layout_icon}  {tab.title}'),
            (color_5e81ac, color_3b4252, '')
        ]

    if index == 1:
        cells = [(color_3b4252, color_080808, '')] + cells

    for fg, bg, text in cells:
        screen.cursor.fg = fg
        screen.cursor.bg = bg
        screen.draw(text)

    trailing_spaces = min(max_title_length - 1, draw_data.trailing_spaces)
    max_title_length -= trailing_spaces
    extra = screen.cursor.x - before - max_title_length
    if extra > 0:
        screen.cursor.x -= extra + 1
        screen.draw("…")
    if trailing_spaces:
        screen.draw(" " * trailing_spaces)
    end = screen.cursor.x
    return end


def _draw_right_status(screen: Screen, is_last: bool) -> int:
    if not is_last:
        return 0

    date = datetime.datetime.now().strftime("%H:%M")
    utc_date = datetime.datetime.now(datetime.timezone.utc).strftime("%H:%M")
    clock = f'🕘{date} ({utc_date} UTC)'
    right_status_length = calc_draw_spaces(clock) + 4

    draw_attributed_string(Formatter.reset, screen)
    screen.cursor.bg = color_3b4252
    draw_spaces = screen.columns - screen.cursor.x - right_status_length
    if draw_spaces > 0:
        screen.draw(' ' * draw_spaces)

    cells = [
        (color_5e81ac, color_3b4252, ''),
        (color_white, color_5e81ac, f'🕘{date} ({utc_date} UTC)'),
        (color_5e81ac, color_3b4252, ''),
        (color_3b4252, color_080808, '')
    ]

    for fg, bg, text in cells:
        screen.cursor.fg = fg
        screen.cursor.bg = bg
        screen.draw(text)

    if screen.columns - screen.cursor.x > right_status_length:
        screen.cursor.x = screen.columns - right_status_length

    return screen.cursor.x


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    _draw_left_status(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index,
        is_last,
        extra_data,
    )
    _draw_right_status(
        screen,
        is_last,
    )

    return screen.cursor.x
