#!/usr/bin/env bash

systemctl --user daemon-reload
systemctl --user enable watch-nvim.service
systemctl --user start watch-nvim.service
