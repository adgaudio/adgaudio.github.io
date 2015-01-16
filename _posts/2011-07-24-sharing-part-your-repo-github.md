---
layout: post
title: Sharing Part of Your Repo on GitHub
---

I haven't found a lot of discussion about how to share only a part of a git
repo with GitHub.  Here is a quick tutorial.

Let's say you have a private repository that contains development history and
files that you may need to keep private, such as proprietary code, firewall
configurations, passwords or private keys.  However, the repo also has a lot of
files that you'd like to share on GitHub.  This post explains how to create a
branch containing files and history solely meant for sharing on GitHub.  We
will also implement a git hook and review ssh options to make pushing to GitHub
easier and more secure.

**Update** In general, your git repos should either be entirely public or
entirely private.  If you find yourself wondering whether it's possible to
publicize some part of a private repo, you should probably first consider
how you can split the repo into two separate ones.  For instance, if you wish
to open source an application while keeping your personal application
configuration private, you should have two separate repositories with app
configuration isolated to the private repo and application code isolated to the
public repo.  **End of update**

Assume that we have a private repo where we do all our work.  The
repo contains public, private, and mixed directories. Something like:

{% highlight c %}

    git init private_repo
    
    cd private_repo
    mkdir private public mixed
    touch private/secret_pw private/proprietary private/personal 
    touch public/cool_project public/useful_code public/docs 
    touch mixed/a_private_file mixed/a_public_file
    
    git add private public mixed
    git commit -am "initial commit to master"
    git push origin master
{% endhighlight %}

Now we have a repo in our working environment and we can consider what code we
will want to display on GitHub.  Specifically, we want to share our 'public'
directory and a file in the 'mixed' directory on GitHub and hide the private
files.  In this step, we create an orphaned branch containing only the files we
want to share on GitHub.    
    
{% highlight c %}

    # Create a branch that will contain only our public files
    git checkout --orphan github 
    #     read docs (git help checkout) for the specifics about '--orphan'.  
    #     It resets your development history.
    
    # Choose either option 1 or 2 (whatever's easiest)
    # OPTION 1: Starting with an empty slate
    git rm -rf ./*  # only necessary the first time
    git checkout master public mixed/a_public_file
    # OPTION 2: Filtering out private files
    git rm -rf private mixed/a_private_file
    
    git status
    git commit -am "files for public viewing on github"
{% endhighlight %}

At this point, we have a master branch and a github branch that exist in the
private repo.  The github branch contains a subset of files found in the
master.  Next, we create a GitHub repository on the GitHub website (Dashboard
--> New Repository --> Fill out form), and then we register this repo as a
remote in our private repo.

{% highlight c %}

    # 1. Create a public repository on GitHub (go to their website)
    # 2. add a remote:
    git remote add public_repo git@github.com:adgaudio/myRepoOnGitHub.git
{% endhighlight %}

If, at this point, you don't want to create a git repo but would prefer to test
locally, you can try this instead:

{% highlight c%}

    # 1. Emulate creating a public repo on GitHub:
    cd ..
    git init --bare fake_public_repo
    # 2. add a remote:
    cd private
    git remote add public_repo ../fake_public_repo
{% endhighlight %}

Ordinariliy, to push our branch to GitHub, all we'd need to do is this:

{% highlight c %}

    # don't do this yet
    cd ../private
    git push public_repo github:master  # ie. push github to public_repo/master
{% endhighlight %}

And we're done!  However, being lazy (I mean efficient!) programmers, perhaps
we'd like to automate pushing the github branch to GitHub whenever we make a
commit.  The trick here is to use a hook that gets called after every commit.


{% highlight c %}

    cd ../private/.git/hooks
    emacs post-commit
    
    #Add this data to the file:
        #!/bin/bash
        LOG="/tmp/github.log"
        echo "`date`" >> $LOG

        #Push changes to GitHub
         #note - GitHub needs to know your public key
        (git push public_repo github:master 2>&1) >> $LOG 

    chmod +x ./post-commit
{% endhighlight %}

What this means is that whenever we make a commit to the github branch, its
contents automatically get pushed to GitHub!

If you've followed so far and you don't have ssh key configured with GitHub,
you may not be able to push your code to your new repo!  Let's go over how to
create an ssh key specifically for your GitHub account.

Here's what I'd suggest you do:

{% highlight c %}

    # 1: Create a key specifically for github:
    ssh-keygen -f ~/.ssh/id_rsa_github  # Be Careful not to overwrite an existing private key!

    # 2: Configure ssh access to github.com to always use your new key
    emacs ~/.ssh/config
    #Add this to the file
        Host github.com
        User git
        Port 22
        Hostname github.com
        IdentityFile ~/.ssh/id_rsa_github
        TCPKeepAlive yes
        IdentitiesOnly yes

    # 3: Navigate your browser to your GitHub profile settings page and
    register the # public key you just created (`id_rsa_github.pub`) as an
    authorized key.

    # 4: Add your existing key to your keyring
    # (you may need to do this after every reboot before using the key)
    ssh-add ~/.ssh/id_rsa_github
{% endhighlight %}

Finally, test your setup by pushing your code

{% highlight c %}

    cd ../private_repo
    git push origin github
{% endhighlight %}

