#!/bin/bash

#Please note that TARGET folder should not contain trailing forward slash

rsync -a --progress --delete /source/folder1/ /target/folder1
rsync -a --progress --delete /source/folder2/ /target/folder2
