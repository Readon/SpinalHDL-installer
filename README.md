# [English Version](README_en.md)

This project is to make a installer to helping on setup a working msys2 environment for developping SpinalHDL design, in one step, offline.

# 基于 MSYS2 的 SpinalHDL 环境安装器

本项目旨在制作一个安装程序，以帮助一步到位地安装(离线)用于开发 SpinalHDL 设计的 msys2 工作环境。
本 repos 的 (release)[https://github.com/Readon/msys2-installer/releases] 目录中的安装程序包含不同版本的 SpinalHDL jar 文件，发布的安装文件版本号与其中包含的 SpinalHDL 库的版本号相同。

> 注意：安装的 sbt 运行时版本为 1.8.0。安装包已在环境变量 SBT_OPTS 中添加了一个选项来解决这个问题，它将覆盖在 project/build.properties 文件中指定的项目 sbt.version 版本。

![screenshot](screenshot.png)

## CLI 使用案例

通过 CLI 启动 GUI 安装程序将系统安装到 `C:\msys64`：

```powershell
.\msys2-x86_64-latest.exe in --confirm-command --accept-messages --root C:/msys64
```

通过 CLI 卸载已安装在 `C:\msys64` 中的系统：

```powershell
C:\msys64\uninstall.exe pr --confirm-command
```

## FAQ

### 如何将 MSYS2 环境与 Windows 环境分开？

两个环境相互干扰会导致环境变量的混乱。
通过 `msys2_shell.cmd -defterm -no-start -mingw64` 从任何你喜欢的终端启动 MINGW64 控制台都可以启动独立的 MSYS2 环境（与Windows环境隔离的）。

> 注意: 本安装包仅支持 MSYS2 中的 MINGW64 环境，MINGW32，UCRT 等均无法使用.

### 在本安装器中包含了哪些包？

它包含 [base](https://packages.msys2.org/package/base) 软件包、SpinalHDL 运行和调试所需的其他软件包及其所有依赖包。您可以使用以下方法列出所包含的软件包：`pactree base -lu | sort`.

### 为什么要通过 sdkman 安装 jdk？

Java 环境是通过 [sdkman](https://sdkman.io/) 安装的，这有助于提供一个独立于 Windows 主机的环境。这样就可以支持便携式安装。Java 和 sbt 全部由 sdkman 管理，位于独立的目录 `/sdkman` 下。另一方面，jar 缓存文件安装在 `/cache`，这样我们就可以离线使用安装程序。所需的环境变量均已配置完成。

### IDE（VSCode、IDEA等）集成

在未启动目标IDE的情况下，打开MSYS2自带的MINGW64控制台，在命令行中输入目标IDE的启动执行文件路径，即可启动目标IDE并使用该环境。

### 离线使用方法

本安装包仅包含编译、测试SpinalHDL工程所需的文件，不包含各种IDE及其插件所需文件。
由于不同人使用的开发环境、IDE版本各不相同，建议在在线机上安装该包，并启动编译、测试你的工程后，将安装目录复制到离线机使用。
> 若需使用镜像下载可参考 [Coursier官方文档](https://get-coursier.io/blog/#mirrors) 。

### 如果想使用旧版本的 SpinalHDL 怎么办？

创建issue，或者克隆此仓库然后自己修改。

### 为什么该发行版仍在使用 verilator 4.228 版？

这是迄今为止唯一稳定的版本，使用第 5 版（直到 5.016）会遇到很多问题。

### 如果 scala-xml 发生版本冲突，我该怎么办？

有一些情况下，编译 SpinalHDL 项目时可能会出现以下或其他更多报告。那么最好设置你的 SpinalHDL 工程使用 3.2.14 版的 scala test 和 2.12.18 版的 scala。

``` bash
(update) found version conflict(s) in library dependencies; some are suspected to be binary incompatible:
[error]
[error]         * org.scala-lang.modules:scala-xml_2.12:2.1.0 (early-semver) is selected over 1.0.6
[error]             +- org.scalatest:scalatest-core_2.12:3.2.14           (depends on 2.1.0)
[error]             +- org.scala-lang:scala-compiler:2.12.16              (depends on 1.0.6)
```

### fatal error: boost/interprocess/managed shared memory.hpp: No such file or directory

在本项目发布的 0.9.5 之前的某些版本中，使用 iverilog 仿真时会出错，并报告错误。可使用以下命令解决。

``` bash
pacman -S mingw-w64-x86_64-boost
```

## 已知问题

### Scala XML 冲突.

当使用的 SpinalHDL 版本低于1.9.3，且使用 Scala 2.12.13 编译器时，该环境无法正常工作，就像issue [#1229](https://github.com/SpinalHDL/SpinalHDL/issues/1229) 中指出的那样，程序将触发版本冲突。直到SpinalHDL 1.9.4 Scala编译器升级到了 2.12.18，它才会正常工作。

所以在这种情况下，请安装 Scala 2.12.18。在项目中明确使用 Scala 版本 2.12.18。
