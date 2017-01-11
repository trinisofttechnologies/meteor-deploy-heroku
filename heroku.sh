##### DEPLOY VARIABLES #######
HEROKU_APP='shooterapp'
ROOT_URL='https://'$HEROKU_APP'.herokuapp.com/'
MONGO_URL='mongodb://leoquip.com:123456@paulo.mongohq.com:10017/youtap'
MONGO_OPLOG_URL='mongodb://leoquip.com:123456@paulo.mongohq.com:10017/youtap'
MAIL_URL=''
METEOR_SETTINGS=$(cat ./settings.json)
nodeVersion="0.10.36" ## not all node version works with some meteor version

##### DELETE A LINE IF YOU DON"T WANT SOME ENV VAR #######
runSript="cd ./programs/server &&
npm install &&
cd ../../ &&
export MONGO_URL='"$MONGO_URL"' &&
export ROOT_URL='"$ROOT_URL"' &&
export MAIL_URL='"$MAIL_URL"' &&
export METEOR_SETTINGS='"$METEOR_SETTINGS"' &&
node ./main.js"

##### DON'T LOOK HERE IT'S ALL MY DOING #######
rm -rf ./.meteor/local/heroku
meteor build ./.meteor/local/heroku --server $ROOT_URL
dirName=${PWD##*/}

cd ./.meteor/local/heroku/
tar -xvzf $dirName.tar.gz
cd bundle



echo $runSript > ./run.sh

packageText='{
  "name": "'$HEROKU_APP'",
  "version": "0.0.0",
  "private": true,
  "scripts": {
    "start": "sh ./run.sh"
  },
  "dependencies": {
  },
  "engines": {
    "node": "'$nodeVersion'"
  }
}'

echo $packageText > ./package.json

appText='{
  "name": "Trinisoft Technologies Pvt. Ltd.",
  "description": "Trinisoft Technologies Pvt. Ltd. Official app.",
  "repository": "https://git.heroku.com/$HEROKU_APP.git",
  "keywords": ["node", "express", "trinisoft"],
  "image": "heroku/nodejs"
}'

echo $appText > ./app.json

git init
git remote add heroku https://git.heroku.com/$HEROKU_APP.git
git add -A
git commit -m "init"
git push heroku master --force

echo "Deploy complete"
echo "Sleeping for 5s and checking log"
sleep 5s
heroku logs

echo "Hurray check your app "$ROOT_URL" here"
