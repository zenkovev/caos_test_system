# 10-2: Fuse: Unzipfs

## Условие задачи

Реализуйте файловую систему, доступную только для чтения, которая обеспечивает
доступ к содержимому ZIP-архива.

Внутри файловой системы могут быть только регулярные файлы с правами 0444
и подкаталоги с правами 0555.

Программа для реализации файловой системы должна поддерживать стандартный набор опций FUSE
и опцию для указания имени файла с образом файловой системы --src ИМЯ\_ФАЙЛА.zip.

Используйте [библиотеку FUSE](https://github.com/libfuse/libfuse/tree/fuse-3.6.0) версии 3.0 и выше,
и [библиотеку libzip](https://libzip.org/).

## Комментарий к тестам

В случае реализации достаточно сложных файловых систем громоздкой работой является
подсчёт числа хард-ссылок на обычный файл или директорию, в основном на директорию.
При этом, так как файловые системы в задачах не реализуют удаление файлов или создание хард-ссылок,
этот подсчёт не имеет особого смысла.
Поэтому гарантируется, что это не проверяется тестами.
Можно также посмотреть это
[обсуждение](https://stackoverflow.com/questions/62264562/what-to-set-for-st-nlink-as-attribute-when-implementing-fuse).

Также гарантируется, что используемый в тестах ZIP-архив создан без сжатия данных.
Иначе, кажется, что задача станет в разы сложнее.

В тестах присутствует только уровень `run.sh`.

Компиляция файла с программой производится с помощью `cmake`,
для этого в директории с задачей есть `CMakeLists.txt`.
Отчёт о сборке выводится в файл `tmp_files/cmake_and_make_output.txt`.
Если программа скомпилирована успешно, то она находится как `tmp_files/unzipfs`.

Создаваемая при запуске тестов файловая система монтируется в директорию `tmp_files/mnt`.
Размонтирование выполняется в скрипте `clear.sh`. В большинстве случаев,
в частности при корректном решении, размонтирование работает корректно,
но в случае возникновения проблем следует размонтировать вручную,
а затем повторно запустить скрипт `clear.sh`.

## Краткое описание работы тестов

При тестировании компилируется программа.
Для этого с помощью `CMakeLists.txt` производится сборка в `tmp_files/build`,
после чего собранная программа выносится как `tmp_files/unzipfs`.
Если программа не собрана, то запуски программы не производятся.

Затем производится монтирование файловой системы в директорию `tmp_files/mnt`
в результате запуска программы на основе заготовленных данных.
В качестве данных - ZIP-архива - выступает `test_files/files.zip`.

Используется проверка вывода в следующих случаях:
- поток ошибок при монтировании файловой системы -
должен быть пустым - не очень содержательная проверка;
- вывод утилиты `ls` для рекурсивного запуска от точки монтирования -
проверяет корректность дерева файловой системы;
- содержимое файлов полученной файловой системы, выведенное подряд, файлы отсортированы
для однозначности - проверяет корректность операций открытия и чтения файла.