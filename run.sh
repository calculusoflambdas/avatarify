#!/usr/bin/env bash

set -x

source scripts/settings.sh

CONFIG=fomm/config/vox-adv-256.yaml
CKPT=vox-adv-cpk.pth.tar

export PYTHONPATH=$PYTHONPATH:fomm

FF_CMD="ffmpeg -re -i pipe:0 -vf format=pix_fmts=yuv420p -f v4l2 /dev/video$CAMID_VIRT"

FOMM_CMD="python cam_fomm.py --config $CONFIG --checkpoint $CKPT --cam $CAMID --relative --adapt_scale"

if [ x$1 = "x--no-stream" ]; then
    $FOMM_CMD
else
    $FOMM_CMD --pipe | $FF_CMD
fi
