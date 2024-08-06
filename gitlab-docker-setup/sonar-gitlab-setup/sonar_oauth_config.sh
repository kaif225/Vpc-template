#!/bin/bash

adminuser="admin"
adminpassword="kaif211"  # Current admin password
baseurl="sonarqube url"
enabled=true
gitlaburl=""
appid="application id of application created on gitlab"
secret=""
allowsignup=true

# Reset admin password (Optional, if you want to change it)
resetpassword()
{
	echo "Reset admin password"
	curl -u $adminuser:$adminpassword -X POST "$baseurl/api/users/change_password?login=$adminuser&previousPassword=$adminpassword&password=$newpassword"
}

# Configure GitLab OAuth client
configureoauth()
{
	echo "Configure OAuth client settings"
	curl -u $adminuser:$adminpassword -X POST "$baseurl/api/settings/set?key=sonar.core.serverBaseURL&value=$baseurl"
	curl -u $adminuser:$adminpassword -X POST "$baseurl/api/settings/set?key=sonar.auth.gitlab.enabled&value=$enabled"
	curl -u $adminuser:$adminpassword -X POST "$baseurl/api/settings/set?key=sonar.auth.gitlab.url&value=$gitlaburl"
	curl -u $adminuser:$adminpassword -X POST "$baseurl/api/settings/set?key=sonar.auth.gitlab.applicationId.secured&value=$appid"
	curl -u $adminuser:$adminpassword -X POST "$baseurl/api/settings/set?key=sonar.auth.gitlab.secret.secured&value=$secret"
	curl -u $adminuser:$adminpassword -X POST "$baseurl/api/settings/set?key=sonar.auth.gitlab.allowUsersToSignUp&value=$allowsignup"
}

### Execute the functions as needed
# resetpassword  # Uncomment if you want to change the password again
# redirect uri we give in the application created on gitalb is like http://192.168.7.211:9000/oauth2/callback/gitlab
configureoauth

