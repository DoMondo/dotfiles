
transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
   tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; } 

ix() {
      local opts
      local OPTIND
      [ -f "$HOME/.netrc" ] && opts='-n'
      while getopts ":hd:i:n:" x; do
         case $x in
            h) echo "ix [-d ID] [-i ID] [-n N] [opts]"; return;;
            d) $echo curl $opts -X DELETE ix.io/$OPTARG; return;;
            i) opts="$opts -X PUT"; local id="$OPTARG";;
            n) opts="$opts -F read:1=$OPTARG";;
         esac
      done
      shift $(($OPTIND - 1))
      [ -t 0 ] && {
      local filename="$1"
      shift
      [ "$filename" ] && {
      curl $opts -F f:1=@"$filename" $* ix.io/$id
      return
   }
   echo "^C to cancel, ^D to send."
}
curl $opts -F f:1='<-' $* ix.io/$id
  }

# Find by file-name and edit
vf () {
    find . -type f -name "$1" -exec vim {} \+
}

# Find by file-name and change dir
cf () {
    if [[ -d "$1" ]]; then
        cd -- "$(find . -name "$1" -type d -print -quit 2>/dev/null)"
    else  # file, symbolic link, etc...
        local file_abs_path="$(find . -name "$1" -print -quit 2>/dev/null)"
        cd -- "$(dirname $file_abs_path)"
    fi
}

dcleanup(){
    local containers
    containers=( $(docker ps -aq 2>/dev/null) )
    docker rm "${containers[@]}" 2>/dev/null
    local volumes
    volumes=( $(docker ps --filter status=exited -q 2>/dev/null) )
    docker rm -v "${volumes[@]}" 2>/dev/null
    local images
    images=( $(docker images --filter dangling=true -q 2>/dev/null) )
    docker rmi "${images[@]}" 2>/dev/null
}

# Git stuff
#alias gitCleanMergedFeatures="git branch -r --merged \
    #| grep /feature/  \
    #| cut -d '/' -f 2-  \
    #| xargs -rn1 git push origin --delete"

#alias gitRenameBranch='f() {git checkout feature/$1 && \
   #git branch -m feature/$1 $1 && \
   #git push origin :feature/$1 && \
   #git push --set-upstream origin $1 && \
   #git checkout develop && \
   #git branch -d $1 };f'

## archives branch as a tag
#alias gitArchiveBranch='f() { \
   #git tag archive/$1 origin/$1 && \
   #git push --tags && \
   #git push origin --delete $1;
#};f'

#alias gitDeleteLocalBranches='git branch | xargs git branch -d'

## gitChangeTagName <old> <new>
#alias gitChangeTagName='f() { \
   #git tag $2 $1 && \
   #git tag -d $1 && \
   #git push origin :refs/tags/$1 && \
   #git push --tags 
#};f'

#alias quitjupyter='kill $(pgrep jupyter)'
#alias jupyter='quitjupyter; jt -t chesterish && jupyter notebook --NotebookApp.iopub_data_rate_limit=10000000 &> /dev/null &!'

#alias quittensorboard="kill $(ps aux | grep 'tensorboard.py' | awk '{print $2;}')"

#runTensorboard() {
   #quittensorboard ||
   #tensorboard --logdir $1 &> /dev/null &!
#}

#getSymbols() { 
   #readelf -s --wide $1 | awk '{print $NF }'
#}

# Recursively show dependencies of dynamic libs (in the same folder)
#wdep2() {
   #if [ -z "$1" ]; then
      #return
   #fi
   #if [ ! -f $1 ]; then
       #echo "File $1 not found!"
       #return
   #fi
   #echo "WDEP2 is looking for deps of $1"
   #toVisit=""
   #visited=""
   ##echo $1 >> toVisit
   #toVisit="${toVisit}$1"
   ## While there's more to visit
   #while [ ! -z "$toVisit" ]; do
      ## Get first line and remove it
      #line=$(echo $toVisit | head -n 1)
      ##echo "line is $line "
      #toVisit=`echo $toVisit | sed -n '1!p' `
      #if [ -z "$line" ]; then
         #continue
      #fi
      ##echo "visiting = $line"
      ## Put it in visited
      #echo $line >> visited
      #visited="${visited}\n$line"
      #if [ ! -f $line ]; then
         #echo "FILE $line is missing!!"
      #else
         #deps=`readelf -d $line | grep "NEEDED" | sed -r 's/.*\[//' | sed -r 's/\]//'`
         #while read -r line; do
           ## Check if any of the dependencies is not on the list already
           #if [[ $visited = *"$line"* ]]; then
             ##echo "It's there!"
           #else
              #if [[ $toVisit = *"$line"* ]]; then
                 ##echo "It's already there to visit"
              #else
                 ##echo "adding $line"
                 #toVisit="${toVisit}\n$line"
              #fi
           #fi
         #done <<< "$deps"
      #fi
   #done
   #echo "Libs that are PRESENT already"
   #echo $visited
   #echo "Finished!"
#}

pikaurListByNumberOfDependencies() {
   output=''
   packages=`pikaur -Q | awk '{print $1}'`
   while IFS= read -r package; do
       line="$package `pactree -l $package | wc -l`"
       output="$output\n$line"
   done <<< "$packages"
   echo $output | sort -k2 -n
}
