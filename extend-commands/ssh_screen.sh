function ssh_screen()
{
  eval server=\${$#}
  /usr/bin/screen -t $server ssh "$@"
}