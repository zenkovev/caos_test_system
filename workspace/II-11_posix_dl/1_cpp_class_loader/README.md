# 11-1: Posix Dl: Cpp Class Loader

## Условие задачи

Реализуйте механизм динамической загрузки классов C++ по аналогии с
[Java](https://docs.oracle.com/javase/7/docs/api/java/lang/ClassLoader.html).

Необходимо реализовать функциональность классов ClassLoader и Class из предлагаемого интерфейса.

Базовый каталог для поиска классов определен в переменной окружения CLASSPATH. Имя класса совпадает
с каноническим именем файла библиотеки. Полное имя класса может содержать пространства имен C++,
разделяемые символами ::. В этом случае необходимо искать файлы в соответствующих подкаталогах
(по аналогии с пакетами в Java или Python).

Пример: класс `some::package::ClassInPackage` будет находиться в библиотеке
`$CLASSPATH/some/package/ClassInPackage.so`.

Для загруженных классов необходимо уметь создавать их экземляры с помощью метода newInstance.
При этом гарантируется, что каждый загружаемый класс имеет конструктор по умолчанию.
В загружаемых классах могут быть виртуальные методы и виртуальные деструкторы.

Интерфейс который необходимо реализовать (при отправке в систему он описан в файле interfaces.h,
который нужно подключить директивой #include):
```c
#include <string>

class AbstractClass
{
    friend class ClassLoader;
public:
    AbstractClass();
    ~AbstractClass();
protected:
    void* newInstanceWithSize(size_t sizeofClass);
    struct ClassImpl* pImpl;
};

template <class T>
class Class
        : public AbstractClass
{
public:
    T* newInstance()
    {
        size_t classSize = sizeof(T);
        void* rawPtr = newInstanceWithSize(classSize);
        return reinterpret_cast<T*>(rawPtr);
    }
};

enum class ClassLoaderError {
    NoError = 0,
    FileNotFound,
    LibraryLoadError,
    NoClassInLibrary
};


class ClassLoader
{
public:
    ClassLoader();
    AbstractClass* loadClass(const std::string &fullyQualifiedName);
    ClassLoaderError lastError() const;
    ~ClassLoader();
private:
    struct ClassLoaderImpl* pImpl;
};
```

## Комментарий к тестам

Файл `interfaces.h` можно подключить как
```c
#include "interfaces.h"
```

В тестах присутствует только уровень `run.sh`.

На основе реализации заголовочного файла `interfaces.h`
и программ на C, использующих этот интерфейс, находящихся в `test_files/sources`,
собираются исполняемые файлы в `tmp_files/bin`.
Есть обычная сборка и сборка с Address Sanitizer.
Отчёт о компиляции выводится в файлы в `tmp_files/gcc_compilation`.

## Краткое описание работы тестов

В качестве базового каталога из переменной `CLASSPATH` используется
создаваемая в процессе тестов директория `tmp_files/class_sources`.
В процессе тестирования также собираются все библиотеки этого каталога,
на основе хедеров из `test_files/class_hpp` и cpp-шников из `test_files/class_cpp`.
Эти файлы hpp и cpp расположены по таким же внутренним путям, что и библиотеки из условия.
Сборка производится с помощью скрипта `test_files/make_all_libs.sh`.

В директории с задачей находится данный в условии заголовочный файл `interfaces.h`.
Для его реализации предлагается файл `interfaces.cpp`.
Этот интерфейс используется в тестах `main_basic.cpp` и `main_std.cpp`
из директории `test_files/sources`.
`main_basic.cpp` проверяет случаи простого класса, класса с виртуальными методами,
и класса в пространстве имён C++.
`main_std.cpp` проверяет особый отдельный случай:
сложные пространства имён, одно из которых `std`.
При этом в этих файлах есть обработка ошибок, которая может помочь
при поиске ошибок при просмотре `tmp_files/real_output`.
