<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright 2017 Foxysoft GmbH

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

<!-- Post-process package exports from SAP(R) IDM Developer Studio -->
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
  <!-- Add license comment -->
  <xsl:template match="/">
    <xsl:message>Adding license</xsl:message>
    <xsl:comment>
Copyright 2017 Foxysoft GmbH

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</xsl:comment>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:template>
  <!-- Replace username in CHANGED_BY or MCMODIFIEDBYUSERNAME text content -->
  <xsl:template match="CHANGED_BY/text()|MCMODIFIEDBYUSERNAME/text()">
    <xsl:message>
      <xsl:text>Replacing </xsl:text>
      <xsl:value-of select="parent::node()"/>
    </xsl:message>
    <xsl:text>FOXYSOFT</xsl:text>
  </xsl:template>
  <!-- Cancel copying package script definitions tags -->
  <xsl:template match="/IDM/PACKAGES/PACKAGE/PACKAGE_SCRIPTS/SCRIPT">
    <xsl:message>
      <xsl:text>Removing </xsl:text>
      <xsl:value-of select="name()"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="MCSCRIPTNAME"/>
    </xsl:message>
  </xsl:template>
  <!-- Cancel copying package script public references tags -->
  <xsl:template match="/IDM/PACKAGES/PACKAGE/PUBLIC_REFERENCES/PUBLIC_REFERENCE[MCTYPE='12']">
    <xsl:message>
      <xsl:text>Removing </xsl:text>
      <xsl:value-of select="name()"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="MCNAME"/>
    </xsl:message>
  </xsl:template>
  <!-- Cancel copying any values of package variables. -->
  <!-- This is specifically important for FX_TRACE, which is often 1 -->
  <!-- in Foxysoft DEV systems, but shouldn't be in customer systems -->
  <xsl:template match="/IDM/PACKAGES/PACKAGE/PACKAGE_VARS/VARIABLE/VARVALUE">
    <xsl:message>
      <xsl:text>Removing VARVALUE </xsl:text>
      <xsl:value-of select="preceding-sibling::VARNAME"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="text()"/>
    </xsl:message>
  </xsl:template>
</xsl:stylesheet>