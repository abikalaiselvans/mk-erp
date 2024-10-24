<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style6 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-WEIGHT: bold; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 8px;}
-->
</style>
</head>

<body  onpaste='return false;'>
<p>

<table width="753" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <th colspan="2" scope="col"><div align="left" class="boldElevenPrint">
      <div align="center"><strong>FORM S</strong><br>
            <span class="style6">Notice of Daily Hours of Work, Rest Interval Weekly Holiday, Etc <br>
              [See sub rule(4) of Rule 18] </span></div>
    </div></th>
  </tr>
  <tr>
    <th width="777" height="26" scope="col"><div align="right" class="boldElevenPrint">
      <div align="left">Date of payment of Wages </div>
    </div></th>
    <th width="3" scope="col">&nbsp;</th>
  </tr>
  <tr>
    <th height="30" colspan="2" scope="col"><div align="left" class="boldElevenPrint">Name and Full Address of the Establish M/s. </div></th>
  </tr>
  <tr>
    <th colspan="2" scope="col">&nbsp;</th>
  </tr>
  <tr>
    <th height="63" colspan="2" scope="col"><div align="left" class="bolddeepblue"><span class="boldElevenPrint">Name of the Employer /Contract/Managing Director/<br>
      Managing partner Or authorised Person with Full Residental Address :</span></div></th>
  </tr>
  <tr>
    <th height="19" colspan="2" scope="col">&nbsp;</th>
  </tr>
  <tr>
    <th height="57" colspan="2" scope="col"><table width="753" height="299" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
      <tr>
        <th width="17" height="68" class="boldElevenPrint" scope="col">Sl No </th>
        <th width="78" class="boldElevenPrint" scope="col">Name of the person employed</th>
        <th width="36" class="boldElevenPrint" scope="col">sex</th>
        <th width="63" class="boldElevenPrint" scope="col">Father'/ Husband's name </th>
        <th width="54" class="boldElevenPrint" scope="col">Designatio n</th>
        <th width="49" class="boldElevenPrint" scope="col">Employe e Number </th>
        <th width="43" class="boldElevenPrint" scope="col">Date of Entry into Service </th>
        <th width="52" class="boldElevenPrint" scope="col">Adult/Ad olescent/ Child</th>
        <th width="44" class="boldElevenPrint" scope="col">Shift Numbe r </th>
        <th width="48" class="boldElevenPrint" scope="col">Time of Comme ncement of work </th>
        <th width="42" class="boldElevenPrint" scope="col">Root Interva l </th>
        <th width="53" class="boldElevenPrint" scope="col">Time of Which work ends </th>
        <th width="51" class="boldElevenPrint" scope="col">Weekly Holidays </th>
        <th width="56" class="boldElevenPrint" scope="col">Class of Workers </th>
        <th colspan="2" class="boldElevenPrint" scope="col">Rate of Wages </th>
      </tr>
      <tr>
        <th colspan="14" class="bolddeepblue" scope="col">&nbsp;</th>
        <th width="42" class="boldElevenPrint" scope="col">Max</th>
        <th width="42" class="boldElevenPrint" scope="col">Min</th>
      </tr>
      <tr>
        <th height="27" class="boldElevenPrint" scope="col">1</th>
        <th class="boldElevenPrint" scope="col">2</th>
        <th class="boldElevenPrint" scope="col">3</th>
        <th class="boldElevenPrint" scope="col">4</th>
        <th class="boldElevenPrint" scope="col">5</th>
        <th class="boldElevenPrint" scope="col">6</th>
        <th class="boldElevenPrint" scope="col">7</th>
        <th class="boldElevenPrint" scope="col">8</th>
        <th class="boldElevenPrint" scope="col">9</th>
        <th class="boldElevenPrint" scope="col">10</th>
        <th class="boldElevenPrint" scope="col">11</th>
        <th class="boldElevenPrint" scope="col">12</th>
        <th class="boldElevenPrint" scope="col">13</th>
        <th class="boldElevenPrint" scope="col">14</th>
        <th class="boldElevenPrint" scope="col">15</th>
        <th class="boldElevenPrint" scope="col">16</th>
      </tr>
      <tr>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col"><p>&nbsp;</p>
              <p>&nbsp;</p>
          <p class="bolddeepblue">List Enclosed </p>
          <p>&nbsp;</p>
          <p>&nbsp;</p>
          <p>&nbsp;</p></th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
        <th class="boldElevenPrint" scope="col">&nbsp;</th>
      </tr>
    </table></th>
  </tr>
  <tr>
    <th height="61" colspan="2" scope="col"><p>&nbsp;</p>
     
      <table width="491" border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <th width="491" scope="col"><div align="left" class="boldElevenPrint">Signature of the Employer/Contractor/ <br>
              Managing Director /Managing partner/Manager/Authoriesd Person </div></th>
          </tr>
      </table></th>
  </tr>
</table>
<p></p>
</body>
</html>
