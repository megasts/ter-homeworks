# Домашнее задание к занятию «Продвинутые методы работы с Terraform»

### Цели задания

1. Научиться использовать модули.
2. Отработать операции state.
3. Закрепить пройденный материал.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории [**04/src**](https://github.com/netology-code/ter-homeworks/tree/main/04/src).
4. Любые ВМ, использованные при выполнении задания, должны быть прерываемыми, для экономии средств.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
Убедитесь что ваша версия **Terraform** ~>1.8.4
Пишем красивый код, хардкод значения не допустимы!
------

### Задание 1

1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания с помощью двух вызовов remote-модуля -> двух ВМ, относящихся к разным проектам(marketing и analytics) используйте labels для обозначения принадлежности.  В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.
3. Добавьте в файл cloud-init.yml установку nginx.
4. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```, скриншот консоли ВМ yandex cloud с их метками. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.marketing_vm
------

### Ответ
  - скриншот подключения к консоли и вывод команды ```sudo nginx -t```

![Screenshot1_1](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot1_1.png)

  - скриншоты консоли ВМ yandex cloud с их метками

![Screenshot1_2](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot1_2.png)

![Screenshot1_3](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot1_3.png)

  - скриншоты содержимого модулей

![Screenshot1_4](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot1_4.png)

![Screenshot1_5](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot1_5.png)

------

### Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: ```ru-central1-a```.
2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.
3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev  
4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
5. Сгенерируйте документацию к модулю с помощью terraform-docs.

------ 
### Ответ

Документация к модулю: [README.md](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/src/vpc/README.md)

------

### Задание 3
1. Выведите список ресурсов в стейте.
2. Полностью удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.
4. Импортируйте всё обратно. Проверьте terraform plan. Значимых(!!) изменений быть не должно.
Приложите список выполненных команд и скриншоты процессы.

------

### Ответ
1. Выведите список ресурсов в стейте.
```
terraform state list
```
![Screenshot3_1](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot3_1.png)

2. Полностью удалите из стейта модуль vpc.
```
terraform state rm module.vpc
```
![Screenshot3_2](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot3_2.png)

3. Полностью удалите из стейта модуль vm.
```
terraform state rm module.analytics_vm
terraform state rm module.marketing_vm
```
![Screenshot3_3](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot3_3.png)

4. Импортируйте всё обратно.
```
terraform import module.analytics_vm.yandex_compute_instance.vm[0] fhmciamqat6poetbe2tp
terraform import module.marketing_vm.yandex_compute_instance.vm[0] fhmoopcua3apvo1v503e
terraform import module.vpc.yandex_vpc_subnet.my_subnet e9b2ash7or07isrjg85e
terraform import module.vpc.yandex_vpc_network.my_network enpv8hcj2qfl85ed16bm
```
![Screenshot3_4](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot3_4.png)

![Screenshot3_5](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot3_5.png)

![Screenshot3_6](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot3_6.png)

![Screenshot3_7](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot3_7.png)

------

## Дополнительные задания (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.**   Они помогут глубже разобраться в материале.   
Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 


### Задание 4*

1. Измените модуль vpc так, чтобы он мог создать подсети во всех зонах доступности, переданных в переменной типа list(object) при вызове модуля.  
  
Пример вызова
```
module "vpc_prod" {
  source       = "./vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}
```

Предоставьте код, план выполнения, результат из консоли YC.

------

### Ответ

  - код модуля находится здесь: [vpc_2](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/src/vpc_2)

  - скрин плана выполнения:

  ![Screenshot4_1](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot4_1.png)

  - скрин результата из консоли YC:

  ![Screenshot4_2](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot4_2.png)


------

### Задание 5*

1. Напишите модуль для создания кластера managed БД Mysql в Yandex Cloud с одним или несколькими(2 по умолчанию) хостами в зависимости от переменной HA=true или HA=false. Используйте ресурс yandex_mdb_mysql_cluster: передайте имя кластера и id сети.
2. Напишите модуль для создания базы данных и пользователя в уже существующем кластере managed БД Mysql. Используйте ресурсы yandex_mdb_mysql_database и yandex_mdb_mysql_user: передайте имя базы данных, имя пользователя и id кластера при вызове модуля.
3. Используя оба модуля, создайте кластер example из одного хоста, а затем добавьте в него БД test и пользователя app. Затем измените переменную и превратите сингл хост в кластер из 2-х серверов.
4. Предоставьте план выполнения и по возможности результат. Сразу же удаляйте созданные ресурсы, так как кластер может стоить очень дорого. Используйте минимальную конфигурацию.

------

### Ответ

  - код находится здесь: [mysql_cluster](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/src/mdb_mysql_cluster)
  [module_cluster](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/src/mdb_cluster)
  [module_mysql](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/src/mdb_mysql)

  - скрин плана выполнения: 

  ![Screenshot5_1](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot5_1.png)
  ![Screenshot5_2](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot5_2.png)

  - результат:

  ![Screenshot5_3](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot5_3.png)
  ![Screenshot5_4](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot5_4.png)
  ![Screenshot5_5](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot5_5.png)
  ![Screenshot5_6](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot5_6.png)
  ![Screenshot5_7](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot5_7.png)
  ![Screenshot5_8](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot5_8.png)
  ![Screenshot5_9](https://github.com/megasts/ter-homeworks/blob/terraform-04/04/img/Screenshot5_9.png)

### Задание 6*
1. Используя готовый yandex cloud terraform module и пример его вызова(examples/simple-bucket): https://github.com/terraform-yc-modules/terraform-yc-s3 .
Создайте и не удаляйте для себя s3 бакет размером 1 ГБ(это бесплатно), он пригодится вам в ДЗ к 5 лекции.

### Задание 7*

1. Разверните у себя локально vault, используя docker-compose.yml в проекте.
2. Для входа в web-интерфейс и авторизации terraform в vault используйте токен "education".
3. Создайте новый секрет по пути http://127.0.0.1:8200/ui/vault/secrets/secret/create
Path: example  
secret data key: test 
secret data value: congrats!  
4. Считайте этот секрет с помощью terraform и выведите его в output по примеру:
```
provider "vault" {
 address = "http://<IP_ADDRESS>:<PORT_NUMBER>"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 

Можно обратиться не к словарю, а конкретному ключу:
terraform console: >nonsensitive(data.vault_generic_secret.vault_example.data.<имя ключа в секрете>)
```
5. Попробуйте самостоятельно разобраться в документации и записать новый секрет в vault с помощью terraform. 

### Задание 8*
Попробуйте самостоятельно разобраться в документаци и с помощью terraform remote state разделить root модуль на два отдельных root-модуля: создание VPC , создание ВМ . 

### Правила приёма работы

В своём git-репозитории создайте новую ветку terraform-04, закоммитьте в эту ветку свой финальный код проекта. Ответы на задания и необходимые скриншоты оформите в md-файле в ветке terraform-04.

В качестве результата прикрепите ссылку на ветку terraform-04 в вашем репозитории.

**Важно.** Удалите все созданные ресурсы.

### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 




