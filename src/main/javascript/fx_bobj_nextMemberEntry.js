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
 * Retrieves next BOBJ group member, if any, during initial load.
 * @see fx_bobj_MemberReader.read
 * @returns {com.sap.idm.ic.DSEEntry?} - IDM entry or null if no more members
 * @requires fx_bobj_MemberReader
 */
function fx_bobj_nextMemberEntry()
{
    return fx_bobj_MemberReader.read();
}
