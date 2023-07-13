#include "../../interfaces.h"

#include <iostream>

#include "../class_hpp/SimpleClass.hpp"
#include "../class_hpp/SpecialClass.hpp"
#include "../class_hpp/some/package/ClassInPackage.hpp"

static ClassLoader* Loader = nullptr;

void test_1_SimpleClass() {
  std::cout << "===== Test 1 =====" << std::endl;
  Class<SimpleClass>* c = reinterpret_cast<Class<SimpleClass>*>(
		Loader->loadClass("SimpleClass")
  );
  if (c == nullptr) {
    std::cout << "Simple Class: bad loadClass" << std::endl;
    return;
  }
  SimpleClass* instance = c->newInstance();
  if (instance == nullptr) {
    std::cout << "Simple Class: bad constructor" << std::endl;
    delete c;
    return;
  }
  delete c;
  delete instance;
  return;
}

void test_2_SpecialClass() {
  std::cout << "===== Test 2 =====" << std::endl;
  Class<SpecialClass>* c = reinterpret_cast<Class<SpecialClass>*>(
		Loader->loadClass("SpecialClass")
  );
  if (c == nullptr) {
    std::cout << "Special Class: bad loadClass" << std::endl;
    return;
  }
  SpecialClass* instance = c->newInstance();
  if (instance == nullptr) {
    std::cout << "Special Class: bad constructor" << std::endl;
    delete c;
    return;
  }
  instance->Print(42);

  delete c;
  delete instance;
  return;
}

void test_3_ClassInPackage() {
  std::cout << "===== Test 3 =====" << std::endl;
  Class<some::package::ClassInPackage>* c = reinterpret_cast<Class<some::package::ClassInPackage>*>(
		Loader->loadClass("some::package::ClassInPackage")
  );
  if (c == nullptr) {
    std::cout << "ClassInPackage: bad loadClass" << std::endl;
    return;
  }
  some::package::ClassInPackage* instance = c->newInstance();
  if (instance == nullptr) {
    std::cout << "ClassInPackage: bad constructor" << std::endl;
    delete c;
    return;
  }
  std::cout << instance->GetValue() << std::endl;
  instance->SetValue(50);
  std::cout << instance->GetValue() << std::endl;

  delete c;
  delete instance;
  return;
}

int main() {
  Loader = new ClassLoader();

  test_1_SimpleClass();
  test_2_SpecialClass();
  test_3_ClassInPackage();

  delete Loader;
  return 0;
}
