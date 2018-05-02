#!/bin/bash

# config ------
SCREEN_NAME="your_screen_name"
LOGDIR="./log"

# mk logdir ------
if [ ! -e $LOGDIR ]; then
	mkdir -p $LOGDIR
fi

# calculate periods ------
## get the "crated_at" value from profile
CREATED=`twurl /1.1/users/show.json?screen_name=$SCREEN_NAME | jq .created_at | sed -e 's/\"//g'`
## get date info
set -- $CREATED
YEAR=$6
MON=$2
MON=`echo $MON | sed -e 's/Jan/1/' \
-e 's/Feb/2/' \
-e 's/Mar/3/' \
-e 's/Apr/4/' \
-e 's/May/5/' \
-e 's/Jun/6/' \
-e 's/Jul/7/' \
-e 's/Aug/8/' \
-e 's/Sep/9/' \
-e 's/Oct/10/' \
-e 's/Nov/11/' \
-e 's/Dec/12/'`
DAY=$3
TIME=$4

HOUR=`echo $TIME | cut -d":" -f1`
MIN=`echo $TIME | cut -d":" -f2`
SEC=`echo $TIME | cut -d":" -f3`

## calculate period of days
PERIOD=`perl -e ";use Time::Local 'timelocal'; print int( (time-timelocal($SEC,$MIN,$HOUR,$DAY,$MON,$YEAR))/86400);"`

# create description ------
DESCRIPTION="have nyaned for $PERIOD days."

# post ------
twurl -X POST /1.1/account/update_profile.json -d "description=$DESCRIPTION" 1>/dev/null 2>> $LOGDIR/error_nyan.txt

