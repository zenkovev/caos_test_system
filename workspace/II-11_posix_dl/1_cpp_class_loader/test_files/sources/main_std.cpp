#include "../../interfaces.h"

#include <iostream>

#include "../class_hpp/std/Example1.hpp"
#include "../class_hpp/std/exe/Example2.hpp"
#include "../class_hpp/exe/std/Example3.hpp"
#include "../class_hpp/abra/std/cadabra/Example4.hpp"

static ClassLoader* Loader = nullptr;

void test_4_ExampleClass1() {
  std::cout << "===== Test 4 =====" << std::endl;
  Class<std::Example1>* c = reinterpret_cast<Class<std::Example1>*>(
		Loader->loadClass("std::Example1")
  );
  if (c == nullptr) {
    std::cout << "Example1: bad loadClass" << std::endl;
    return;
  }
  std::Example1* instance = c->newInstance();
  if (instance == nullptr) {
    std::cout << "Example1: bad constructor" << std::endl;
    delete c;
    return;
  }
  delete c;
  delete instance;
  return;
}

void test_5_ExampleClass2() {
  std::cout << "===== Test 5 =====" << std::endl;
  Class<std::exe::Example2>* c = reinterpret_cast<Class<std::exe::Example2>*>(
		Loader->loadClass("std::exe::Example2")
  );
  if (c == nullptr) {
    std::cout << "Example2: bad loadClass" << std::endl;
    return;
  }
  std::exe::Example2* instance = c->newInstance();
  if (instance == nullptr) {
    std::cout << "Example2: bad constructor" << std::endl;
    delete c;
    return;
  }
  delete c;
  delete instance;
  return;
}

void test_6_ExampleClass3() {
  std::cout << "===== Test 6 =====" << std::endl;
  Class<exe::std::Example3>* c = reinterpret_cast<Class<exe::std::Example3>*>(
		Loader->loadClass("exe::std::Example3")
  );
  if (c == nullptr) {
    std::cout << "Example3: bad loadClass" << std::endl;
    return;
  }
  exe::std::Example3* instance = c->newInstance();
  if (instance == nullptr) {
    std::cout << "Example3: bad constructor" << std::endl;
    delete c;
    return;
  }
  delete c;
  delete instance;
  return;
}

void test_7_ExampleClass4() {
  std::cout << "===== Test 7 =====" << std::endl;
  Class<abra::std::cadabra::Example4>* c = reinterpret_cast<Class<abra::std::cadabra::Example4>*>(
		Loader->loadClass("abra::std::cadabra::Example4")
  );
  if (c == nullptr) {
    std::cout << "Example4: bad loadClass" << std::endl;
    return;
  }
  abra::std::cadabra::Example4* instance = c->newInstance();
  if (instance == nullptr) {
    std::cout << "Example4: bad constructor" << std::endl;
    delete c;
    return;
  }
  delete c;
  delete instance;
  return;
}


int main() {
  Loader = new ClassLoader();

  test_4_ExampleClass1();
  test_5_ExampleClass2();
  test_6_ExampleClass3();
  test_7_ExampleClass4();

  delete Loader;
  return 0;
}
