#!/bin/sh

#================================================================
# HEADER
#================================================================
#  DESCRIPTION
#    This is a helper script for fb-rotate, which searches for the Display ID
#    automatically, and rotates the first display, that is not Main.
#    fb-rotate written by Eric Nitardy: https://github.com/CdLbB/fb-rotate
#
#  OPTIONS
#    -r [desgrees]                  Rotate secondary display by X degrees.
#                                   Use 0 to rotate to default landscape
#                                   orientation.
#    -h, --help                     Print this help
#    -v, --version                  Print script information
#
#  EXAMPLES
#    ${SCRIPT_NAME} -r 90
#
#================================================================
#  IMPLEMENTATION
#    version                        0.4
#    author                         Alex Bard
#    copyright                      Copyright (c) Alex Bard
#    license                        MIT
#
#================================================================
#  HISTORY
#     2018/09/16 : Script created.
#
#================================================================
# END_OF_HEADER
#================================================================


# =============================================================== #
# GLOBAL VARIABLES 
# =============================================================== #

# Saves script name to be used throughout the script.
SCRIPT_NAME="$(basename ${0})"

# Version
VERSION=0.4

# Default rotation (none)
ROTATION=0

# DisplayID, set by get_monitor_id function
DISPLAY_ID=0

# Flag for secondary display.
FOUND=false;

# get location of fb-rotate
# using -maxdepth reduces execution time.
FB=$(find ~ -maxdepth 3 -type f -name 'fb-rotate')

# First line argument from command prompt saves the flag
FLAG=$1



# =============================================================== #
# ECHO HELPER VARIABLES
# =============================================================== #
FB_ROTATE_GIT="https://github.com/CdLbB/fb-rotate"

SCRIPT_BANNER="
  ########   #######  ########    ###    ######## ########      ######  ##     ## 
  ##     ## ##     ##    ##      ## ##      ##    ##           ##    ## ##     ## 
  ##     ## ##     ##    ##     ##   ##     ##    ##           ##       ##     ## 
  ########  ##     ##    ##    ##     ##    ##    ######        ######  ######### 
  ##   ##   ##     ##    ##    #########    ##    ##                 ## ##     ## 
  ##    ##  ##     ##    ##    ##     ##    ##    ##       ### ##    ## ##     ## 
  ##     ##  #######     ##    ##     ##    ##    ######## ###  ######  ##     ## 
"

SCRIPT_DESCRIPTION="
  DESCRIPTION
    This is a helper script for fb-rotate, which searches for the Display ID
    automatically, and rotates the secondary display. The reason I wrote this
    script is because I was getting annoyed that I had to search for monitor ID
    everytime I disconnected my laptop. 

    fb-rotate is required for this script to work. Please download and compile
    from github link below.

    Credit to original author:
    fb-rotate written by Eric Nitardy: ${FB_ROTATE_GIT}
"

SCRIPT_USAGE="
  USAGE: 
    ${SCRIPT_NAME} [-r n] [-h] [-v] -- script to rotate secondary display.
"

SCRIPT_OPTIONS="
  OPTIONS
    -r [desgrees]                     Rotate secondary display by X degrees.
                                      Use 0 to rotate to default landscape
                                      orientation.
    -h, --help                        Print help documentation
    -v, --version                     Print script version and description
"

SCRIPT_EXAMPLE="
  EXAMPLE
    ${SCRIPT_NAME} -r 90\n
"


# =============================================================== #
# Automatically find the display that is not main, 
# and rotate by X degrees.
# =============================================================== #
get_monitor_id(){
  IFS=$'\n'
  arr=($($FB -l))
  unset IFS

  for i in "${arr[@]}"
  do
    # getting ID of non-main display
    # if there are multiple displays, this will rotate
    # first non-main display
    if [[ $i = *0x* && $i != *"[main display]"* ]]
    then
      # line with tab delimeters submitted, need just ID
      DISPLAY_ID=`awk '{print $1}' <<< $i`
      FOUND=true;
      rotate
    fi
  done

  if [[ $FOUND = false ]]
  then
    echo "ERROR: No secondary display was found."
    exit 1
  fi
}


# =============================================================== #
# Does the needful.
# =============================================================== #
rotate(){
  $FB -d $DISPLAY_ID -r $ROTATION
  exit 1
}


# =============================================================== #
# Display Usage Information
# =============================================================== #
display_help(){
  usage="
  ${SCRIPT_BANNER}
  ${SCRIPT_USAGE}
  ${SCRIPT_DESCRIPTION}
  ${SCRIPT_OPTIONS}
  ${SCRIPT_EXAMPLE}
  "
  
  echo "$usage" >&2
  exit 1
}

# =============================================================== #
# Main 
# =============================================================== #
if [[ -f $FB ]] 
then
  while getopts "h v :r:" opt; do
  case $opt in
    r)
      ROTATION=$OPTARG

      if [[ $ROTATION = 0 ]]; then 
        echo "Rotating to standard landscape orientation."
      else
        echo "Rotating $OPTARG degrees."
      fi

      get_monitor_id
      ;;
    h)
      display_help
      ;;
    v)
      echo "${SCRIPT_NAME} VERSION ${VERSION}" >&2
      exit 1
      ;;
    \?)
      echo " ${SCRIPT_USAGE} ${SCRIPT_OPTIONS} ${SCRIPT_EXAMPLE}" >&2
      exit 1
      ;;
  esac
  done  

  display_help 
else
  echo "ERROR: fb-rotate cannot be found."
  echo "Please download and compile fb-rotate @ ${FB_ROTATE_GIT}"
  exit 1
fi
