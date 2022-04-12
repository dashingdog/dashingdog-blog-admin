###
 # @Description:
 # @Date: 2022-04-11 15:31:12
###
#rsync -av --delete-after   -e "ssh  -o PubkeyAuthentication=yes   -o stricthostkeychecking=no" $TRAVIS_BUILD_DIR/tests $DEPLOY_USER@$DEPLOY_HOST:tmp/
echo 'TRAVIS_BUILD_ID:' $TRAVIS_BUILD_ID
ls $TRAVIS_BUILD_DIR/dist
tar -zcvf ${TRAVIS_BUILD_ID}_tar.gz $TRAVIS_BUILD_ID
scp -o stricthostkeychecking=no -r $TRAVIS_BUILD_DIR/dist/ $DEPLOY_USER@$DEPLOY_HOST:tmp/$TRAVIS_BUILD_ID
echo 'scp upload success'
ssh "$DEPLOY_USER"@"$DEPLOY_HOST" -o StrictHostKeyChecking=no 'tar -zxvf ${TRAVIS_BUILD_ID}_tar.gz && rm-rf ${TRAVIS_BUILD_ID}_tar.gz  \
 rm -rf tmp/old.build && mv web/dashingdog-blog-admin/dist tmp/old.build \
 && cp -r tmp/$TRAVIS_BUILD_ID/ web/dashingdog-blog-admin/dist'

echo 'deploy success'


