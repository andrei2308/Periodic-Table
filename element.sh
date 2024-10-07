#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit 0;
fi
if [[ $1 =~ ^[0-9]+$ ]]; then
  ARGUMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
  ARGUMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
  ARGUMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")
  ARGUMENT_MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
  ARGUMENT_BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")
  ARGUMENT_TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$1")
  echo "The element with atomic number $1 is $ARGUMENT_NAME ($ARGUMENT_SYMBOL). It's a $ARGUMENT_TYPE, with a mass of $ARGUMENT_MASS amu. $ARGUMENT_NAME has a melting point of $ARGUMENT_MELTING celsius and a boiling point of $ARGUMENT_BOILING celsius." | sed -E 's/\(\s+/(/g; s/ +/ /g'



  

elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]; 
then
  GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")  
  if [[ -z $GET_ATOMIC_NUMBER ]]; then
    echo "I could not find that element in the database."
    exit 0
  fi
  ARGUMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$GET_ATOMIC_NUMBER")
  ARGUMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$GET_ATOMIC_NUMBER")
  ARGUMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$GET_ATOMIC_NUMBER")
  ARGUMENT_MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$GET_ATOMIC_NUMBER")
  ARGUMENT_BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$GET_ATOMIC_NUMBER")
  ARGUMENT_TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$GET_ATOMIC_NUMBER")
    echo "The element with atomic number $GET_ATOMIC_NUMBER is $ARGUMENT_NAME ($ARGUMENT_SYMBOL). It's a $ARGUMENT_TYPE, with a mass of $ARGUMENT_MASS amu. $ARGUMENT_NAME has a melting point of $ARGUMENT_MELTING celsius and a boiling point of $ARGUMENT_BOILING celsius." |  sed -E 's/\(\s+/(/g; s/ +/ /g'

elif [[ $1 =~ ^[a-zA-Z\s]+$ ]]
then
  GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")  
  if [[ -z $GET_ATOMIC_NUMBER ]]
  then
  echo I could not find that element in the database.
  else
  ARGUMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$GET_ATOMIC_NUMBER")
  ARGUMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$GET_ATOMIC_NUMBER")
  ARGUMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$GET_ATOMIC_NUMBER")
  ARGUMENT_MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$GET_ATOMIC_NUMBER")
  ARGUMENT_BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$GET_ATOMIC_NUMBER")
  ARGUMENT_TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$GET_ATOMIC_NUMBER")
  echo "The element with atomic number $GET_ATOMIC_NUMBER is $ARGUMENT_NAME ($ARGUMENT_SYMBOL). It's a $ARGUMENT_TYPE, with a mass of $ARGUMENT_MASS amu. $ARGUMENT_NAME has a melting point of $ARGUMENT_MELTING celsius and a boiling point of $ARGUMENT_BOILING celsius." | sed -E 's/\(\s+/(/g; s/ +/ /g'


fi
else
  echo I could not find that element in the database.
fi