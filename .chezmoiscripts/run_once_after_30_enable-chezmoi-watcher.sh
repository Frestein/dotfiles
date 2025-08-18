#!/usr/bin/env bash

systemctl --user daemon-reload
systemctl --user enable --now chezmoi-watcher.service
