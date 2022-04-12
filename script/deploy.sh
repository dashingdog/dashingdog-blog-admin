###
 # @Description:
 # @Date: 2022-04-11 15:31:12
###
ls $TRAVIS_BUILD_DIR/tests
rsync -r  -e "ssh  -o PubkeyAuthentication=yes   -o stricthostkeychecking=no" --delete-after --quiet $TRAVIS_BUILD_DIR/tests $DEPLOY_USER@$DEPLOY_HOST:~/tmp/$TRAVIS_BUILD_ID

ssh "$DEPLOY_USER"@"$DEPLOY_HOST" -o StrictHostKeyChecking=no 'rm -rf /tmp/old.build && mv web/dashingdog-blog-admin/tests /tmp/old.build && mv tmp/$TRAVIS_BUILD_ID web/dashingdog-blog-admin/dist'
echo 'deploy success'


