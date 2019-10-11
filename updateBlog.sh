#!/bin/bash
hexo generate
sed -i '82c \ \ message: update on '"`date +"%Y-%m-%d %H:%M"`" _config.yml
hexo deploy
