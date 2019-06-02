#!/bin/bash
psql -d template1 -c 'drop database jef;'
psql -d template1 -c 'create database jef;'

psql -d jef -f EP1_9298207_DDL_FIXED.sql
psql -d jef -f DML.sql
psql -d jef -f DML_CLEAN.sql
psql -d jef -f DML.sql
psql -d jef -f DML_CREATE_GROUP.sql
psql -d jef -f DML_RETRIEVAL_GROUP.sql
psql -d jef -f DML_UPDATE_GROUP.sql

psql -d jef -f test-function-calls.sql
