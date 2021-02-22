import gametablespkg/tableselector
import docopt, streams, strutils

let doc = """
A tool for randomly selecting an entry from a provided table file.
Usage:
    gametables [-r=<roll> | --rolled=<roll>] <table_file>
    gametables (-h | --help)
    gametables --version

Options:
    -h --help                   Show this screen.
    --version                   Show version.
    -r=<roll> --rolled=<roll>   Specific roll value to be used (defaults to random)
"""

let args = docopt(doc, version = "Tables v0.1.0")

let table = readFile($args["<table_file>"])

if args["--rolled"]:
    let roll = parseInt($args["--rolled"])
    echo selectRowLineByIndex(table, roll)

else:
    echo selectRowLine(table)