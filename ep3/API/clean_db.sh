#!/bin/bash

function run() {
    db=$1
    clean=$2
    echo "Running $clean on database $db"
    docker exec mac0350_ep3_postgres psql $db postgres -c "$(cat $clean)"
}

run "access"             "../MODULE_ACCESS_CLEAN.sql"
run "curriculum"         "../MODULE_CURRICULUM_CLEAN.sql"
run "people"             "../MODULE_PEOPLE_CLEAN.sql"
run "access_people"      "../INTER_MOD_ACC_PEO_CLEAN.sql"
run "people_curriculum"  "../INTER_MOD_PEO_CUR_CLEAN.sql"