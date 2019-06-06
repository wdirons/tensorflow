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

# Select bazel version.
BAZEL_VERSION="0.24.1"

set +e
local_bazel_ver=$(bazel version 2>&1 | grep -i label | awk '{print $3}')

if [[ "$local_bazel_ver" == "$BAZEL_VERSION" ]]; then
  exit 0
fi

set -e

# Install bazel.
mkdir -p /bazel
cd /bazel
if [[ ! -f "bazel_bin_ppc64le_$BAZEL_VERSION" ]]; then
  curl -fSsL -O https://oplab9.parqtec.unicamp.br/pub/ppc64el/bazel/ubuntu_14.04/bazel_bin_ppc64le_$BAZEL_VERSION
fi
chmod +x /bazel/bazel_bin_ppc64le_*
mv /bazel/bazel_bin_ppc64le_$BAZEL_VERSION /usr/local/bin/bazel
