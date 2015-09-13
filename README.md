#footballgm-roster-tool

Quick attempt at a tool to parse the Madden 16 roster CSV into a format for FootballGM http://football.zengm.com

This thing is a quick hack to get some data together. It works, but don't expect it to be pretty inside.

---

## Making manual player changes

The output roster/json file is based on the `csv/players_updated.csv`. If you want to change something in the roster file, the best way to do it is to modify `players_updated.csv` and run the roster builder again - rather than directly modifying the json file.

## Roster Builder

This will generate a new 2015-2016 roster file in the `/roster` directory.

`ruby roster_builder.rb`

To generate a new 

## CSV File Updater

You should not need to run this - as the most recent `csv/players_updated.csv` is here in the repo.

This will scrape multiple sources for player information (_age, birthplace, and photo_) as well as the latest player contract information. This process can take some time and due to the web scraping, you are responsible for using common sense. (_do not run it repeatedly and/or non-stop or you may get your IP blocked by the websites the script is hitting_)

To execute, run `ruby file_updater.rb` and wait a while...

_Note that this will generate a new file or append to `csv/players_updated_new.csv` and currently has no logic to 'resume' processing if it crashes or is canceled._

## Util

The `util.rb` file is a class that contains a couple helper methods that are currently run from IRB to do some file cleanup and fixes.

### Player Image Fix

```
irb
require './util'
Util.fix_player_images
```

---

## What is this again?

See more information here: https://www.reddit.com/r/ZenGMFootball/comments/3ki8y9/nfl_roster_json_generator_any_interest/

