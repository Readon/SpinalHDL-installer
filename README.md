# MSYS2 Installer

This project is to make a installer to helping on setup a working msys2 environment for developping SpinalHDL design, in one step, offline.
The installer in the (release)[https://github.com/Readon/msys2-installer/releases] directory of this repos contains separate versions of the SpinalHDL jar file, released with the same version number as the version of the SpinalHDL libraries contained therein.

> Note: the installed sbt runtime version is 1.8.0. I add an option to SBT_OPTS to fixs this, it would override your project's sbt.version which is normally specified in project/build.properties file.

![screenshot](screenshot.png)

## CLI Usage examples

Installing the GUI installer via the CLI to `C:\msys64`:

```powershell
.\msys2-x86_64-latest.exe in --confirm-command --accept-messages --root C:/msys64
```

Uninstalling an existing installation in `C:\msys64` via the CLI:

```powershell
C:\msys64\uninstall.exe pr --confirm-command
```

Installing the self extracting archive to `C:\msys64`:

```powershell
.\msys2-base-x86_64-latest.sfx.exe -y -oC:\
```

## FAQ

### How can I seperate the msys2 environment from Windows?

The interference could lead a mess up environment variable management. 
Start a console from any of your favourite terminal by `msys2_shell.cmd -defterm -no-start -mingw64` can start a standalone environment.

### What's the difference between the installer and the archives?

The installer provides some additional features such as installing shortcuts, registering an uninstaller, a GUI for selecting the installation path and automatically running a login shell at the end to initialize the MSYS2 environment.

If you unpack the archives and run a login shell once, you will get a functionally equivalent MSYS2 installation.

### What is contained in the installer/archives?

It contains the [base](https://packages.msys2.org/package/base) package with others required packages by SpinalHDL runing and debugging, and all their dependencies. You can list the contained packages using: `pactree base -lu | sort`

### Why install jdk through sdkman?

The java environment is install through [sdkman](https://sdkman.io/) which helps to provide a standalone environment seperate from host Windows. So that portable using is possible. Java and sbt are all managed by sdkman in it's own directory `/sdkman`. On other way, jar cache file is installed in `/cache` so that we can use the installer offline.

### What if I want to use an old version SpinalHDL?

create issue, or clone this repos and modify yourself.

### Why the distribution still use verilator version 4.228

This is the only stable version until now, use version 5 (until 5.016) would meet a bundle of problems.

### What can I do if version conflict happens on scala-xml

By chances, compiling your project would report below, or other more. Then scala test in version 3.2.14 and scala in version 2.12.18 are prefered.
``` bash
(update) found version conflict(s) in library dependencies; some are suspected to be binary incompatible:
[error]
[error]         * org.scala-lang.modules:scala-xml_2.12:2.1.0 (early-semver) is selected over 1.0.6
[error]             +- org.scalatest:scalatest-core_2.12:3.2.14           (depends on 2.1.0)
[error]             +- org.scala-lang:scala-compiler:2.12.16              (depends on 1.0.6)
```

## Known issues

### Scala XML conflict.
Version of SpinalHDL below 1.9.3 could not work with scala 2.12.13 as [#1229](https://github.com/SpinalHDL/SpinalHDL/issues/1229) states.
It will trigger version confilict. Until 1.9.4 the SpinalHDL upgrade scala compiler to 2.12.18, it will works.
So we installed scala 2.12.18 in this case.
Use scala version 2.12.18 in your project.
