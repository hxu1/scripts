#!/usr/bin/python3

import argparse

parser = argparse.ArgumentParser()
parser.add_argument('min', type=int)
parser.add_argument('max', type=int)
parser.add_argument('input', type=int)

try:
  args = parser.parse_args()
except SystemExit:
  print(-1)
  exit(0)

input_int = int(args.input)
if args.min <= input_int and input_int <= args.max:
  print(input_int)
  exit(0)
else:
  print(-1)
  exit(0)
