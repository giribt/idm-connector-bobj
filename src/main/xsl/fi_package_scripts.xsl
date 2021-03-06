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

<!-- Add all JavaScript files from src/javascript directory -->
<!-- to SAP(R) IDM package export as public package scripts -->
<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fx="http://foxysoft.de/idm"
                >
  <!-- These are global stylesheet parameters passed by pom.xml -->
  <xsl:param
      name="gp_project_version"
      as="xs:string"
      />
  <xsl:param
      name="gp_include_xml_test_content"
      as="xs:boolean"
      />
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- BEGIN: Public References (make package scripts public) -->
  <xsl:template match="/IDM/PACKAGES/PACKAGE/PUBLIC_REFERENCES">
    <xsl:copy>
      <!-- Copy any pre-existing PUBLIC_REFERENCES to output -->
      <xsl:apply-templates select="@*|node()"/>
      <xsl:for-each select="uri-collection('../javascript/?select=*.js')">
        <xsl:sort
            select='.'
            data-type='text'
            case-order='lower-first'/>
        <xsl:call-template name="get_public_reference">
          <xsl:with-param
              name="iv_script_name"
              select="substring-before(tokenize(.,'/')[last()],'.')"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>
  <xsl:template name="get_public_reference">
    <xsl:param name="iv_script_name"/>
    <PUBLIC_REFERENCE>
      <MCNAME><xsl:value-of select="$iv_script_name"/></MCNAME>
      <MCPACKAGEID>de.foxysoft.bobj</MCPACKAGEID>
      <MCREFERENCE><xsl:value-of select="$iv_script_name"/></MCREFERENCE>
      <MCTYPE>12</MCTYPE>
    </PUBLIC_REFERENCE>
  </xsl:template>
  <!-- END: Public References -->
  <!-- BEGIN: Package script definitions -->
  <xsl:template match="/IDM/PACKAGES/PACKAGE/PACKAGE_SCRIPTS">
    <xsl:copy>
      <xsl:for-each select="uri-collection('../javascript/?select=*.js')">
        <xsl:sort
            select='.'
            data-type='text'
            case-order='lower-first'/>
        <xsl:call-template name="get_package_script">
          <xsl:with-param
              name="iv_script_name"
              select="substring-before(tokenize(.,'/')[last()],'.')"/>
          <xsl:with-param
              name="iv_script_uri"
              select="."/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>
  <xsl:template name="get_package_script">
    <xsl:param name="iv_script_name"/>
    <xsl:param name="iv_script_uri"/>
    <SCRIPT>
      <MCENABLED>1</MCENABLED>
      <MCPACKAGEID>de.foxysoft.bobj</MCPACKAGEID>
      <MCPROTECTED>0</MCPROTECTED>
      <MCSCRIPTDEFINITION>
        <xsl:value-of select="unparsed-text($iv_script_uri)"/>
      </MCSCRIPTDEFINITION>
      <MCSCRIPTLANGUAGE>JScript</MCSCRIPTLANGUAGE>
      <MCSCRIPTNAME><xsl:value-of select="$iv_script_name"/></MCSCRIPTNAME>
      <MCSCRIPTSTATUS>0</MCSCRIPTSTATUS>
    </SCRIPT>
  </xsl:template>
  <!-- END: Package script definitions -->
  <!-- BEGIN: Package description -->
  <xsl:template match="/IDM/PACKAGES/PACKAGE/MCDESCRIPTION/text()">
    <xsl:text>SAP BusinessObjects connector, version: </xsl:text>
    <xsl:value-of select="$gp_project_version"/>
  </xsl:template>
  <!-- END: Package description -->
  <!-- BEGIN: Use project major/minor version as package version -->
  <xsl:template match="/IDM/PACKAGES/PACKAGE/MCMAJORVERSION/text()">
    <!-- Note that . is special in XSLT and XPath and must be escaped. -->
    <xsl:value-of
        select="tokenize($gp_project_version,'\.')[position() = 1]"/>
  </xsl:template>
  <xsl:template match="/IDM/PACKAGES/PACKAGE/MCMINORVERSION/text()">
    <xsl:value-of
        select="tokenize($gp_project_version,'\.')[position() = 2]"/>
  </xsl:template>
  <!-- END: Use project major/minor version as package version -->
  <!-- START: Conditionally include XML test content -->
  <xsl:template match="*[@fx:is-test-content]">
    <xsl:if test="$gp_include_xml_test_content">
      <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>
  <!-- Cancel copying attributes in the fx namespace -->
  <xsl:template match="@fx:*"/>
  <!-- END: Conditionally include XML test content -->
</xsl:stylesheet>
