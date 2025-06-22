#!/usr/bin/env bash

# Copyright 2022 Jiaqi Liu. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# run parent(Hadoop) init
sh /etc/init.sh

cd $HBASE_HOME
bin/start-hbase.sh
bin/hbase-daemon.sh start rest

if [[ $1 == "-d" ]]; then
    # just keep container running by hanging the shell
    while true; do sleep 1000 ; done
fi

if [[ $1 == "-bash" ]]; then
    # enter container's interactive shell
    /bin/bash
fi
