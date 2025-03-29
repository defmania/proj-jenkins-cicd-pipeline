def secrets = [
    [path: 'cloud/secret/dev-creds/keys', engineVersion: 2, secretValues: [
        [envVar: 'TF_VAR_public_key', vaultKey: 'aws_public_key'],
        [envVar: 'PRIVATE_KEY', vaultKey: 'private_key']
    ]],
    [path: 'cloud/secret/dev-creds/rds', engineVersion: 2, secretValues: [
        [envVar: 'TF_VAR_db_username', vaultKey: 'db_username'],
        [envVar: 'TF_VAR_db_password', vaultKey: 'db_password']
    ]]
]

def vault_config = [vaultUrl: 'https://<VAULT_SERVER>:<PORT>', vaultCredentialId: 'vault-jenkins-app-role', engineVersion: 2]

pipeline {
    agent any

    parameters {
            booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
            booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
            booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to destroy Terraform config')
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clean workspace before cloning (optional)
                deleteDir()

                // Clone the Git repository
                git branch: 'main',
                    //credentialsId: 'repo-credentials', (required if using private repo)
                    url: 'git@github.com:defmania/terraform-devops-project-rw-app.git'

                sh "ls -lart"
            }
        }

        stage('Terraform Init') {
            steps {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-dev-02']]){
                        sh 'echo "Terraform Init"'
                        sh 'terraform init'
                    }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                        withVault([configuration: vault_config, vaultSecrets: secrets]) {
                          withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-dev-02']]){
                                sh 'echo "Terraform Plan"'
                                sh 'terraform plan'
                        }
                      }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                        withVault([configuration: vault_config, vaultSecrets: secrets]) {
                          withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-dev-02']]){
                                sh 'echo "Terraform Apply"'
                                sh 'terraform apply -auto-approve'
                        }
                      }
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                script {
                    if (params.DESTROY_TERRAFORM) {
                        withVault([configuration: vault_config, vaultSecrets: secrets]) {
                          withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-dev-02']]){
                                sh 'echo "Terraform Destroy"'
                                sh 'terraform destroy -auto-approve'
                          }
                        }
                    }
                }
            }
        }
      }
}

