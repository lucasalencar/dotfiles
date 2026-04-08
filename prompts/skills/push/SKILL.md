---
name: push
description: Commit (if necessary) and push changes to origin branch
---

## Steps

1. Check logs to see if push is necessary and exit instantly if already
   up-to-date.
2. Check if current branch is main or master and ask if the user wants to create
   a branch before commiting. Suggest a branch name.
3. Check for changes in the current branch and commit them
4. Push changes to origin branch

## Guidelines

- Avoid commiting and pushing every unstaged file. Use the chat context to decide
    which changes the user wants to commit.

## Output instructions

- Check previous commits to decide which language to use on commit
    messages and branch names. Default is English.
