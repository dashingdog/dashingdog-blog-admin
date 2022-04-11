###
 # @Description:
 # @Date: 2022-04-11 15:31:12
###

if [ ! -f "./dist" ]; then
  echo "打包失败"
  exit 1
fi
sftp 
echo 'build success'


