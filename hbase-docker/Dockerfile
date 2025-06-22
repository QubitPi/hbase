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
FROM jack20191124/hadoop

LABEL maintainer="Jiaqi (Jack) Liu"
LABEL maintainer-email="jack20220723@gmail.com"

ARG HBASE_VERSION=1.2.1

# Download HBase
RUN wget http://archive.apache.org/dist/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz
RUN tar -xvzf hbase-$HBASE_VERSION-bin.tar.gz
RUN rm hbase-$HBASE_VERSION-bin.tar.gz

# Rename "hbase-<version>" to "hbase"
RUN mv hbase-$HBASE_VERSION hbase

# Configure HBase env variables
ENV HBASE_HOME /hbase

# Prepare HBase config files
ADD hbase-site.xml $HBASE_HOME/conf/hbase-site.xml
RUN echo "export JAVA_HOME=${JAVA_HOME}" >> $HBASE_HOME/conf/hbase-env.sh

ADD hbase-init.sh /etc/hbase-init.sh
RUN chown root:root /etc/hbase-init.sh
RUN chmod 700 /etc/hbase-init.sh
ENV INIT /etc/hbase-init.sh
