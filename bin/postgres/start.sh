#!/bin/bash 

# Copyright 2016 Crunchy Data Solutions, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

source /opt/cpm/bin/setenv.sh
source check-for-secrets.sh

if [ ! -v PG_MODE ]; then
	echo "PG_MODE env var is not set, aborting"
	exit 1
fi
if [ ! -v PG_MASTER_USER ]; then
	echo "PG_MASTER_USER env var is not set, aborting"
	exit 1
fi
if [ ! -v PG_MASTER_PASSWORD ]; then
	echo "PG_MASTER_PASSWORD env var is not set, aborting"
	exit 1
fi
if [ ! -v PG_USER ]; then
	echo "PG_USER env var is not set, aborting"
	exit 1
fi
if [ ! -v PG_PASSWORD ]; then
	echo "PG_PASSWORD env var is not set, aborting"
	exit 1
fi
if [ ! -v PG_DATABASE ]; then
	echo "PG_DATABASE env var is not set, aborting"
	exit 1
fi
if [ ! -v PG_ROOT_PASSWORD ]; then
	echo "PG_ROOT_PASSWORD env var is not set, aborting"
	exit 1
fi

export PG_MODE=$PG_MODE
export PG_MASTER_HOST=$PG_MASTER_HOST
export PG_MASTER_PORT=$PG_MASTER_PORT
export PG_MASTER_USER=$PG_MASTER_USER
export PG_MASTER_PASSWORD=$PG_MASTER_PASSWORD
export PG_USER=$PG_USER
export PG_PASSWORD=$PG_PASSWORD
export PG_DATABASE=$PG_DATABASE
export PG_ROOT_PASSWORD=$PG_ROOT_PASSWORD


mkdir -p /pgdata/$HOSTNAME
chmod 0700 /pgdata/$HOSTNAME

if [[ -v ARCHIVE_MODE ]]; then
	if [ $ARCHIVE_MODE == "on" ]; then
		mkdir -p /pgwal/$HOSTNAME
		chmod 0700 /pgwal/$HOSTNAME
		echo "creating wal directory at " /pgwal/$HOSTNAME
	fi
fi

start-pg-wrapper.sh 

#while true; do
#	echo "sleeping "
#	sleep 1000
#done
