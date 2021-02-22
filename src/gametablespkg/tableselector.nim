import polydicepkg/dice
import tables, streams, strutils

proc stripIndex(line: string): string =
    substr(line, find(line, ",")+1)

proc isSelected(line: string, d:int): bool =
    let index = substr(line, 0, find(line, ",")-1)
    let lowHigh = if index.contains("-"): index.split("-") else: @[index,index]
    d >= parseInt(lowHigh[0]) and d <= parseInt(lowHigh[1])

proc extractHeader(headerLine: string): seq[string] =
    headerLine.split(",")

proc readHeaders*(table: string): seq[string] =
    ## Reads the header line of the table and returns the headings (without the dice descriptor column).
    let strm = newStringStream(table)
    let headers = extractHeader(strm.readLine())
    strm.close()
    return headers[1..headers.len-1]

proc select(stream: StringStream, rolled: int): string =
    var selectedLine = "?";

    for line in lines(stream):
        if (not isEmptyOrWhitespace(line)) and isSelected(line, rolled):
            selectedLine = stripIndex(line)
            break

    return selectedLine

proc selectRowLine*(table: string): string =
    ## Selects a random line from the table based on the configured table dice.
    ## The line index information column is stripped before the line is returned.
    let strm = newStringStream(table)
    let headers = extractHeader(strm.readLine())
    let diceDefn = headers[0]
    let rolled = roll(diceDefn)

    let selectedLine = select(strm, rolled.value)

    strm.close()
    return selectedLine

proc selectRowValues*(table: string): seq[string] =
    ## Selects a random line from the table based on the configured table dice.
    ## The line index information column is stripped before the values are returned.
    let selectedLine = selectRowLine(table)
    selectedLine.split(",")

proc selectRowLineByIndex*(table: string, rolled: int): string =
    ## Selects the line matching the specified die roll from the table.
    ## The line index information column is stripped before the line is returned.
    let strm = newStringStream(table)
    discard strm.readLine()

    let selectedLine = select(strm, rolled)

    strm.close()
    return selectedLine

proc selectRowValuesByIndex*(table: string, rolled: int): seq[string] =
    selectRowLineByIndex(table, rolled).split(",")