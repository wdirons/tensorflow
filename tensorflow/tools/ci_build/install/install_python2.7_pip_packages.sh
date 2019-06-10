#!/usr/bin/env bash
# Copyright 2015 The TensorFlow Authors. All Rights Reserved.
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

set -e

# We don't apt-get install so that we can install a newer version of pip.
# Only needed for Ubuntu 14.04 and 16.04; not needed for 18.04 and Debian 8,9?
# Run easy_install before easy_install3, so that the default pip points to pip2,
# to match the default python version of 2.7.
easy_install -U pip==9.0.3

# Install pip packages from whl files to avoid the time-consuming process of
# building from source.

# Pin wheel==0.31.1 to work around issue
# https://github.com/pypa/auditwheel/issues/102
pip2 install wheel==0.31.1

# Install last working version of setuptools. This must happen before we install
# absl-py, which uses install_requires notation introduced in setuptools 20.5.
pip2 install --upgrade setuptools==39.1.0

# numpy needs to be installed from source to fix segfaults. See:
# https://github.com/tensorflow/tensorflow/issues/6968
# This workaround isn't needed for Ubuntu 16.04 or later.
if $(cat /etc/*-release | grep -q 14.04); then
  pip2 install --no-binary=:all: --upgrade numpy==1.14.5
else
  pip2 install --upgrade numpy==1.14.5
fi

pip2 install mock
pip2 install cython
pip2 install enum34
pip2 install future

pip2 install keras_applications==1.0.6 --no-deps
pip2 install keras_preprocessing==1.0.5 --no-deps
