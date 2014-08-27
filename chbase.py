#!/usr/bin/env python

import argparse

LETTERS = list(map(chr, (range(65, 91))))
ALPHABET = list(map(str, range(10))) + LETTERS


def chbase(from_base, to_base, x):
    result = []
    while x > 0:
        rem = x % to_base
        x = int(x/to_base)
        result.append(rem)

    result.reverse()
    result = map(lambda i: ALPHABET[i], result)

    return "".join(result)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("from_base", metavar="FROM_BASE", type=int,
                   help="Base to convert from")
    parser.add_argument("to_base", metavar="TO_BASE", type=int,
                   help="Base to convert to")
    parser.add_argument("num", metavar="NUM", type=int,
                   help="Number to convert")
    args = parser.parse_args()

    print(chbase(args.from_base, args.to_base, args.num))
