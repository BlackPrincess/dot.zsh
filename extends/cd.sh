 # cdコマンド実行後、lsを実行する
 function cd() {
   builtin cd $@ && ls;
 }
