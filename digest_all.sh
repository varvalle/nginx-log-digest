#!/usr/bin/env bash
zcat access*gz | awk -f digest.awk > digest.log

