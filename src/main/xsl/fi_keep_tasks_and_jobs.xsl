<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright 2016 Foxysoft GmbH

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

<!-- Filter to keep only IDM/TASKS, IDM/JOBS and IDM/GROUP elements -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <!-- Copy all attributes and nodes -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- Cancel copying children of IDM unless its TASKS or JOBS -->
  <xsl:template match="IDM/*[not(name()='TASKS' or name()='JOBS' or name()='GROUPS')]">
    <xsl:message>Stripping <xsl:value-of select="name()"/></xsl:message>
  </xsl:template>
</xsl:stylesheet>
