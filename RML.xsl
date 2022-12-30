<?xml version="1.0" encoding="UTF-8"?>

<!-- FILE    : RML.xsl
     AUTHOR  : Peter C. Chapin <peter@pchapin.org>
     SUBJECT : XSL stylesheet for converting RML to XHTML.
-->

<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rml="http://www.pchapin.org/XML/RML">

  <xsl:output method="html"/>


  <!-- Handles the overall document. This template is responsible for HTML boilerplate. -->
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-us">

      <!-- Handle the case of a single recipe. -->
      <xsl:if test="rml:recipe">
        <head>
          <title>
            <xsl:value-of select="rml:recipe/@name"/>
          </title>
        </head>
        <body>
          <xsl:apply-templates select="rml:recipe"/>
        </body>
      </xsl:if>

      <!-- Handle the case of a recipe list. -->
      <xsl:if test="rml:recipe-list">
        <head>
          <title>Recipe List</title>
        </head>
        <body>
          <xsl:apply-templates select="rml:recipe-list"/>
        </body>
      </xsl:if>
    </html>
  </xsl:template>


  <!-- Handles the formatting of a list of recipes. -->
  <xsl:template match="rml:recipe-list">
    <xsl:for-each select="rml:recipe">
      <xsl:apply-templates select="."/>
      <hr/>
    </xsl:for-each>
  </xsl:template>


  <!-- Handles the formatting of a single recipe in a list of recipes. -->
  <xsl:template match="rml:recipe">
    <h1>
      <xsl:value-of select="@name"/>
    </h1>
    <xsl:apply-templates select="rml:ingredients"/>
    <xsl:apply-templates select="rml:cooking-instructions"/>
    <xsl:apply-templates select="rml:instructions"/>
    <xsl:apply-templates select="rml:comments"></xsl:apply-templates>
  </xsl:template>


  <!-- Formats an ingredients list. -->
  <xsl:template match="rml:ingredients">
    <h3>Ingredients</h3>
    <ul>
      <xsl:for-each select="rml:ingredient">
        <li>
          <xsl:value-of select="@quantity"/>
          <xsl:text> </xsl:text>
          <xsl:choose>
            <xsl:when test="contains(@units, 'user!')">
              <xsl:value-of select="substring-after(@units, 'user!')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@units"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text> </xsl:text>
          <xsl:value-of select="."/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>


  <!-- Formats the cooking instructions. -->
  <xsl:template match="rml:cooking-instructions">
    <h3>Cooking Instructions</h3>
    <xsl:apply-templates select="rml:summary"/>
    <p>
      <xsl:value-of select="rml:notes"/>
    </p>
  </xsl:template>


  <!-- Formats the cooking summary. -->
  <xsl:template match="rml:summary">
    <p>
      <em>Cook at <xsl:value-of select="@temperature"/><xsl:value-of select="@units"/> for
          <xsl:value-of select="substring(@time, 3, 2)"/> hours, <xsl:value-of
          select="substring(@time, 6, 2)"/> minutes.</em>
    </p>
  </xsl:template>


  <!-- Formats the instructions. -->
  <xsl:template match="rml:instructions">
    <h3>Instructions</h3>
    <ol>
      <xsl:for-each select="rml:step">
        <li>
          <xsl:value-of select="."/>
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template>


  <!-- Formats the comments. -->
  <xsl:template match="rml:comments">
    <h3>Comments</h3>
    <ol>
      <xsl:for-each select="rml:comment">
        <li>
          <xsl:value-of select="."/>
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template>
  
</xsl:stylesheet>
