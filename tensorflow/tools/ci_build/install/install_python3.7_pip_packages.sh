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
# Install packages required by Python3.7 build
set -e

# Install Python 3.7 and dev library
wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tar.xz
tar xvf Python-3.7.2.tar.xz
cd Python-3.7.2

./configure
make altinstall

pip3.7 install --upgrade pip

# Install last working version of setuptools. This must happen before we install
# absl-py, which uses install_requires notation introduced in setuptools 20.5.
pip3.7 install wheel==0.31.1
pip3.7 install --upgrade setuptools==39.1.0

set -e

# numpy needs to be installed from source to fix segfaults. See:
# https://github.com/tensorflow/tensorflow/issues/6968
# This workaround isn't needed for Ubuntu 16.04 or later.
pip3.7 install --no-binary=:all: --upgrade numpy==1.14.5

pip3.7 install keras_applications==1.0.6
pip3.7 install keras_preprocessing==1.0.5
