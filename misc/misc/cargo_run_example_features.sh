#!/bin/sh

EXAMPLES=`cargo run --example 2>&1 | grep -P '   ' | awk '{print $1}'`

for ex in $EXAMPLES
do
    FEATURES=$(tomlq -r ".example[] | select(.name==\"${ex}\") | .[\"required-features\"] | join(\" \")" Cargo.toml)
    if [ -z "$FEATURES" ]
    then
        CMD_FEATURES=""
    else
        CMD_FEATURES="--features $FEATURES"
    fi

    cargo build $CMD_FEATURES --example $ex
done
