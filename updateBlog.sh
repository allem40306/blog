#!/bin/bash
sed '82c \ \ message: update on '"`date +"%Y-%m-%d %H:%M"`" _config.yml
hexo generate -d
