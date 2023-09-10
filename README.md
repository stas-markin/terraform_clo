запуск создания VM и установка wireguard server
```
./install.sh
```

создание клиента wireguard
```
./ansible_client.sh
```
Для запуска указать в скрипте через переменную имя клиента

***-e 'client_name=stas_laptop'***

Для новых клиентов указать новую подсеть в 
`/ansible/roles/install_client_wireguard/templates/wg0.conf.j2`

*Address = 10.0.0.2/32*