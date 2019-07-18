# Lab 8: Getting started with GitHub

## Setting up your GitHub account

If you don't already have a GitHub account, go to https://github.com/join?source=header-repo
to create a free one.

Optionally, go to https://education.github.com/pack to get free student benefits, including
the ability to have private repositories in your GitHub account.

## Creating your first repository

Click the plus sign in the upper-right corner of the website and select "New Repository".
Set up a repository with a README and a license.  Also select the option to add a 
.gitignore file for R.

In RStudio, go to "New Project" and then "Version Control".  Select Git and then put in
the URL for the repository you just created on GitHub.

Create a new R script within this project.  Copy and paste some of your code from a 
previous lab (or any other R code) into the scipt and save it.  Then in the Git menu
go to "Commit".  Check the "Staged" box next to your new file.  For the commit message,
put in "first commit", then press "Commit".

Now edit the README to include a brief description of what your R script or R function
does.  Save the README and make a commit as before, with a commit message something 
like "Added function description to README".

Once those two commits are made, in the Git menu (or in the Commit dialog) press "Push"
to send them back to GitHub.  You might get a prompt to log in with your GitHub user name
and password.  Once that is done, refresh your web browser on your GitHub page to see
the updates there.  You can also click on "commits" to see the history of changes you 
made.

## Collaborating on a repository

Now in Settings --> Collaborators on the website for your repository, add the user name
of your lab partner/someone in your lab group.  Have them do the same for you with
their repository.

In RStudio, do "New Project" --> "Version Control" and then put in the URL to your
partner's repository to clone a copy of it to your computer.  Make some edits in
RStudio, commit them, then push them back to GitHub.  Confirm that they went 
through by looking at them in the web browser.

Back in your own repository, press the "Pull" button in the Git menu in RStudio.
Look in your Git history in RStudio to see the changes that your partner made.

**Question 1 to turn in (2 points):** Turn in the URL to your repository on GitHub.

## Suggesting changes with a pull request

Get a repository URL for someone else in class, where you are NOT listed as a 
collaborator on that repository.  Press the "Fork" button to make a copy of that
repository within your own account.  Make a new project in RStudio to clone 
your copy of the repository to your computer.  Make some changes, commit them,
and push them.  Back on the GitHub site for your copied repository, click
"New Pull Request".  Fill out the information (including an explanation of what
changes you made and why), and then create a pull request.

**Question 2 to turn in (1 point):** Turn in the URL to the pull request that you made.

Here is a pull request you can look at as an example: https://github.com/lvclark/polyRAD/pull/1

If you have extra time, try merging (or closing if you don't like the changes)
pull requests that were made on your repository.