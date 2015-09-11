# meteor-deploy-heroku
Deploy your meteor app on heroku without addons or plugins

# Summary

Hi, If you are looking to deploy your meteor app on heroku, and you are facing dificulty with the addons, here's a script that will help you deploy your meteor app on heroku wihtout any effort.

# Prerequisite

1. You need to have meteor, git and heroku installed
2. You should be logged in with heroku (heroku login)
3. Make sure you have heroku app, and you know the app name
4. Make sure you are able to push to heroku repo (git push https://git.heroku.com/appName.git)
5. Assuming that you have already added your heroku key (heroku keys:add)

# Getting started

```
cd /path/to/your/meteor-app
wget https://raw.githubusercontent.com/trinisofttechnologies/meteor-deploy-heroku/master/heroku.sh
sh ./heroku.sh
## make sure you modify the variables in the script
```

# Troubleshooting
Please report any issues on github issues or email us directly trinisofttechnologies@gmail.com

# Acknowledgements
If you like our work, please click the start.