#!/bin/bash

# F Claude :: CSCI 3308 :: Lab 3 :: 02/05/20
# Text manipulation script

# Main menu
user_selection()
{
  while true;
  do
    clear && echo -e "---------- CSCI-3308: LAB 3 BASH SCRIPT ----------"
    echo "Loaded text file: $FILENAME"
    echo -e  " 1) Count lines \n 2) Count words \n 3) Add text \n 4) Copy and exit \n 5) Quit"
    read -p "Make a selection: " SELECTION

    case $SELECTION in

      1 )
        count_lines;;

      2 )
        count_words;;

      3 )
        add_text;;

      4 )
        copy_and_exit;;

      5 )
        echo -e "\nGood bye. Please give me a good grade \n:)\n"
        exit 0;
        ;;

      * )
        echo -e "\n[$CROSSMARK] Error \n$SELECTION is not a valid entry\n"
        read -n 1 -s -r -p "Press any key to continue..."
        ;;

    esac
  done
}


# This function will count the number of lines in the file
# (using sed or awk or grep). Use echo to display the result/number
# of lines to the screen
# (e.g. “the number of lines in the file is…”).
count_lines()
{
  # Clear screen and display header
  clear && echo "---------- COUNT LINES ----------"
  echo "Loaded text file: $FILENAME"
  echo -e "Program(s) used: clear, echo, sed, read \n"

  # Use sed to count the number of lines
  NUMLINES=$(sed -n \$= "$FILENAME")

  # Echo NUMLINES
  echo -e "[$CHECKMARK] The text file contains $NUMLINES lines \n"

  # Return to main menu and clear screen on exit
  read -n 1 -s -r -p "Press any key to continue..." && clear
}


# This function will search for all instances of the words:
# Lorem, model, Ipsum, will within the sample_text.txt
# (using sed or awk or grep). Use echo to display the lines
# from the file where the words are found.
count_words()
{
  # Clear screen and display header
  clear && echo "---------- COUNT WORDS ----------"
  echo "Loaded text file: $FILENAME"
  echo -e "Program(s) used: clear, echo, cat, grep, read, piping \n"
  echo "Displaying instances of the following words:"
  echo -e "[$CHECKMARK] Lorem \n[$CHECKMARK] model \n[$CHECKMARK] Ipsum \n[$CHECKMARK] will \n"

  # Use grep to search text (Piping cat output to grep)
  NUMWORDS=$(cat "$FILENAME" | grep 'Lorem\|model\|Ipsum\|will')

  # Echo NUMWORDS
  echo -e "$NUMWORDS\n"

  # Return to main menu and clear screen on exit
  read -n 1 -s -r -p "Press any key to continue..." && clear
}

# This function will prompt the user to enter a sentence and
# then the script should append the sentence: I learnt about
# Lorem Ipsum typesetter!! onto the original text file sample_text.txt.
# Do not create a new text file during this process.
# The aforementioned sentence should be appended to
# the original sample_text.txt file.
add_text()
{
  # Clear screen and display header
  clear && echo "---------- ADD TEXT ----------"
  echo "Loaded text file: $FILENAME"
  echo -e "Program(s) used: clear, echo, read, piping \n"

  # While empty
  while [[ -z "$APPEND" ]];
  do
    # Request user input
    read -p "Please enter text you want to append to the end of the file: " APPEND

    # Check if variable is empty
    if [[ -z "$APPEND" ]]
    then
      # Prompt again
      echo -e "\n[$CROSSMARK] Error \nYou did not enter text, please try again\n"
    else
      # Append user input to end of text file
      echo -e "\n$APPEND" >> "$FILENAME" && echo ""

      # Return to main menu and clear screen on exit
      echo -e "[$CHECKMARK] Text appended successfully \n"
      read -n 1 -s -r -p "Press any key to continue..." && clear
    fi
  done
}

# This function should create a new folder named
# solution within the same directory as the
# TestFile.sh script. Next, this function should
# use the cp command and copy the original text
# file (sample_text.txt) to the solution directory.
copy_and_exit()
{
  # Clear screen and display header
  clear && echo "---------- COPY AND EXIT ----------"
  echo "Loaded text file: $FILENAME"
  echo -e "Program(s) used: mkdir, cp, ls \n"
  echo -e "Program(s) used: clear, echo, mkdir, cp, read, piping \n"

  # Create solution dir if it doesn't exist
  echo "[$CHECKMARK] Checking if solution directory exists"
  if [[ ! -d "$WORKINGDIR/solution" ]]
  then
    echo "[$CROSSMARK] Directory does not exist!"
    echo "[$CHECKMARK] Creating directory"
    mkdir -p "$WORKINGDIR/solution"
    echo "[$CHECKMARK] Solution directory exists"
  fi

  # Copy text file to solution dir (no clobber)
  echo "[$CHECKMARK] Copying text file to solution directory"
  cp -n "$WORKINGDIR/$FILENAME" "$WORKINGDIR/solution"

  # Check if copy complete
  if [[ -f "$WORKINGDIR/solution/$FILENAME" ]]
  then
    echo -e "[$CHECKMARK] Copy complete \n"
    # Return to main menu and clear screen on exit
    read -n 1 -s -r -p "Press any key to exit..." && clear
    echo -e "\nGood bye. Please give me a good grade \n:)\n"
    exit 0;
  fi
}

### Main
WORKINGDIR="$(pwd)"
FILENAME="$1"
CROSSMARK="$(printf '\u274c' | iconv -f UTF-8)" # Piping to ensure UTF-8
CHECKMARK="$(printf '\342\234\224\n' | iconv -f UTF-8)" # Piping to ensure UTF-8

# Checks number of arguments passed
if [[ "$#" -lt 1 ]];
then
  echo -e "[$CROSSMARK] Error \nYou must pass a filename at execution"
  echo "$0 <text_file.txt>"
  exit 1;
elif [[ "$#" -gt 1 ]];
then
  echo -e "[$CROSSMARK] Error \nYou are passing too many arguments"
  echo "$0 <text_file.txt>"
elif [[ "$#" -eq 1 ]];
then
  # Checks if textfile exists
  if [[ ! -f "$FILENAME" ]]
  then
    echo -e "[$CROSSMARK] Error \nThe file <$FILENAME> was not found in the working directory"
    exit 1;
  else
    # Execute menu function
    user_selection
  fi
fi

exit 0;
