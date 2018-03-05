## 注意事项

- 该脚本使用 [zsh](https://ohmyz.sh) 语法，与 `bash` 语法有区别，后续我会补上 `bash` 版本的脚本。
- 使用该脚本需要先安装 [ffmpeg](https:www.ffmpeg.org) 工具（推荐使用 [homebrew](https://brew.sh) 安装，简单省事~）

## 使用方式

终端中输入下面的命令即可执行

```bash
# zsh
zsh ffmpegs.zsh 目录 [类型] [输出目录]

# bash
sh ffmpegs.sh 目录 [类型] [输出目录]
```

>[]为可选参数

![效果演示](http://wx3.sinaimg.cn/large/a6e9cb00ly1fo7vx1d0dog20n30h94qp.gif)

## 注意事项

批量转换视频时 CPU 的使用率很高，尽量减少任务量。

目前已设置 `-threads 1` 参数进行单线程操作，但是看起来是每个核一个线程，在 `ffmpeg` 中并没有找到限制核心使用数量的参数，不知有没有知道怎么解决的！

>感觉不错的话帮我点个 Star 哟，谢谢~