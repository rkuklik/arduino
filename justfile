set shell := ["bash", "-uc"]

# https://just.systems/

chooser := "sk --preview-window right:65% --preview 'just --show {} | (bat --language Makefile --color always --decorations never || cat)'"
name := `id -un`
outdir := "solution"
ino := outdir + "/solution.ino"
fqbn := "arduino:avr:uno"
dev := "/dev/ttyUSB0"

_default:
    @just --list

# Interactive recipe selector (if you have `skim` installed)
choose:
    @-just --choose --chooser "{{ chooser }}"

# Remove garbage
clean:
    -rm -rf '{{ outdir }}'

# Create output file from `FILE` in `solution` directory
gen FILE="template.cpp": clean
    mkdir -p '{{ outdir }}'
    cp 'src/{{ FILE }}' '{{ ino }}'
    cp 'src/funshield.h' '{{ outdir }}'

# Build `FILE` from `src`
build FILE="template.cpp": (gen FILE)
    arduino-cli compile \
        --output-dir '{{ outdir }}' \
        --fqbn '{{ fqbn }}' \
        '{{ outdir }}'

# Push built `elf` file to arduino
upload:
    sudo \
        -g dialout \
        -u {{ name }} \
        -E \
        arduino-cli upload \
            --input-file '{{ ino }}.elf' \
            --port '{{ dev }}' \
            --fqbn '{{ fqbn }}'

# Compile and upload `FILE` to arduino
flash FILE="template.cpp": (build FILE) upload
