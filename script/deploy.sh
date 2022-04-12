###
 # @Description:
 # @Date: 2022-04-11 15:31:12
###
#rsync -av --delete-after   -e "ssh  -o PubkeyAuthentication=yes   -o stricthostkeychecking=no" $TRAVIS_BUILD_DIR/tests $DEPLOY_USER@$DEPLOY_HOST:tmp/
echo 'TRAVIS_BUILD_ID:' $TRAVIS_BUILD_ID
ls $TRAVIS_BUILD_DIR/dist
tar -zcf ${TRAVIS_BUILD_ID}.tar.gz ./dist
scp -o stricthostkeychecking=no -v ${TRAVIS_BUILD_ID}.tar.gz $DEPLOY_USER@$DEPLOY_HOST:tmp/${TRAVIS_BUILD_ID}/
echo 'scp upload success'
ssh "$DEPLOY_USER"@"$DEPLOY_HOST" -o StrictHostKeyChecking=no 'tar -zxvf tmp/${TRAVIS_BUILD_ID}/${TRAVIS_BUILD_ID}.tar.gz && rm-rf tmp/${TRAVIS_BUILD_ID}/${TRAVIS_BUILD_ID}.tar.gz  \
 rm -rf tmp/old.build && mv web/dashingdog-blog-admin/dist tmp/old.build \
 && rm -rf www/dist && cp -r tmp/$TRAVIS_BUILD_ID/dist www/dist'

echo 'deploy success'


