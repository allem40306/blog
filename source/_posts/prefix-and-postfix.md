---
title: prefix and postfix
date: 2019-04-05 14:14:33
category: 隨筆
tags:
- 隨筆
---
在很多程式語言都有prefix and postfix ++/--，常用在迴圈上。通常我們會看到的差異是先改值或先傳值，在使用設面沒有特別注意其他事情。最近我了解到實作上的差異，prefix是直接改值，postfix則是先複製一份物件，然後再改值，這樣的結果會使postfix多生成一個物件，因此如果可以的話，要使用prefix++/--。
example from https://docs.microsoft.com/zh-tw/cpp/cpp/increment-and-decrement-operator-overloading-cpp?view=vs-2019
{% codeblock lang:cpp %}
// increment_and_decrement1.cpp
class Point
{
public:
   // Declare prefix and postfix increment operators.
   Point& operator++();       // Prefix increment operator.
   Point operator++(int);     // Postfix increment operator.

   // Declare prefix and postfix decrement operators.
   Point& operator--();       // Prefix decrement operator.
   Point operator--(int);     // Postfix decrement operator.

   // Define default constructor.
   Point() { _x = _y = 0; }

   // Define accessor functions.
   int x() { return _x; }
   int y() { return _y; }
private:
   int _x, _y;
};

// Define prefix increment operator.
Point& Point::operator++()
{
   _x++;
   _y++;
   return *this;
}

// Define postfix increment operator.
Point Point::operator++(int)
{
   Point temp = *this;
   ++*this;
   return temp;
}

// Define prefix decrement operator.
Point& Point::operator--()
{
   _x--;
   _y--;
   return *this;
}

// Define postfix decrement operator.
Point Point::operator--(int)
{
   Point temp = *this;
   --*this;
   return temp;
}
int main()
{
}
{% endcodeblock %}