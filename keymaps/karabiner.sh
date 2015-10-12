#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set remap.controlL2controlL_escape 1
/bin/echo -n .
$cli set parameter.keyoverlaidmodifier_timeout 500
/bin/echo -n .
$cli set remap.uk_section2hash 1
/bin/echo -n .
/bin/echo
