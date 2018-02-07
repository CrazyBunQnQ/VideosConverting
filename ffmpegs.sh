# ffmpeg -i input.mp4 output.avi
echo "当前正在使用 $SHELL 执行脚本..."
# path=$1
path="/Users/baojunjie/Pictures/H/video/*"
targetType="mp4"
suportType="webm,mp4"
echo "搜索 $path 目录下的所有文件..."
for file in $path
do
    if (test -f $file)
    then
        echo $file 是文件
        fp="$file"
        echo $file[2,4]
    fi
done

echo "########## some tests ###########"
str=abcd12.webm
echo $str[2,3]
reg="^\d$"
[[ str -regex-match "^[abcd]{4}\d+\.webm$" ]] && echo match
# [[ "$str" =~ $reg ]] && echo a