google() {
    local str opt
    if [ $# != 0 ]; then
        for s in $*; do
            # and検索
            str="$str${str:++}$s"
        done
        opt='search?num=100'
        opt="${opt}&q=${str}"
    fi
    open -a Google\ Chrome http://www.google.co.jp/$opt
}
