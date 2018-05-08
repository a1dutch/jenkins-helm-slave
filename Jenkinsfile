@Library('pipeline@master') _

parameters {
  string(defaultValue: "a1dutch", description: '', name: 'REPOSITORY')
  string(defaultValue: "", description: '', name: 'VERSION')
}

pipeline {
  agent { label 'docker' }
  environment {
    ARTIFACT_VERSIONED="${REPOSITORY}/jenkins-helm-slave:${VERSION}"
    ARTIFACT_LATEST="${REPOSITORY}/jenkins-helm-slave:latest"
  }
  stages {
    stage('Validate') {
      steps {
        script {
            if (!VERSION) {
              throw new Exception("Version must be supplied, version: '${VERSION}'")
            }
        }
      }
    }
    stage('Build') {
      steps {
        sh "docker build -t ${ARTIFACT_VERSIONED} ."
        sh "docker tag ${ARTIFACT_VERSIONED} ${ARTIFACT_LATEST}"
        sh "docker push ${ARTIFACT_VERSIONED}"
        sh "docker push ${ARTIFACT_LATEST}"
      }
    }
  }
}
