# An Introduction to Makefile for Economists

This repository contains some examples of simple projects that uses Makefiles:

- [`beamer`](./beamer/):
  A [beamer presentation](./beamer/makefile-beamer.pdf) that introduces Makefiles to economists.
  The beamer itself also serves as an example of Makefiles.
- [`demo-homework`](./demo-homework/):
  This is a minimal example of a Makefile.
  The Makefile in this minimal project is heavily commented and uses deliberately simply syntax so it is easy to understand.
- [`demo-beamer-J-SEN-chapter-5`](./demo-beamer-J-SEN-chapter-5/):
  This is a real project I created for a presentation.
  This project contains the most complicated syntax with some advanced syntax and no comments.

## Makefile for Windows

There are two ways to use Makefile on Windows:

1. **Windows Subsystem for Linux (WSL)**:
   An officially supported method to integrate a Linux subsystem in Windows.
   It can be used to access the Windows file system, so it is much better than a virtual machine.
   You can find the official description [here on Microsoft's website](https://learn.microsoft.com/en-us/windows/wsl/install).
2. **Windows CMD**:
   People have ported the `make` program to Windows,
   so you can actually use `make` natively on Windows.
   Usually this is done by first install a package manager such as [chocolatey](https://chocolatey.org/)
   and then install `make` via the package manager.

   Note that if you choose to use `make` natively on Windows,
   then the commands in the Makefile should be in *DOS shell* syntax.

   - You can find an introduction to chocolatey [here](https://www.youtube.com/watch?v=mQI8OWeTpRo).
   - You can find an example of using `make` with a python project on Windows [here](https://www.youtube.com/watch?v=Yt-UF7fNLJE).

## Miscellaneous

- You can learn a bit more about `make`
  [here](https://missing.csail.mit.edu/2020/metaprogramming/) from [The Missing Semester](https://missing.csail.mit.edu/),
  a lecture series that teaches you how to use basic tools such as the *shell*, *git*, *vim*, *make* etc.
- [Here](https://makefiletutorial.com/) is a dedicated tutorial to `make`.
- [Documentation](https://www.gnu.org/software/make/manual/make.html) for `make`.
