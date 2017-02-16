# Assembly-language assignments

This repository contains some examples of code written in assembly language on 16 and 32 bits. The solved problems found in this repository are pretty simple and cover the basics of assembly language. 
Also, the problems and programs can be used by beginners for learning or by others who want to add improvements to the code. 

## Getting Started - 16 bits

As I have said above, the programs are written in assembly language on 16 and 32 bits. The programs written on 16 bits uses *tasm* for assembling and *turbo debugger* for debugging. This can be found in all directories containing 
assembly files(extesion *.asm*). You can open them with almost any text editor (e.g. notepad, notepad++, sublime text etc), but in order to run it you need an emulator or a virtual machine which can run 16 bits programs. I used 
DOSBox for this purpose, but you can use any other software that you consider suitable for this task. You can download DOSBox at [this link](http://www.dosbox.com/download.php?main=1). After this you have to learn how to create a
virtual disk and mount it on a path from your computer. It is not so difficult and I will show you an example of instructions that you have to write in DOSBox. :)

### DOSBox: How to mount?

```
mount D D:\Assembly\myPath
D:
```

First command mounts the virtual __D__ drive to the path: _D:\Assembly\myPath_. You can replace them with the path where you saved the programs you want to run. The second command access the created virtual disk and now you can use
simple commands from command line to start the program or to move around(e.g. program.exe, cd path etc). Also, you can check the [DOSBox documentation](https://www.dosbox.com/wiki/) if you encounter any problem.

## Getting Started - 32 bits

For the 32 bits programs I used yasm, so the syntax of the program may be different from other assemblers. However, this shouldn't stop you using other assemblers as long as you do the proper modifications. However, if you want to use *yasm*
I added the programs you need in the _yasm-tools_ folder. There you will find a version of notepad++ (having the plugins for working with *yasm*) where you can run the 32 bits assembly programs. Also, I added **ollydbg** for debugging. More about it [here](http://www.ollydbg.de/).
I think that this part is pretty easy, so I won't insist on it.

## About the problems (IMPORTANT)

In every directory containing assembly files is a text file called **Problem.txt**. It contains all the information you need regarding the problems solved in that folder, so please read it. Otherwise, everything will seem confusing.


> Hope this guide is helpful!
