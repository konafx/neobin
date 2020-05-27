set srcs ls grep rm find
set ls exa
set grep rg
set rm rip
set find fd

for i in (seq (count $$srcs))
    set src $srcs[$i]
    set dst $$srcs[$i]

    type -q $dst
    or echo 'Install '$dst' instead of '$src; continue

    echo $src' -> '$dst
    #alias $src=$dst
end
