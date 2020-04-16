function _git_branch_name
	echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _git_branch_name_short
	set result (string split "_" -- (_git_branch_name))[1]
	if test -d $result
		echo (_git_branch_name)
	else
		echo $result
	end
end

function fish_prompt
	function _is_git_dirty
		echo (git status -s --ignore-submodules=dirty ^/dev/null)
	end

	set -l last_status $status
	set -l cyan (set_color -o cyan)
	set -l yellow (set_color -o yellow)
	set -l red (set_color -o red)
	set -l blue (set_color -o blue)
	set -l green (set_color -o green)
	set -l normal (set_color normal)

	if test $last_status = 0
		set dollar "$green>"
	else
		set dollar "$red>"
	end

	set -l cwd $normal(prompt_pwd)

	if [ (_git_branch_name_short) ]
		set -l git_branch $red(_git_branch_name_short)
		set git_info "$blue$git_branch"

		if [ (_is_git_dirty) ]
			set -l dirty "$yellow ✗"
			set git_info "$git_info$dirty"
		end

		set git_final ' '$cyan'['$git_info $cyan']'
	end

	echo -n -s $cwd $git_final ' ' $dollar ' '
end
