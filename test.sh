#!/bin/bash
assert() {
  expected="$1"
  input="$2"

  ./kcc "$input" > tmp.s
  cc -o tmp tmp.s
  ./tmp
  actual="$?"

  if [ "$actual" = "$expected" ]; then
    echo "$input => $actual"
  else
    echo "$input => $expected expected, but got $actual"
    exit 1
  fi
}

assert 0 0
assert 42 42
assert 21 "5+20-4"
assert 41 " 12 + 34 - 5"
assert 9 "3 * 3"
assert 9 "2 +1 + 4 * 2 - 6 / 3"
assert 12 "4 * (2+1)"
assert 10 "-10 + 20"
assert 2 "+ 4 -2"

echo OK