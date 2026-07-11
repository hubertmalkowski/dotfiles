function open_note 
  set -l selection (zk list -f json | fzf)
  echo $selection
end
