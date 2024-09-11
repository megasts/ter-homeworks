# первый вариант получения inventory-файл для ansible (посредством шаблона)
resource "local_file" "hosts_templatefile" {
  content = templatefile("${(path.module)}/hosts.tftpl",
    {
    webservers = yandex_compute_instance.vm_web[*],
    databases = yandex_compute_instance.vm_database,
    storages = [yandex_compute_instance.vm_storage]
    }
  )
  filename = "${abspath(path.module)}/hosts.ini"
}

# второй вариант получения inventory-файл для ansible
resource "local_file" "hosts_ini" {
  content =  <<-EOT
%{~ if length(yandex_compute_instance.vm_web) > 0 ~}
[webservers]

%{~ for i in yandex_compute_instance.vm_web ~}
%{~ if "${i.network_interface.0.nat_ip_address}" == "" ~}
${i["name"]}   ansible_host=${i["network_interface"][0]["ip_address"]} fqdn=${i["fqdn"]}
%{else}
${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]} fqdn=${i["fqdn"]}
%{~ endif ~}
%{endfor ~}
%{endif ~}


%{if length(yandex_compute_instance.vm_database) > 0 ~}
[databases]

%{~ for i in yandex_compute_instance.vm_database ~}
%{~ if "${i.network_interface.0.nat_ip_address}" == "" ~}
${i["name"]}   ansible_host=${i["network_interface"][0]["ip_address"]} fqdn=${i["fqdn"]}
%{else}
${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]} fqdn=${i["fqdn"]}
%{~ endif ~}
%{endfor ~}
%{endif ~}


%{if length([yandex_compute_instance.vm_storage]) > 0 ~}
[storages]


%{~ for i in [yandex_compute_instance.vm_storage] ~}
%{~ if "${i.network_interface.0.nat_ip_address}" == "" ~}
${i["name"]}   ansible_host=${i["network_interface"][0]["ip_address"]} fqdn=${i["fqdn"]}
%{~ else ~}
${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]} fqdn=${i["fqdn"]}
%{~ endif ~}
%{endfor ~}
%{endif ~}
EOT
  filename = "${abspath(path.module)}/hosts_var2.ini"
}

resource "null_resource" "web_hosts_provision" {
  count = var.web_provision == true ? 1 : 0 
  #Ждем создания инстанса
  depends_on = [yandex_compute_instance.vm_storage,
  yandex_compute_instance.vm_database,
  yandex_compute_instance.vm_web]
  #Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command = "eval $(ssh-agent) && ${local.ssh_key_serial_port.ssh-keys} | ssh-add -"
    on_failure  = continue #Продолжить выполнение terraform pipeline в случае ошибок
  }
  #Запуск ansible-playbook
  provisioner "local-exec" {
    # without secrets
    command     = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/hosts.ini ${abspath(path.module)}/test.yml"
    
    #secrets pass
    #> nonsensitive(jsonencode( {for k,v in random_password.each: k=>v.result}))
    /*
      "{\"netology-develop-platform-web-0\":\"u(qzeC#nKjp*wTOY\",\"netology-develop-platform-web-1\":\"=pA12\\u0026C2eCl[Oe$9\"}"
    */
    # command     = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/for.ini ${abspath(path.module)}/test.yml --extra-vars '{\"secrets\": ${jsonencode( {for k,v in random_password.each: k=>v.result})} }'"

    # for complex cases instead  --extra-vars "key=value", use --extra-vars "@some_file.json"

    on_failure  = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
  triggers = {
    always_run        = "${timestamp()}"                         #всегда т.к. дата и время постоянно изменяются
    always_run_uuid = "${uuid()}" 
    # playbook_src_hash = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
    # ssh_public_key    = var.public_key                           # при изменении переменной with ssh
    # template_rendered = "${local_file.hosts_templatefile.content}" #при изменении inventory-template
    # password_change = jsonencode( {for k,v in random_password.each: k=>v.result})

  }

}