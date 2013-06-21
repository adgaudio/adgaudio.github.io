---
layout: post
title: Sharing Part of Your Repo on GitHub
---

I haven't found a lot of discussion about how to share only a part of a git repo with GitHub.  Here is a quick tutorial.

Let's say you have a repository that contains development history and files that you may need to keep private, such as proprietary code, firewall configurations, passwords or private keys.  However, the repo also has a lot of files that you'd like to share on GitHub.  This post explains how to create a branch containing files and history solely meant for sharing on GitHub.  We will also implement a git hook and review ssh options to make pushing to GitHub easier and more secure.

Assume that we have one bare repo and a clone of it on our local machine.  The repo contains public, private, and mixed directories. Something like...

{% highlight c %}
    git init --bare my_repo
    git clone repo my_clone
    
    cd my_clone
    mkdir private public mixed
    touch private/secret_pw private/proprietary private/personal 
    touch public/cool_project public/useful_code public/docs 
    touch mixed/a_private_file mixed/a_public_file

    git add private public mixed
    git commit -am "initial commit to master"
    git push origin master
{% endhighlight %}

Now we have a repo in our working environment and we can consider what code we will want to display on GitHub.  Specifically, we want to share our 'public' directory and a file in the 'mixed' directory on GitHub and hide the private files.  In this step, we create an orphaned branch containing only the files we want to share on GitHub.    
    
{% highlight c %}
    # Create a branch that will contain only our public files
    cd ../my_clone
    git checkout --orphan github 
    #     read docs (git help checkout) for the specifics about '--orphan'.  
    #     It resets your development history.
    
    # Choose either option 1 or 2 (whatever's easiest)
    # OPTION 1: Starting with an empty slate
    git rm -rf ./* 
    git checkout master public mixed/a_public_file
    # OPTION 2: Filtering out private files
    git rm -rf private mixed/a_private_file
    
    git status
    git commit -am "files for github"
    git push origin github
{% endhighlight %}

At this point, we have a master branch and a github branch that exist in both the origin (bare) repo and the cloned repo.  The github branch contains a subset of files found in the master.  Next, we create a GitHub repository on the GitHub website (Dashboard --> New Repository --> Fill out form).  Our bare repo needs to know about GitHub.

{% highlight c %}
    # First, we let our bare repo know about the GitHub repo
    cd ../my_repo
    git remote add to_github git@github.com:adgaudio/myRepoOnGitHub.git 
    #     Be sure to fill in data as given by GitHub website
{% endhighlight %}

Ordinariliy, to push our branch to GitHub, all we'd need to do is this:

{% highlight c %}
    # don't do this yet
    git push to_github github 
{% endhighlight %}

However, being lazy programmers, we'd like to automate pushing the github branch to GitHub.  The trick here is to use a hook that gets called after every push (or pull) to the bare repo.

{% highlight c %}
    cd ../my_repo/hooks
    emacs post-update
    
    #Add this data to the file:
        #!/bin/bash
        LOG="./github.log"
        echo "`date`" >> $LOG

        #Push changes to GitHub
         #note - GitHub needs to know your public key
        (git push to_github github 2>&1) >> $LOG 

    chmod +x ./post-update
{% endhighlight %}

What this means is that whenever we push to our bare repo, we will execute this script and subsequently push our github branch to git.  We are nearly done!  The only remaining step is to discuss keys.  If you haven't registered an ssh key with your GitHub account, now is the time to do so.  However, there is a caveat.  Because we automated pushing to GitHub via the above hook, we will need to make sure the local machine won't ask for a password when it wants to use the ssh key.  There are a couple of ways around this, and I'll explain them here.

There are at least 2 options: In option 1, you can create a new key with no password specifically for GitHub.  In option 2, add a key to your keyring manager.

{% highlight c %}
    OPTION 1: Create a key specifically for github:
    ssh-keygen  #Be Careful not to overwrite your existing private key.
    emacs ~/.ssh/config
    
    #Add this to the file
        Host github.com
        User git
        Port 22
        Hostname github.com
        IdentityFile ~/.ssh/id_rsa_github
        TCPKeepAlive yes
        IdentitiesOnly yesg
{% endhighlight %}

{% highlight c %}
    OPTION 2: Add your existing key to your keyring 
    #(will only ask for password the first time it's used after reboot, I believe)
    
        ssh-add ~/.ssh/id_rsa_github
{% endhighlight %}

Finally, test your setup by pushing your code 
    
{% highlight c %}
    cd ../my_clone
    git push origin github
{% endhighlight %}

