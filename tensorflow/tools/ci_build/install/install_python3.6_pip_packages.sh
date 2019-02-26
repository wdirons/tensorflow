#!/usr/bin/env bash
# Copyright 2016 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================
# Install packages required by Python3.6 build

# TODO(amitpatankar): Remove this file once we upgrade to ubuntu:16.04
# docker images for Python 3.6 builds.

# LINT.IfChange

# Install python dep
apt-get install python-dev
# Install bz2 dep
apt-get install libbz2-dev
# Install curses dep
apt-get install libncurses5 libncurses5-dev
apt-get install libncursesw5 libncursesw5-dev
# Install readline dep
apt-get install libreadline6 libreadline6-dev
# Install sqlite3 dependencies
apt-get install libsqlite3-dev

set -e

# Install Python 3.6 and dev library
wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tar.xz
tar xvf Python-3.6.1.tar.xz
cd Python-3.6.1

./configure
make altinstall

pip3.6 install --upgrade pip

pip3.6 install wheel==0.31.1
pip3.6 install --upgrade setuptools==39.1.0

set -e

# Install numpy, scipy and scikit-learn required by the builds

# numpy needs to be installed from source to fix segfaults. See:
# https://github.com/tensorflow/tensorflow/issues/6968
# This workaround isn't needed for Ubuntu 16.04 or later.
pip3.6 install --no-binary=:all: --upgrade numpy==1.14.5

pip3.6 install cython
pip3.6 install keras_applications==1.0.6
pip3.6 install keras_preprocessing==1.0.5
