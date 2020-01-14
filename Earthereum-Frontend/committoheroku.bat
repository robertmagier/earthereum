ECHO OFF
npm run build
git add .
git commit -a -m "Adding files."
git push heroku master
