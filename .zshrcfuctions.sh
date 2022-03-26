filevars="$HOME/.vars.txt"     	
filevarschoise="$HOME/.varschoise.txt"

writevartmux(){
  [ -f $filevars ] || touch $filevars  
  case "$#" in
  2)
    if grep $1 $filevars &> /dev/null; then
       value=$(grep $1 $filevars | cut -f 2 -d '=')
       line=$(grep -n $1 $filevars | cut -f 1 -d ':')
       sed -i -e "$line s/$value/$2/g" $filevars	         
    else
      echo $1=$2 >> $filevars	    
      [ $( wc -l $filevars | awk '{print $1}' ) = "1" ] && echo $1=$2 > $filevarschoise
    fi
    echo "$1=$2 is new var in tmux vars"    
  ;;
  1)
    if [ "$1" = 'clear' ]; then
       rm $filevars $filevarschoise && touch $filevars $filevarschoise	     
       echo "clear all vars in tmuxvars" 
    else	     
      if grep $1 $filevars &> /dev/null; then
         grep $1 $filevars > $filevarschoise
      else
         echo "$1 dont exits"
         return 1
      fi    
      echo "$1 is fixed var now"
    fi
  ;;
  *)
    echo "writevartmux name value : create/update vars"
    echo "writevartmux name       : choise var"
    echo "writevartmux clear      : clear all vars"
    return 1
  ;;
  esac
}
readvartmux(){
  case "$#" in
  1)
    grep "$1=" $filevars | cut -f 2 -d '='
  ;;
  *)  
    while IFS= read -r line
    do
       grep "$( echo $line | cut -f1 -d '=' )=" $filevarschoise &>/dev/null && echo -n "--> "  
       echo "$line" 
    done < $filevars
  ;;
  esac
}
