vim9script

export def Open(topic: string, date: number = localtime())
	echo "yay open " .. topic
	echo date
enddef
