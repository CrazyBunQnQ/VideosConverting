#!/bin/zsh
# ffmpeg -i input.mp4 output.avi
zmodload zsh/regex
echo "当前正在使用 $SHELL 执行脚本..."
path=$1
# path="/Users/baojunjie/Pictures/H/video"
targetType=$2
# targetType="mp4"
# 设置支持的格式（空格隔开）
suportType=(webm mp4 avi)

echo "支持转化以下的视频格式..."
echo $suportType
# 设置安装的 ffmpeg 路径
ffmpegPath=/usr/local/bin
# 初始化正则表达式
reg="^(.*\.("
for type ($suportType) {
    if [[ $type != $targetType ]] {
        reg="$reg($type)|"
    } else {
        echo "已经是 $type 格式的视频不再转换"
    }
}
reg=$reg[1,-2]
reg=$reg"))$"
# echo "正则表达式：$reg"

echo ""
echo "任务开始"
echo "进入目录：$path"
cd $path
echo "搜索 $path 目录下的所有文件..."

for file (*.*) {
    echo "当前文件：$file"
    if (test -f $file)
        # echo $file 是文件
        # echo $file[2,4]
         name=${file%%.*}
        if [[ $file -regex-match $reg ]] {
            echo "正在转换视频："
            echo "$file >>>> $name.$targetType"
            if {$ffmpegPath/ffmpeg -i $file $name.$targetType} {
                echo "转换完成!"
             } else {
                echo "转换失败"
             }
            echo ""
        } else {
            echo "格式不支持：$file"
        }
}