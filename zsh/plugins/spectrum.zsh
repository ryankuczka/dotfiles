# Make using 256 colors less painful

typeset -Ag FX FG BG

FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done

ZSH_SPECTRUM_TEXT="The quick brown fox jumped over the lazy dog."

# Show all 256 foreground colors
function spectrum_ls() {
    for code in {000..255}; do
        print -P -- "$code: %F{$code}$ZSH_SPECTRUM_TEXT%f"
    done
}

# Show all 256 background colors
function spectrum_bls() {
    for code in {000..255}; do
        print -P -- "$BG[$code]$code: $ZSH_SPECTRUM_TEXT %{$reset_color}"
    done
}
