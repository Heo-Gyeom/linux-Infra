pipeline {
    agent any
    environment {
        REPO_URL = 'https://github.com/Heo-Gyeom/linux-Infra.git'
        DEPLOY_USER = 'root'
        SSH_KEY_ID = 'heogyeom'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github-token', url: env.REPO_URL
            }
        }
        stage('Permissions') {
            steps {
                sh 'chmod +x ./gradlew'
            }
        }
        stage('Build') {
            steps {
                sh './gradlew clean build -x test'  // 테스트 스킵으로 빠르게
                sh 'ls -la build/libs/'             // JAR 확인
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo "☕ Spring Boot가 구동될 때까지 20초간 대기합니다..."
                    sleep 20  // 초 단위

                    def servers = ['192.168.56.11', '192.168.56.12']
                    servers.each { server_ip ->
                        echo "🚀 Deploying to ${server_ip}..."
                        sshagent([env.SSH_KEY_ID]) {
                            sh """
                                # JAR 파일 복사
                                scp -o StrictHostKeyChecking=no build/libs/*.jar ${env.DEPLOY_USER}@${server_ip}:/opt/linux-infra/linux-infra.jar

                                # 서비스 재시작
                                ssh -o StrictHostKeyChecking=no ${env.DEPLOY_USER}@${server_ip} "
                                    cd /opt/linux-infra
                                    sudo systemctl daemon-reload
                                    sudo systemctl stop linux-infra || true
                                    sudo systemctl start linux-infra
                                    sudo systemctl status linux-infra
                                "
                            """
                        }
                        echo "✅ ${server_ip} 배포 완료"
                    }
                }
            }
        }



        stage('Health Check') {
            steps {
                script {
                    def servers = ['192.168.56.11', '192.168.56.12']
                    servers.each { server_ip ->
                        echo "🩺 Health check ${server_ip} (최대 60초 대기)..."

                        int retries = 12  // 5초 * 12 = 60초
                        int waitSec = 5
                        int status = 1

                        while (retries > 0 && status != 0) {
                            status = sh(
                                script: "curl -f -m 5 http://${server_ip}:8080/actuator/health >/dev/null 2>&1",
                                returnStatus: true
                            )
                            if (status == 0) {
                                echo "✅ ${server_ip} UP!"
                                break
                            }
                            echo "⏳ ${server_ip} 아직 준비 안 됨. ${waitSec}초 후 재시도... (남은 횟수: ${retries-1})"
                            sleep(waitSec)
                            retries--
                        }

                        if (status != 0) {
                            error "❌ ${server_ip} 헬스체크 실패"
                        }
                    }
                }
            }
        }
    }
    post {
        success { echo '🎉 Spring Boot 배포 성공!' }
        failure { echo '💥 배포 실패!' }
    }
}
`