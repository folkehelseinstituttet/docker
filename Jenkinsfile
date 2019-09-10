pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        //slackSend(channel: '#jenkins', message: 'Building.')
        sh '''ls
pwd
echo $CI_PWD

mkdir -p /tmp/hh1232132/dashboards_control/
cp -r * /tmp/hh1232132/dashboards_control/
rm -rf *
mv /tmp/hh1232132/dashboards_control .
mkdir junit
chmod 777 junit
ls -a
pwd

./dashboards_control/bin/docker_build.sh'''
      }
    }
  }
  environment {
    CI_PWD = '/var/lib/jenkins/workspace/dashboards/'
  }
}
