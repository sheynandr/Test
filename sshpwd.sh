#!/usr/bin/sh
password=$(tr -dc A-Za-z0-9 < /dev/urandom | head -c15)
echo "Введите enable для включения или disable для выключения авторизации по паролю."
echo "Также можно использовать команду enable gen для генерации временного пароля."
echo "Что нужно? " && read status
if [ "$status" = "enable" ]; then
sed -i 's/PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
elif [ "$status" = "disable" ]; then
sed -i 's/PubkeyAuthentication.*/PubkeyAuthentication no/' /etc/ssh/sshd_config
elif [ "$status" = "enable gen" ]; then
sed -i 's/PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
echo "Пароль для пользователя" $password
echo root:$password | chpasswd
fi
