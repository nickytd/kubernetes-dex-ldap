function check_executables {
  execs=(helm kubectl)
  for e in ${execs[@]}; do
    if ! command -v $e &> /dev/null ; then
      echo "$e is required"
      exit
    fi  
  done
}