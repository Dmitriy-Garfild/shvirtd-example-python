# Домашнее задание к занятию 5. «Практическое применение Docker»

### Инструкция к выполнению

1. Для выполнения заданий обязательно ознакомьтесь с [инструкцией](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD) по экономии облачных ресурсов. Это нужно, чтобы не расходовать средства, полученные в результате использования промокода.
3. **Своё решение к задачам оформите в вашем GitHub репозитории.**
4. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.
5. Сопроводите ответ необходимыми скриншотами.

---
## Примечание: Ознакомьтесь со схемой виртуального стенда [по ссылке](https://github.com/netology-code/shvirtd-example-python/blob/main/schema.pdf)

---

## Задача 0
1. Убедитесь что у вас НЕ(!) установлен ```docker-compose```, для этого получите следующую ошибку от команды ```docker-compose --version```
```
Command 'docker-compose' not found, but can be installed with:

sudo snap install docker          # version 24.0.5, or
sudo apt  install docker-compose  # version 1.25.0-1

See 'snap info docker' for additional versions.
```
В случае наличия установленного в системе ```docker-compose``` - удалите его.  




2. Убедитесь что у вас УСТАНОВЛЕН ```docker compose```(без тире) версии не менее v2.24.X, для это выполните команду ```docker compose version```  
###  **Своё решение к задачам оформите в вашем GitHub репозитории!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!**

---
## Решение 0
# задачи 1,2

+ Доработка ДЗ
+ работа переделана на ubuntu 

+ dim@srv-000:~/my-project/shvirtd-example-python$ docker-compose --version
+ Docker Compose version v2.20.3
+ dim@srv-000:~/my-project/shvirtd-example-python$ 



## Задача 1
1. Сделайте в своем github пространстве fork [репозитория](https://github.com/netology-code/shvirtd-example-python/blob/main/README.md).
   Примечание: В связи с доработкой кода python приложения. Если вы уверены что задание выполнено вами верно, а код python приложения работает с ошибкой то используйте вместо main.py файл old_main.py(просто измените CMD)
3. Создайте файл с именем ```Dockerfile.python``` для сборки данного проекта(для 3 задания изучите https://docs.docker.com/compose/compose-file/build/ ). Используйте базовый образ ```python:3.9-slim```. 
Обязательно используйте конструкцию ```COPY . .``` в Dockerfile. Не забудьте исключить ненужные в имадже файлы с помощью dockerignore. Протестируйте корректность сборки.  
4. (Необязательная часть, *) Изучите инструкцию в проекте и запустите web-приложение без использования docker в venv. (Mysql БД можно запустить в docker run).
5. (Необязательная часть, *) По образцу предоставленного python кода внесите в него исправление для управления названием используемой таблицы через ENV переменную.
---
### ВНИМАНИЕ!
!!! В процессе последующего выполнения ДЗ НЕ изменяйте содержимое файлов в fork-репозитории! Ваша задача ДОБАВИТЬ 5 файлов: ```Dockerfile.python```, ```compose.yaml```, ```.gitignore```, ```.dockerignore```,```bash-скрипт```. Если вам понадобилось внести иные изменения в проект - вы что-то делаете неверно!
---
## Решение 1


+ Доработка ДЗ
+ работа переделана на ubuntu , создан файл
+ [compose.yaml](https://github.com/Dmitriy-Garfild/shvirtd-example-python/blob/main/compose.yaml)
+ инструкции "x-deploy" начали работать




## Задача 2 (*)
1. Создайте в yandex cloud container registry с именем "test" с помощью "yc tool" . [Инструкция](https://cloud.yandex.ru/ru/docs/container-registry/quickstart/?from=int-console-help)
2. Настройте аутентификацию вашего локального docker в yandex container registry.
3. Соберите и залейте в него образ с python приложением из задания №1.
4. Просканируйте образ на уязвимости.
5. В качестве ответа приложите отчет сканирования.

## Задача 3
1. Изучите файл "proxy.yaml"
2. Создайте в репозитории с проектом файл ```compose.yaml```. С помощью директивы "include" подключите к нему файл "proxy.yaml".
3. Опишите в файле ```compose.yaml``` следующие сервисы: 

- ```web```. Образ приложения должен ИЛИ собираться при запуске compose из файла ```Dockerfile.python``` ИЛИ скачиваться из yandex cloud container registry(из задание №2 со *). Контейнер должен работать в bridge-сети с названием ```backend``` и иметь фиксированный ipv4-адрес ```172.20.0.5```. Сервис должен всегда перезапускаться в случае ошибок.
Передайте необходимые ENV-переменные для подключения к Mysql базе данных по сетевому имени сервиса ```web``` 

- ```db```. image=mysql:8. Контейнер должен работать в bridge-сети с названием ```backend``` и иметь фиксированный ipv4-адрес ```172.20.0.10```. Явно перезапуск сервиса в случае ошибок. Передайте необходимые ENV-переменные для создания: пароля root пользователя, создания базы данных, пользователя и пароля для web-приложения.Обязательно используйте уже существующий .env file для назначения секретных ENV-переменных!

2. Запустите проект локально с помощью docker compose , добейтесь его стабильной работы: команда ```curl -L http://127.0.0.1:8090``` должна возвращать в качестве ответа время и локальный IP-адрес. Если сервисы не стартуют воспользуйтесь командами: ```docker ps -a ``` и ```docker logs <container_name>``` . Если вместо IP-адреса вы получаете ```NULL``` --убедитесь, что вы шлете запрос на порт ```8090```, а не 5000.

5. Подключитесь к БД mysql с помощью команды ```docker exec -ti <имя_контейнера> mysql -uroot -p<пароль root-пользователя>```(обратите внимание что между ключем -u и логином root нет пробела. это важно!!! тоже самое с паролем) . Введите последовательно команды (не забываем в конце символ ; ): ```show databases; use <имя вашей базы данных(по-умолчанию example)>; show tables; SELECT * from requests LIMIT 10;```.

6. Остановите проект. В качестве ответа приложите скриншот sql-запроса.


## Решение 3
+ [compose.yaml](https://github.com/Dmitriy-Garfild/shvirtd-example-python/blob/main/compose.yaml)


+ dim@srv-000:~/my-project/shvirtd-example-python$ docker ps 
+ CONTAINER ID   IMAGE                        COMMAND                  CREATED             STATUS             PORTS                      NAMES
+ 31fade5a143c   shvirtd-example-python-web   "python main.py"         53 minutes ago      Up 53 minutes                                 shvirtd-example-python-web-1
+ 9105080598d8   mysql:8                      "docker-entrypoint.s…"   53 minutes ago      Up 53 minutes      3306/tcp, 33060/tcp        shvirtd-example-python-db-1
+ 4e87436ba7b8   nginx:1.21.1                 "/docker-entrypoint.…"   About an hour ago   Up About an hour                              shvirtd-example-python-ingress-proxy-1
+ 4925a11767e6   haproxy:2.4                  "docker-entrypoint.s…"   About an hour ago   Up About an hour   127.0.0.1:8080->8080/tcp   shvirtd-example-python-reverse-proxy-1

+ база показывается уже на вирт машине в моей виртуальной среде, я пробовал зайти туда с других вирт машин подключенные через связанные и проксируемые интерфейсы

| virtd              |
+--------------------+
5 rows in set (0.00 sec)

Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
+-----------------+
| Tables_in_virtd |
+-----------------+
| requests        |
+-----------------+
1 row in set (0.00 sec)

+----+---------------------+--------------+
| id | request_date        | request_ip   |
+----+---------------------+--------------+
|  1 | 2024-12-02 08:29:39 | 10.0.2.2     |
|  2 | 2024-12-02 08:30:02 | 10.0.2.2     |
|  3 | 2024-12-02 09:06:38 | 192.168.1.14 |
|  4 | 2024-12-02 09:06:44 | 192.168.1.14 |
+----+---------------------+--------------+
4 rows in set (0.00 sec)

mysql> 


скриншот:

[ "db2.PNG"](https://github.com/Dmitriy-Garfild/shvirtd-example-python/blob/main/solution/db2.PNG)




















### Для тестирования моей сборки необходимо склонировать [этот репозиторий](https://github.com/Dmitriy-Garfild/shvirtd-example-python.git) и запускать сборку из корневоцй директории  (в папке solution только те файлы которые необходимы для объяснения моих действий при решении)

## Задача 4
1. Запустите в Yandex Cloud ВМ (вам хватит 2 Гб Ram).
2. Подключитесь к Вм по ssh и установите docker.
3. Напишите bash-скрипт, который скачает ваш fork-репозиторий в каталог /opt и запустит проект целиком.
4. Зайдите на сайт проверки http подключений, например(или аналогичный): ```https://check-host.net/check-http``` и запустите проверку вашего сервиса ```http://<внешний_IP-адрес_вашей_ВМ>:8090```. Таким образом трафик будет направлен в ingress-proxy. ПРИМЕЧАНИЕ:  приложение(old_main.py) весьма вероятно упадет под нагрузкой, но успеет обработать часть запросов - этого достаточно. Обновленная версия (main.py) не прошла достаточного тестирования временем, но должна справиться с нагрузкой.
5. (Необязательная часть) Дополнительно настройте remote ssh context к вашему серверу. Отобразите список контекстов и результат удаленного выполнения ```docker ps -a```
6. В качестве ответа повторите  sql-запрос и приложите скриншот с данного сервера, bash-скрипт и ссылку на fork-репозиторий.

## Решение 4
файл [setup.sh](https://github.com/Dmitriy-Garfild/shvirtd-example-python/blob/main/setup.sh) для скачки и запуска


## Задача 5 (*)
1. Напишите и задеплойте на вашу облачную ВМ bash скрипт, который произведет резервное копирование БД mysql в директорию "/opt/backup" с помощью запуска в сети "backend" контейнера из образа ```schnitzler/mysqldump``` при помощи ```docker run ...``` команды. Подсказка: "документация образа."
2. Протестируйте ручной запуск
3. Настройте выполнение скрипта раз в 1 минуту через cron, crontab или systemctl timer. Придумайте способ не светить логин/пароль в git!!
4. Предоставьте скрипт, cron-task и скриншот с несколькими резервными копиями в "/opt/backup"

## Задача 6
Скачайте docker образ ```hashicorp/terraform:latest``` и скопируйте бинарный файл ```/bin/terraform``` на свою локальную машину, используя dive и docker save.
Предоставьте скриншоты  действий .

## Решение 6
скачиваем
docker pull hashicorp/terraform:latest

ставим dive
sudo snap install dive
sudo snap connect dive:docker-executables docker:docker-executables
sudo snap connect dive:docker-daemon docker:docker-daemon

анализируем образ
dive hashicorp/terraform:latest


5b88db4c71cd9e5847e1cac4abca9ca93f4b98b62a6f9d8b9e1721648c396024 


[teraform1](https://github.com/Dmitriy-Garfild/shvirtd-example-python/blob/main/solution/teraform1.PNG)


загоняем в архив
docker save hashicorp/terraform:latest -o terraform_image.tar

а дальше разархивируем 

[teraform2](https://github.com/Dmitriy-Garfild/shvirtd-example-python/blob/main/solution/teraform2.PNG)

выковыриваем из архива

dim@srv-000:~/my-project/shvirtd-example-python/blobs/sha256/bin$ ll
total 88128
drwxr-xr-x 2 root root     4096 Nov 27 07:39 ./
drwxr-xr-x 3 root root     4096 Dec  2 12:13 ../
-rwxr-xr-x 1 root root 90230936 Nov 26 21:47 terraform*
dim@srv-000:~/my-project/shvirtd-example-python/blobs/sha256/bin$ 

## Задача 6.1
Добейтесь аналогичного результата, используя docker cp.  
Предоставьте скриншоты  действий .

## Решение 6.1
скачиваем
docker pull hashicorp/terraform:latest
создаем свой контейнер
container_id=$(docker create hashicorp/terraform:latest) - тут есть варианты но нужно знать id или имя контейнера
копирование бинарного файла
docker cp $container_id:/bin/terraform ./terraform



## Задача 6.2 (**)
Предложите способ извлечь файл из контейнера, используя только команду docker build и любой Dockerfile.  
Предоставьте скриншоты  действий .

## Задача 7 (***)
Запустите ваше python-приложение с помощью runC, не используя docker или containerd.  
Предоставьте скриншоты  действий .
