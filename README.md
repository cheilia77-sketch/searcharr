# Searcharr

Telegram-бот для добавления фильмов в Radarr, сериалов в Sonarr и книг в Readarr.

Проект адаптирован под более удобный сценарий работы:

- после авторизации бот показывает кнопки категорий
- пользователь нажимает `Кино`, `Сериал` или `Книга`
- бот просит ввести название обычным сообщением
- если поиск фильма ничего не дал, бот предлагает попробовать поиск как сериала
- если поиск сериала ничего не дал, бот предлагает попробовать поиск как фильма

## Что умеет бот

- авторизация обычных пользователей и администраторов
- поиск фильмов, сериалов и книг
- выбор корневой папки и профиля качества перед добавлением
- добавление тегов, если это включено в настройках
- управление пользователями через команду `/users`

## Требования

- Python `3.8.3+`
- рабочий Telegram Bot Token
- настроенные Sonarr и/или Radarr и/или Readarr
- API-ключи от соответствующих сервисов

## Быстрый старт

### 1. Подготовьте Telegram-бота

1. Создайте бота через `@BotFather`.
2. Получите токен и сохраните его.
3. При необходимости включите privacy mode или отключите её в зависимости от вашего сценария использования.

### 2. Создайте файл настроек

Скопируйте `settings-sample.py` в `settings.py`:

```powershell
Copy-Item settings-sample.py settings.py
```

Минимально заполните:

- `searcharr_password`
- `searcharr_admin_password`
- `searcharr_language`
- `tgram_token`
- `sonarr_url`, `sonarr_api_key`, `sonarr_quality_profile_id`
- `radarr_url`, `radarr_api_key`, `radarr_quality_profile_id`
- `readarr_url`, `readarr_api_key`, `readarr_quality_profile_id`, `readarr_metadata_profile_id`

Если какой-то сервис вам не нужен, отключите его через:

```python
sonarr_enabled = False
radarr_enabled = False
readarr_enabled = False
```

### 3. Выберите язык

В проекте оставлены только два языка интерфейса:

- `en-us`
- `ru-ru`

Пример:

```python
searcharr_language = "ru-ru"
```

## Самостоятельное развёртывание из исходников

### Windows

1. Установите Python `3.8.3+`.
2. Откройте терминал в папке проекта.
3. Создайте и активируйте виртуальное окружение:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

4. Установите зависимости:

```powershell
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

5. Создайте `settings.py` из шаблона и заполните его.
6. Запустите бота:

```powershell
python searcharr.py
```

### Linux

1. Убедитесь, что установлены `python3`, `python3-venv` и `pip`.
2. Перейдите в каталог проекта.
3. Создайте и активируйте виртуальное окружение:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

4. Установите зависимости:

```bash
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
```

5. Создайте `settings.py` из `settings-sample.py`.
6. Запустите бота:

```bash
python3 searcharr.py
```

## Развёртывание через Docker

### Вариант с `docker compose`

1. Создайте локальные каталоги:

```powershell
New-Item -ItemType Directory -Force data, logs
Copy-Item settings-sample.py settings.py
```

2. Отредактируйте `settings.py`.
3. Проверьте volume-монты в `docker-compose.yml`.
4. Запустите контейнер:

```powershell
docker compose up -d
```

Для просмотра логов:

```powershell
docker compose logs -f
```

### Что должно быть смонтировано в контейнер

- `settings.py` в `/app/settings.py`
- каталог `data` в `/app/data`
- каталог `logs` в `/app/logs`

## Первый запуск и использование

### Авторизация

Откройте приватный чат с ботом и отправьте:

```text
/start <пароль>
```

Для входа как администратор:

```text
/start <admin_password>
```

Не отправляйте пароль администратора в групповой чат.

### Поиск и добавление

После успешной авторизации бот покажет кнопки категорий.

Сценарий работы:

1. Нажмите `Кино` или `Сериал`.
2. Введите название сообщением.
3. Бот покажет найденный результат и кнопки навигации.
4. Нажмите кнопку добавления.
5. При необходимости выберите папку, профиль качества, теги и другие параметры.

Команды `/movie`, `/series` и `/book` по-прежнему можно использовать, но основной сценарий теперь рассчитан на кнопки и диалог.

### Управление пользователями

Если вы авторизованы как администратор, используйте:

```text
/users
```

Бот покажет список пользователей с кнопками управления доступом.

## Полезные файлы

- `searcharr.py` - основной файл бота
- `settings-sample.py` - шаблон настроек
- `docker-compose.yml` - пример запуска в контейнере
- `lang/en-us.yml` - английская локализация
- `lang/ru-ru.yml` - русская локализация

## Примечания

- база SQLite создаётся автоматически в каталоге `data`
- логи пишутся в каталог `logs`, если он доступен контейнеру или процессу
- если у вас только один root folder или один quality profile, бот пропустит эти шаги и сразу перейдёт к добавлению
