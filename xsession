test -f ~/.xsession.local && source ~/.xsession.local

# Load xmodmap changes and xresources changes.
test -f ~/.Xmodmap    && xmodmap ~/.Xmodmap
test -f ~/.Xresources && xrdb -merge ~/.Xresources

autocutsel -fork
autocutsel -selection PRIMARY -fork
