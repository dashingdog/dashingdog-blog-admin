###
 # @Description:
 # @Date: 2022-04-11 15:31:12
###
#rsync -av --delete-after   -e "ssh  -o PubkeyAuthentication=yes   -o stricthostkeychecking=no" $TRAVIS_BUILD_DIR/tests $DEPLOY_USER@$DEPLOY_HOST:tmp/
echo 'TRAVIS_BUILD_ID:' $TRAVIS_BUILD_ID
ls $TRAVIS_BUILD_DIR/dist
tar -zcf dist.tar.gz ./dist
scp -o stricthostkeychecking=no -v dist.tar.gz $DEPLOY_USER@$DEPLOY_HOST:tmp
echo 'scp upload success'
ssh "$DEPLOY_USER"@"$DEPLOY_HOST" -o StrictHostKeyChecking=no ' tar -zxvf tmp/dist.tar.gz -C tmp \
  && rm -rf tmp/dist.tar.gz tmp/old.build && mv www/dist tmp/old.build && mv tmp/dist www/dist'

echo 'deploy success'


