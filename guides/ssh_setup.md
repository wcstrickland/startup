# DONT USE SUDO WHEN CONNECTING WITH SSH: THE KEY IS ON THE PROFILE NOT ROOT!

[REVIEW SSH KEYS](https://docs.github.com/en/github/authenticating-to-github/reviewing-your-ssh-keys)


[GENERATE SSH KEYS](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh)
```
 ls -al ~/.ssh
```
- this will check for ssh keys
- looking for id_rsa.pub, id_ecdsa.pub, id_ed25519.pub and the like

``` 
ssh-keygen -t ed25519 -C "your_email@example.com"
``` 
- this will create a key and prompt you as to where to put it in your system
- it will also prompt a password you can leave it empty to opt out of password

```
eval "$(ssh-agent -s)"
``` 

``` 
ssh-agent fish
``` 
- this will start the ssh agent

``` 
ssh-add ~/.ssh/id_ed25519
``` 
- Add your SSH private key to the ssh-agent. If you created your key with a different name, or if you 
are adding an existing key that has a different name, replace id_ed25519 in the command with the name 
of your private key file.

[LINKING THE SSH KEY TO GITHUB](https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)

``` 
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
``` 
- this will copy the ssh key into the clipboard **but** it does require xclip as a dependency
- alternatively you could go into the file and manually copy it

``` 
ssh -T git@github.com
``` 
- this will attempt to connect and will establish a connection to github

## to change an existing repo to ssh that was cloned using http

``` 
git remote add origin git@gitub.com:wcstrickland/repo.git
``` 
