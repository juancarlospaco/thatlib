#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import timeit
import time
import string
import argparse
import csv


def run_test(library, repetitions, setup_test, run_test):
    mytime = timeit.timeit(stmt=run_test, setup=setup_test, number=repetitions)
    print(f"{library} =\t{round(mytime, 4)}")
    result = [library, repetitions, mytime]
    return result


def run_all_benchmarks(repetitions=10_000, output_file="results.csv"):
    results = []
    tests = []

    tests.append(('pathlib cwd() ', 'import pathlib', "pathlib.Path().cwd()"))
    tests.append(('thatlib cwd() ', 'import thatlib', "thatlib.cwd()"))

    tests.append(('pathlib home()', 'import pathlib', "pathlib.Path().home()"))
    tests.append(('thatlib home()', 'import thatlib', "thatlib.home()"))

    tests.append(('pathlib is_file()', 'import pathlib', "pathlib.Path(__file__).is_file()"))
    tests.append(('thatlib is_file()', 'import thatlib', "thatlib.is_file(__file__)"))

    tests.append(('pathlib exists()', 'import pathlib', "pathlib.Path(__file__).exists()"))
    tests.append(('thatlib exists()', 'import thatlib', "thatlib.exists(__file__)"))

    tests.append(('pathlib is_absolute()', 'import pathlib', "pathlib.Path(__file__).is_absolute()"))
    tests.append(('thatlib is_absolute()', 'import thatlib', "thatlib.is_absolute(__file__)"))

    tests.append(('pathlib joinpath()', 'import pathlib', "pathlib.Path(__file__).joinpath('foo')"))
    tests.append(('thatlib joinpath()', 'import thatlib', "thatlib.joinpath([__file__, 'foo'])"))

    tests.append(('pathlib with_suffix()', 'import pathlib', "pathlib.Path(__file__).with_suffix('.foo')"))
    tests.append(('thatlib with_suffix()', 'import thatlib', "thatlib.with_suffix(__file__, '.foo')"))

    tests.append(('pathlib with_stem()', 'import pathlib', "pathlib.Path(__file__).with_stem('foo')"))
    tests.append(('thatlib with_stem()', 'import thatlib', "thatlib.with_stem(__file__, 'foo')"))

    tests.append(('pathlib with_name()', 'import pathlib', "pathlib.Path(__file__).with_name('foo')"))
    tests.append(('thatlib with_name()', 'import thatlib', "thatlib.with_name(__file__, 'foo')"))

    tests.append(('pathlib expanduser()', 'import pathlib', "pathlib.Path('~/foo').expanduser()"))
    tests.append(('thatlib expanduser()', 'import thatlib', "thatlib.expanduser('~/foo')"))

    # tests.append(('pathlib write_bytes()', 'import pathlib', "pathlib.Path('/tmp/foo.txt').write_bytes(b'bar')"))
    # tests.append(('thatlib write_bytes()', 'import thatlib', "thatlib.write_bytes('/tmp/foo.txt', b'bar')"))

    # tests.append(('pathlib read_bytes()', 'import pathlib', "pathlib.Path('/tmp/foo.txt').read_bytes()"))
    # tests.append(('thatlib read_bytes()', 'import thatlib', "thatlib.read_bytes('/tmp/foo.txt')"))

    for test in tests:
        my_result = run_test(test[0], repetitions, test[1], test[2])
        results.append((test[0], my_result[-1]))

    if output_file:
        with open(output_file, 'w') as csvfile:
            outwriter = csv.writer(csvfile, dialect=csv.excel)
            outwriter.writerow(('library', 'time'))
            for result in results:
                outwriter.writerow(result)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Benchmarks for path libs")
    parser.add_argument('--repetitions', metavar='c', type=int, default=10_000, help="Repetitions")
    args = vars(parser.parse_args())
    assert args.get('repetitions') > 100, "Repetitions must be > 100."
    print(args)
    run_all_benchmarks(**args)
