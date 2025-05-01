# Docker_Yona

Yona ( https://github.com/yona-projects/yona ) 도커 실행을 위한 레포지토리

<br/><br/><br/><br/>

### 사용법

레포지토리 다운로드 후, 압축해제 한 폴더에서 실행

<br/>

##### 도커 이미지 실행 (기본적으로 9000 포트 사용)
```bash
docker-compose up -d
```

<br/>

##### 도커 컨테이너 ID 확인
```bash
docker ps -a
```
아래의 경우 컨테이너 ID는 `bf2f05bf07f2`

```bash
CONTAINER ID   IMAGE                 COMMAND                  CREATED        STATUS      PORTS                                                     NAMES
bf2f05bf07f2   somnwal/yona:1.16.0   "docker-entrypoint.s…"   5 months ago   Up 3 days   3306/tcp, 0.0.0.0:40020->9000/tcp, [::]:40020->9000/tcp   yona-yona-1
```

<br/>

##### 요나 실행
```bash
docker exec -it <컨테이너ID> /bin/bash
```

요나를 백그라운드로 실행
```bash
cd /yona/bin
./yona &
```

<br/><br/>

### 백업 방법 (첨부파일은 백업되지 않으므로 주의)

#### 백업 
```bash
docker exec -i <컨테이너ID> mysqldump yona -uyona -ppassword > '/NOT_DOCKER_PATH/EXAMPLE/<백업파일명>.sql'
```

<br/>

#### 복구
##### 디비 접속
```bash
docker exec -it <컨테이너ID> mysql -uyona -ppassword
```

<br/>

##### 디비 삭제
```sql
drop database yona;
create database yona
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_bin;
GRANT ALL ON yona.* to 'yona'@'localhost';
```

Docker 연결 종료
```bash
exit
```

<br/>

##### 복구 실행
```bash
docker exec -i <컨테이너ID> mysql yona -uyona -ppassword < '/NOT_DOCKER_PATH/EXAMPLE/<백업파일명>.sql'
```

