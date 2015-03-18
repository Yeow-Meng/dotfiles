
set history save


set history filename ~/.gdb_history


export HISTSIZE=1000000


define hook-quit
    set confirm off
end
