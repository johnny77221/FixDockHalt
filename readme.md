# FixDockHalt

The OSX dock happens to halt when doing drag & drop, attaching external display, or even executing a game (e.g. Starcraft)
this app listens Command+Shift+D to execute `killall -KILL Dock` to get the dock restart. Insteading of opening a finder, launch up a terminal, and hit commands in, I think this app is helpful for such situation and let it launch when system starts.

Hope this tool helps.