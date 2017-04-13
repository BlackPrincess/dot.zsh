function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    #BUFFER=$(\history -n 1 | \
    #    eval $tac | \
    #    peco --query "$LBUFFER")
		BUFFER=$(\history 1 | \
			sort -r -k 2 |\
			uniq -1 | \
			sort -r | \
			awk '$1=$1' | \
			cut -d" " -f 2- | \
			peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
