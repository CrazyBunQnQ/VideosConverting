#!/bin/bash
# ffmpeg -i input.mp4 output.avi
echo "当前正在使用 $SHELL 执行脚本..."
# 视频路径
path=$1
# 目标类型
targetType=$2
# targetType="mp4"
# 输出目录，为空则与原目录相同
output=$3
# 设置支持的格式（空格隔开）
suportType=(webm mp4 avi)
#该目录下的所有文件
files=$path/*
# 设置安装的 ffmpeg 路径
ffmpegPath=/usr/local/bin
# 计数
count=0

# 判断输出目录是否为空
if [ ${targetType} ]
then
    echo "目标类型为 mp4"
else
    echo "目标类型未指定，设置为默认值 mp4"
    targetType="mp4"
fi

# 判断输出目录是否为空
if [ ${output} ]
then
    echo "输出目录为 $output"
else
    echo "目标类型未指定，设置为默认值: $path/output"
    output=$path/output
fi

#如果文件夹不存在，创建文件夹
if [ ! -d "$output" ]
then
  mkdir $output
fi

echo "支持转化以下的视频格式..."
echo $suportType

echo ""
echo "任务开始"
echo "搜索 $path 目录下的所有文件..."
for file in $files
do
    if (test -f $file)
    then
        # 文件全名
        name=${file##*/}
        # 文件类型
        curType=${name##*.}
        # 文件名（不包含扩展名）
        name=${name%%.*}
        echo "文件类型为 $curType"
        for type in $suportType
        do
            # 判断是否是支持的类型，已经是目标类型的文件不转换
            echo "$type==$curType && $type!=$targetType"
            if [ "$type"=="$curType" ] && [ "$type"!="$targetType" ]
            then
                echo "正在转换视频："
                echo "$file >>>> $name.$targetType"
                # 执行视频转换命令
                echo "执行命令 $ffmpegPath/ffmpeg -i $file $output/$name.$targetType -threads 1"
                $ffmpegPath/ffmpeg -i $file $output/$name.$targetType -threads 1
                count=$((count+1))
                break
            fi
        done
    fi
done
echo "转换完成，共转换 $count 个视频文件"