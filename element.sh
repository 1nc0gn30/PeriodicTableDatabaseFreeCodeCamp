#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    QUERY_RESULT=$($PSQL "SELECT elements.atomic_number, elements.name, elements.symbol, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius FROM elements JOIN properties ON elements.atomic_number=properties.atomic_number JOIN types ON properties.type_id=types.type_id WHERE elements.atomic_number=$1")
  else
    QUERY_RESULT=$($PSQL "SELECT elements.atomic_number, elements.name, elements.symbol, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius FROM elements JOIN properties ON elements.atomic_number=properties.atomic_number JOIN types ON properties.type_id=types.type_id WHERE elements.symbol='$1' OR elements.name='$1'")
  fi

  if [[ -z $QUERY_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$QUERY_RESULT" | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi
fi
# Fixing a minor issue in the script
# Refactor the script for efficiency
# Adding test cases for the script
