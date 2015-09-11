##### DEPLOY VARIABLES #######
HEROKU_APP='shooterapp'
ROOT_URL='http://'$HEROKU_APP'.heroku.com/'
MONGO_URL='mongodb://leoquip.com:123456@paulo.mongohq.com:10017/youtap

'
MONGO_OPLOG_URL='mongodb://leoquip.com:123456@paulo.mongohq.com:10017/youtap

'
MAIL_URL=''

##### PUT HASH IF YOU DON"T WANT SOME ENV VAR #######
runSript="
\n
cd ./programs/server \n
npm install \n
npm uninstall fibers \n
npm install fibers \n
cd ../../ \n
export MONGO_URL='"$MONGO_URL"' \n
export ROOT_URL='"$ROOT_URL"' \n
#export MONGO_OPLOG_URL='"$MONGO_OPLOG_URL"' \n
export MAIL_URL='"$MAIL_URL"' \n
node main.js \n
"

##### DON't LOOK HERE IT'S ALL MY DOING #######
rm -rf ./.meteor/local/heroku
meteor build ./.meteor/local/heroku --server $ROOT_URL
dirName=${PWD##*/}

cd ./.meteor/local/heroku/
tar -xvzf $dirName.tar.gz
cd bundle



echo -e $runSript > ./run.sh

packageText='{
  "name": "'$HEROKU_APP'",
  "version": "0.0.0",
  "private": true,
  "scripts": {
    "start": "sh ./run.sh"
  },
  "dependencies": {
  }
}'

echo $packageText > ./package.json

appText='{
  "name": "Trinisoft Technologies Pvt. Ltd.",
  "description": "Trinisoft Technologies Pvt. Ltd. Official app.",
  "repository": "https://git.heroku.com/"'$HEROKU_APP',
  "keywords": ["node", "express", "trinisoft"],
  "image": "heroku/nodejs"
}'

echo $appText > ./app.json

git init
git remote add heroku https://git.heroku.com/$HEROKU_APP.git
git add -A
git commit -m "init"
git push heroku master --force

echo "Hurray check your app "$ROOT_URL" here"