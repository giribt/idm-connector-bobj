// Copyright 2016 Foxysoft GmbH
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * Sleep a given number of milliseconds
 * @param {string} iv_millis - number of milliseconds
 * @return {string} - iv_millis
 * @since 1.0.0
 */
function fx_sleep(iv_millis)
{
    uSleep(iv_millis);
    return iv_millis;
}
