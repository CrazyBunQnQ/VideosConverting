#!/bin/zsh
# ffmpeg -i input.mp4 output.avi
zmodload zsh/regex

echo "当前正在使用 $SHELL 执行脚本..."
# 视频路径
path=$1
# path="/Users/baojunjie/Pictures/video"
# 目标类型
targetType=$2
# targetType="mp4"
output=$3
# 设置支持的格式（空格隔开）
suportType=(webm mp4 avi)
# 设置安装的 ffmpeg 路径
ffmpegPath=/usr/local/bin
# 日志文件
log=$path/log.log
# 计数
count=0

# 判断目标类型是否为空
if [[ ${targetType} ]] {
    echo "目标类型为 mp4"
} else {
    echo "目标类型未指定，设置为默认值 mp4"
    targetType="mp4"
}

# 判断输出目录是否为空
if [[ ${output} ]] {
    echo "输出目录为 $output"
} else {
    echo "output 为默认值"
    output=$path/output
}
echo "输出目录为 $output"

# 判断目录是否存在，不存在则创建目录
if [[ ! -d "$output" ]] {
    /bin/mkdir $output
}

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

echo "支持转化以下的视频格式..."
echo $suportType

echo ""
echo "任务开始"
echo "搜索 $path 目录下的所有文件..."
cd $path
for file (*.*) {
    echo "当前文件：$file"
    if (test -f $file)
         name=${file%%.*}
        if [[ $file -regex-match $reg ]] {
            echo "正在转换视频："
            echo "$file >>>> $name.$targetType"
            # 执行视频转换命令
            echo "$ffmpegPath/ffmpeg -i $file $output/$name.$targetType -threads 1"
            if {$ffmpegPath/ffmpeg -i $file $output/$name.$targetType -threads 1} {
                count=$((count+1))
            } else {
                echo "$file 转换失败" >> $log
            }
            echo ""
        } else {
            echo "格式不支持：$file"
        }
}
echo "转换完成，共转换 $count 个视频文件"