function history-ranking() {
  history 1|awk '{print $2}'|sort|uniq -c|sort -nr|head -n 10
}
