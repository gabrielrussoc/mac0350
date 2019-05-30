psql -d template1 -c 'drop database jef;'
psql -d template1 -c 'create database jef;'

psql -d jef -f EP1_9298207_DDL_FIXED.sql
