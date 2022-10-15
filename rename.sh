#!/bin/bash

DIRECTORY_PATH=$1
NEW_NAME_PREFIX=$2

for file_path in "$DIRECTORY_PATH"/*
do
  file_name=$(basename "$file_path");
  file_dir=$(dirname "$file_path");
  new_path="${file_dir}/${NEW_NAME_PREFIX}${file_name}" 
  echo "$file_path to $new_path"
  mv $file_path $new_path
done