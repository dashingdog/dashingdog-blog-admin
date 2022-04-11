npm install
###
 # @Description:
 # @Date: 2022-04-11 15:31:12
###
cd ./web/dashingdog-blog-admin

git  reset --hard origin $TRAVIS_BRANCH

git pull origin $TRAVIS_BRANCH

echo 'update coude success, start install'

npm install

npm run build

echo 'success'


