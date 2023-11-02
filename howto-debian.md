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

## Ссылки

- [How To Add a User to Sudoers On Debian 10 Buster](https://devconnected.com/how-to-add-a-user-to-sudoers-on-debian-10-buster/)
- [Enable Contrib and Non-free Repositories on Debian](https://www.xmodulo.com/install-nonfree-packages-debian.html)
