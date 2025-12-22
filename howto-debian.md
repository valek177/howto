# После установки Debian

## Добавляемся в sudoers

1. Получить root-доступ
```
su root
```
2. Добавить себя в sudoers
```
gpasswd -a <username> sudo
```
3. Перезагрузиться

## Настраиваем работу с историей команд

В `/etc/inputrc` исправляем мапинг
```
"\e[A": history-search-backward
"\e[B": history-search-forward
```

## Поднимаем ssh-сервер

```
sudo apt install ssh
```

## Настраиваем переключение клавиатуры

1. Переконфигурировать переключение
```
sudo dpkg-reconfigure keyboard-configuration
```
2. Пофиксить (для `Ctrl-Shift`) для GNOME
```
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Ctrl>Shift_R','<Ctrl>Shift_L']"
```

## Разрешаем работать с non-free пакетами

1. В файле `/etc/apt/sources.list` нужно добавить репозитории `contrib` и `non-free` во всех ссылках
```
deb http://deb.debian.org/debian/ buster main contrib non-free
```
2. Обновляемся
```
sudo apt update
```

## Обновляем версию

1. Обновить пакеты и перезагрузиться
```
sudo apt update
sudo apt upgrade
sudo apt full-upgrade
sudo apt --purge autoremove

reboot
```
2. Исправить адреса репозиториев
В файлах `/etc/apt/sources.list` и `/etc/apt/sources.list.d/*` меняем имя текущей версии на новую, например для `11` -> `12` это будет `bullseye` -> `bookworm`
3. Обновить пакеты и перезагрузиться
```
sudo apt update
sudo apt install zstd
sudo apt upgrade --without-new-pkgs
sudo apt full-upgrade

reboot
```
4. Проверить
```
uname -r
lsb_release -a
```
5. Убрать лишнее
```
sudo apt --purge autoremove
```

## Обновляем список загрузочных записей в `grub`

По умолчанию `os-prober` выключен. Его надо включить и переконфигурировать `grub`.

1. В файле `/etc/default/grub` выставить
```
GRUB_DISABLE_OS_PROBER=false
```
2. Обновить
```
sudo update-grub
```

## Настройка VPN (wireguard)
Общая информация https://wiki.debian.org/WireGuard
Имеем конфиг VPN (.conf)
https://www.cyberciti.biz/faq/how-to-import-wireguard-profile-using-nmcli-on-linux/
1. Создаем соединение 
```
sudo nmcli connection import type wireguard file "$file"
```
2. Поднимаем его
```
nmcli connection up valek-debian-vpn
```
3. Если не хотим автостарта после ребута
```
sudo nmcli conn modify valek-debian-vpn connection.autoconnect no
```
Если firezone:
https://www.firezone.dev/docs/user-guides/client-instructions

## Если не работают вебка и микрофон
1. Чекнуть дрова
https://unix.stackexchange.com/questions/653540/webcam-not-recognized-on-debian-11-sid
```
apt install firmware-linux firmware-realtek
```
2. Можно запустить Cheese, должен запускаться если все ок
3. Как протестить микрофон:
```
arecord -vv -fdat foo.wav
```
https://forums.fedoraforum.org/showthread.php?258562-How-can-I-test-if-my-mic-is-working
## VS Code ssh remote
```
https://code.visualstudio.com/docs/remote/ssh
```
## Копирование файлов с прогрессом
```
rsync -ah --progress source destination
```
https://askubuntu.com/questions/17275/how-to-show-the-transfer-progress-and-speed-when-copying-files-with-cp
## Посмотреть размер файлов/директорий от большего к меньшему - для текущей директории
```
sudo du -s *|sort -nr|cut -f 2-|while read a;do du -hs "$a";done
```
# Настройка принтера
## HP Laserjet P1102w
настройка через CUPS
```
http://localhost:631/admin
```
## Ссылки

- [How To Add a User to Sudoers On Debian 10 Buster](https://devconnected.com/how-to-add-a-user-to-sudoers-on-debian-10-buster/)
- [Enable Contrib and Non-free Repositories on Debian](https://www.xmodulo.com/install-nonfree-packages-debian.html)
