pipeline {
  agent {
    node {
      label 'jenkins-jnlp-java'
    }

  }
  stages {
    stage('Prepare') {
      steps {
        echo '1. Prepare Stage'
        checkout scm
        script {
          build_tag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
          build_tag = "${env.BRANCH_NAME}-${build_tag}"
          app_name = sh(returnStdout: true, script: "git config -l|grep remote.origin.url|awk -F/ '{print \$NF}'|awk -F. '{print \$1}'").trim()
        }

      }
    }
    stage('Test') {
      steps {
        echo '2. Test Stage'
      }
    }
    stage('Build') {
      steps {
        echo '3. Build jar'
        script {
          if(env.BRANCH_NAME == 'master') {
            harbor_addr = "${harbor_prod}"
            apollo_env = 'pro'
          } else if(env.BRANCH_NAME == 'test') {
            harbor_addr = "${harbor_prod}"
            apollo_env = 'dev'
          } else if(env.BRANCH_NAME == 'dev') {
            harbor_addr = "${harbor_prod}"
            apollo_env = 'dev'
          } else {
            echo 'Unknow BRANCH_NAME !'}
            image_name = "${harbor_addr}/${env.BRANCH_NAME}/${app_name}:${build_tag}"
            withCredentials([usernamePassword(credentialsId: 'db_prod', passwordVariable: 'dbpasswd', usernameVariable: 'dbuser')]) {
              sh """
              sed -i "s/<dbuser>/${dbuser}/g" antx.properties \
              && sed -i "s/<dbpasswd>/${dbpasswd}/g" antx.properties \
              && mvn package
              """
            }
          }

        }
      }
      stage('Push') {
        steps {
          echo '4. Push Docker Image Stage'
          withCredentials(bindings: [usernamePassword(credentialsId: 'harbor', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
            sh """
                                                                        cp -a /opt/k8s/* ./ \
                                                                        &&  cp b2b-web/target/b2b.war ./${app_name}.war \
                                                                        && sed -i "s/<APP_NAME>/${app_name}/g" Dockerfile \
                                                                        && docker login ${harbor_addr} -u ${dockerHubUser} -p ${dockerHubPassword} \
                                                                        && docker build -t ${image_name} . \
                                                                        && docker push ${image_name}
                                                                        """
          }

        }
      }
      stage('Deploy') {
        steps {
          echo '6. Deploy Stage'
          script {
            if (env.BRANCH_NAME == 'master') {
              input "确认要部署线上环境吗？"
            }
          }

          sh """
                                                             if kubectl get deploy ${app_name} -n ${env.BRANCH_NAME}; then
                                                               kubectl set image deploy ${app_name} ${app_name}=${image_name} -n ${env.BRANCH_NAME} --record
                                                             else
                                                               sed -i "s/<APP_NAME>/${app_name}/g" deploy.yaml \
                                                               && sed -i "s/<HARBOR_ADDR>/${harbor_addr}/g" deploy.yaml \
                                                               && sed -i "s/<NS_NAME>/${env.BRANCH_NAME}/g" deploy.yaml \
                                                               && sed -i "s/<BUILD_TAG>/${build_tag}/g" deploy.yaml \
                                                               && sed -i "s/<HARBOR_SECRET>/${harbor_secret}/g" deploy.yaml \
                                                               && sed -i "s/<RS>/${rs_num}/g" deploy.yaml \
                                                               && sed -i "s/<CPU>/${cpu}/g" deploy.yaml \
                                                               && sed -i "s/<MEM>/${memory}/g" deploy.yaml \
                                                               && kubectl apply -f deploy.yaml --record
                                                               if [ ${svc_tag} -eq 1 ]; then
                                                                 sed -i "s/<APP_NAME>/${app_name}/g" svc.yaml \
                                                                 && sed -i "s/<NS_NAME>/${env.BRANCH_NAME}/g" svc.yaml \
                                                                 && kubectl apply -f svc.yaml
                                                               fi
                                                             fi
                                                          """
        }
      }
    }
    environment {
      harbor_prod = 'harbor.hicustom.com'
      harbor_test = 'harbor.hicustom.com'
      harbor_dev = 'harbor.hicustom.com'
      harbor_secret = 'myregistrykey'
      svc_tag = 1
      rs_num = 1
      cpu = '200m'
      memory = '1Gi'
    }
  }