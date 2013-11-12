scriptpath=$(cd "$(dirname "$0")"; pwd)
emacs -q -l $scriptpath/.emacs
