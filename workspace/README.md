# Как устроены тесты и как их запускать

Объяснение на примере задачи
[Tutorial](https://github.com/zenkovev/caos_test_system/tree/main/workspace/I-00_tutorial/0_tutorial),
если в других задачах будут особенности, они будут оговорены в описании к задаче.

В случае задачи Tutorial структура тестов слишком сложна относительно самой задачи,
но она отражает ту структуру, которая будет использоваться в дальнейшем.

## Файл с решением

Решение задачи - файл с кодом. В файле `program_name.txt` указано имя файла, который будет
проверяться тестами. По умолчанию там уже установлено название, и в директории с задачей есть пустой
файл с таким названием. Это название можно менять, в таком случае файл с решением должен находиться
в директории с задачей.

## Главные скрипты

Есть три скрипта, которые используются для тестирования:
- `run.sh`: запуск основных тестов
- `run_hard.sh`: запуск более сложных тестов
- `clear.sh`: удаление временных файлов, созданных в процессе тестирования

Предполагается, что скрипт `run.sh` - это и есть тестирование задачи,
а скрипт `run_hard.sh` проверяет более редкие ситуации, которые, возможно,
не всегда есть смысл обрабатывать или обрабатывать таким образом, как того требуют тесты,
то есть своеобразный бонусный уровень.

То есть запуск тестов устроен следующим образом:
```shell
./run.sh
./clear.sh
./run_hard.sh
./clear.sh
```

Гарантируется, что пары запусков (`run.sh`, `clear.sh`) и (`run_hard.sh`, `clear.sh`) ничего не меняют
в директории с задачей, запуски `run.sh` и `run_hard.sh` меняют только содержимое директории
`tmp_files`, которая изначально пуста, `clear.sh` удаляет всё содержимое этой директории.

## Другие файлы и вывод программы

### Вспомогательные поддиректории

В директории с задачей есть ещё две поддиректории: `test_files` и `tmp_files`.
В первой находятся вспомогательные файлы для тестирования,
созданные до тестирования.
Во второй находятся вспомогательные файлы для тестирования,
которые создаются в процессе тестирования.

### Вывод программы

Среди файлов в этих директориях наиболее важны две поддиректории:
`test_files/expected_output` и `tmp_files/real_output`.
Там находятся ожидаемый вывод программы и вывод программы,
полученный в процессе тестирования на различных запусках, соответственно.
`run.sh` и `run_hard.sh` в конце своей работы выдают результат сравнения
файлов из `test_files/expected_output` и `tmp_files/real_output`.

Список всех файлов, используемых в тесте `run.sh`, находится
в файле `test_files/check_simple_list.txt`.
Список всех файлов, используемых в тесте `run_hard.sh`, находится
в файле `test_files/check_hard_list.txt`.
В точности оттуда берётся список файлов для сравнения.
В случае, если какие-то файлы отличаются, можно переходить в эти директории,
смотреть различия и пытаться понять проблему.

То, на каких запусках создавался конкретный файл для `tmp_files/real_output`,
можно смотреть в скриптах `run.sh` и `run_hard.sh`,
всё создание происходит там.
Например, если файл в `tmp_files/real_output` даже не создан,
вероятно, программу не удалось скомпилировать.
В задаче Tutorial в скриптах `run.sh` и `run_hard.sh`
есть комментарии для понимания работы тестов.

### Вспомогательные скрипты

Сравнение производится внутри скриптов `run.sh` и `run_hard.sh`
с помощью скриптов `check_simple.sh`, `check_hard.sh`, `check.sh`,
находящихся в директории `test_files`.

### Формат вывода программы

Конечно, посимвольная проверка вывода имеет свои недостатки.
Например, если нужно вывести десять чисел, обычно не накладывается ограничений,
как их разделять, пробелами или переносами строки. Посимвольная проверка вывода
накладывает здесь жёсткие ограничения на требуемый вывод.

Чтобы этого избежать, создана модификация задачи
[Tutorial](https://github.com/zenkovev/caos_test_system/tree/main/workspace/I-00_tutorial/0_tutorial)
с названием
[Tutorial Format](https://github.com/zenkovev/caos_test_system/tree/main/workspace/I-00_tutorial/1_tutorial_format).
На основе её тестов будут создаваться тесты ко всем подобным задачам.

Как изменились тесты? Теперь перед запуском скрипта `test_files/check.sh` производится запуск
скрипта `test_files/format.sh`. Он создаёт директорию `tmp_files/format_output`, после чего
необходимые файлы из `tmp_files/real_output` сохраняются в `tmp_files/format_output`
с тем же названием и с преобразованным содержанием.
Преобразование заключается в приведении всех непечатаемых символов в файле
к виду, требуемому в `test_files/expected_output`.
И все сравнения в тестах производятся для файлов из директорий
`test_files/expected_output` и `tmp_files/format_output`.

### Работа из IDE

В качестве предлагаемого способа работы с задачами из IDE
представлена модификация задачи
[Tutorial Format](https://github.com/zenkovev/caos_test_system/tree/main/workspace/I-00_tutorial/1_tutorial_format)
с названием
[Tutorial IDE](https://github.com/zenkovev/caos_test_system/tree/main/workspace/I-00_tutorial/2_tutorial_ide).
Предлагается в директории с задачей создать поддиректорию `IDE`,
в которой будет находиться файл с решением и `CMakeLists.txt`.
Эту поддиректорию можно открывать в IDE как проект.
Проверено на CLion и VS Code.

При этом из всей поддиректории `IDE` на запуск и работу тестов будет влиять лишь файл с решением.
Для этого соответствующим образом изменён файл `program_name.txt`.

TODO: Планируется создать поддиректории `IDE` с `CMakeLists.txt` для всех задач,
а также проверить и сделать инструкцию по совместному использованию Docker и IDE.
