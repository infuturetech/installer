#!/bin/bash

cd output/deploy
chmod +x ./deploy_sql.sh
./deploy_sql.sh
chmod +x ./deploy_sql_mcs.sh
./deploy_sql_mcs.sh
chmod +x ./deploy_sql_vis.sh
./deploy_sql_vis.sh