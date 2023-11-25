#!/bin/bash

git clone -q https://github.com/mattia-battiston/clean-architecture-example example

## Export archstats to sqlite
archstats export sqlite example.db \
          -f example \
          -e git,java

rm -rf example

echo "Summary:"
sqlite3 example.db "SELECT name,value FROM summary" | column -t -s '|'

printf '\nViews:\n'
sqlite3 example.db "SELECT name FROM sqlite_master WHERE type='table'" | sort

printf '\n\nComponents:\n'
sqlite3 example.db "SELECT name, \"complexity:files\" as file_count FROM components" | column -t -s '|' | sort