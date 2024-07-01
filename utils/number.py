#!/usr/bin/python3

import argparse
import re

IS_NUMBER = re.compile('(?:\d|[1-9]\d+)')

parser = argparse.ArgumentParser()
parser.add_argument('min', type=int)
parser.add_argument('max', type=int)
parser.add_argument('input')

args = parser.parse_args()

if IS_NUMBER.fullmatch(args.input) is None:
  print('input is not a valid number')
  exit(1)

input_int = int(args.input)
if args.min <= input_int and input_int <= args.max:
  exit(0)
else:
  print('input is not in range')
  exit(1)
