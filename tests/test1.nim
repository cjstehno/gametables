import unittest
import gametablespkg/tableselector
import streams

const table = """d6,description,value
1-2,first thing,10
3-4,second thing,20
5-6,third thing,30
"""

const otherTable = """d4,description,value
1-2,first one,10
3,second one,20
4-5,third one,30
6,fourth one,40
"""

suite "Testing table row selection":
    test "Extracting headers":
        check readHeaders(table) == @["description","value"]

    test "Selecting specific line":
        check selectRowLineByIndex(table, 1) == "first thing,10"
        check selectRowLineByIndex(table, 2) == "first thing,10"
        check selectRowLineByIndex(table, 3) == "second thing,20"
        check selectRowLineByIndex(table, 4) == "second thing,20"
        check selectRowLineByIndex(table, 5) == "third thing,30"
        check selectRowLineByIndex(table, 6) == "third thing,30"

    test "Selecting specific line (other table)":
        check selectRowLineByIndex(otherTable, 1) == "first one,10"
        check selectRowLineByIndex(otherTable, 2) == "first one,10"
        check selectRowLineByIndex(otherTable, 3) == "second one,20"
        check selectRowLineByIndex(otherTable, 4) == "third one,30"
        check selectRowLineByIndex(otherTable, 5) == "third one,30"
        check selectRowLineByIndex(otherTable, 6) == "fourth one,40"

    test "Selecting specific line values":
        check selectRowValuesByIndex(table, 1) == @["first thing","10"]
        check selectRowValuesByIndex(table, 2) == @["first thing","10"]
        check selectRowValuesByIndex(table, 3) == @["second thing","20"]
        check selectRowValuesByIndex(table, 4) == @["second thing","20"]
        check selectRowValuesByIndex(table, 5) == @["third thing","30"]
        check selectRowValuesByIndex(table, 6) == @["third thing","30"]