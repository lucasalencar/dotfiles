#!/bin/bash

resolve_code_home () {
  local base_dir
  base_dir="${CODE_HOME:-$HOME/code}"
  # Expand ~ if present
  base_dir=$(eval echo "$base_dir")
  echo "$base_dir"
}
