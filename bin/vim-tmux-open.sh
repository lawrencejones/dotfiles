# Open one vim instance per project or dir. Additional files of that
# project/dir are opened in the same instance.
# Eg: [[ -n $TMUX ]] && alias vi="bash ~/.bin/vim-tmux-open.sh"

vim_ensure_is_open() {
	dir=$1
	tmux wait -L "vim-edit:$dir" # to be safe, synchroninze access to the vim pane
	[[ -z $vim_pane ]] && vim_pane=`tmux show -v "@vim-edit:$dir" 2> /dev/null`
	if [[ -z $vim_pane ]] || ! tmux display-message -pt $vim_pane &> /dev/null; then
		# vim is not running in any pane, so start a new instance 
		channel="`uuidgen`"
		tmux split-window -d -p 70 "vim \
			-c \"cd $dir\" \
			-c ':silent !tmux set -q \"@vim-edit:$dir\" \"\$TMUX_PANE\"'\
			-c ':silent !tmux wait -S \"$channel\"'"
		tmux wait $channel
		vim_pane=`tmux show -v "@vim-edit:$dir" 2> /dev/null`
	fi
	tmux wait -U "vim-edit:$dir"
}

while (( $# != 0 )); do
	file=${1:a}
	orig_dir=${file:h}
	dir=$orig_dir
	# search our working directory
	while [[ $dir != '/' ]] ; do
		vim_pane=`tmux show -v "@vim-edit:$dir" 2> /dev/null`
		# Is there a vim instance open in this directory?
		[[ -n $vim_pane ]] && break
		# Only work with svn 1.7 +
		[[ -d "$dir/.git" ||\
			-d "$dir/.svn" ||\
			-d "$dir/.hg"  ||\
			-d "$dir/.bzr" ]] && break
		# go up one level
		dir=${dir:h}
	done
	if [[ $dir == '/' ]]; then
		dir=$orig_dir
	fi
	file=${file#$dir/}
	# ensure vim is running for that project/dir
	vim_ensure_is_open $dir
	# open the file in the already running vim pane
	tmux send-keys -t $vim_pane 'Escape' ":e ${file:q}" 'Enter'
	shift
done

if [[ -z $file ]]; then
	vim_ensure_is_open $PWD
fi

window_uid="`tmux display-message -pt \"$vim_pane\" '#{window_id}'`"
tmux select-window -t $window_uid
tmux select-pane -t $vim_pane
