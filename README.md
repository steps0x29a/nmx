# nmx
NMX (node_modules extinguisher) is a very basic tool that allows you to easily clean up a whole directory structure containing folders named `node_modules`.

# What it does
You provide NMX with a path to any folder you want via the command line. It will then look through that path recursively, finding all folders named `node_modules` and erase them. 

# Why?
Because backing up a directory with a lot of node projects takes forever, as `node_modules` contains an immense amount of small files. NMX can help you save a lot of time by simply wiping those directories from your source folder. Of course you won't lose anything, as a simple `npm i` will re-install all the modules you've included through `package.json`.

I wrote this simple program because I wanted to learn some nim. 

# Warning
NMX is a very basic program that has NOT been thoroughly tested! It might delete stuff you did not want to delete. It won't ask whether or not you're sure. It will simply run and delete whatever stands in its way - so to speak. Use at your own risk.


