#!/bin/bash
chmod +x shape-inference.sh
cp shape-inference.sh /tmp
cp change.py parsing_performance.py util.h ../../test_cases
cp change.py parsing_performance.py util.h ../../realworld_stencil
cp run.py ../../test_cases
cp run_real.py ../../realworld_stencil