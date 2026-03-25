#!/bin/bash

if pgrep -x openfortivpn >/dev/null; then
  pkexec pkill -x openfortivpn
else
  pkexec openfortivpn
fi
