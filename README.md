#footballgm-roster-tool

Quick attempt at a tool to parse the Madden 16 roster CSV into a format for FootballGM http://football.zengm.com

This thing is a quick hack to get some data together. It works, but don't expect it to be pretty inside.

## To update the player.csv with data from the internet

`ruby file_updater.rb`

## To generate json roster

The output json file is based on the `players_updated.csv`. If you want to change something, the best way to do it is to modify the CSV and run this again - rather than directly modifying the JSON

`ruby roster_builder.rb`
