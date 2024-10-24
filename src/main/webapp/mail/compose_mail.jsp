<%@ page language="java" import="java.io.*"%>

<%
	if (session != null)
		session.removeValue("currentfolder");
%>
<HTML>
<HEAD>
<TITLE>Ayush - Mail</TITLE>
</HEAD>
<link rel="stylesheet" href="nav.css">
<link rel="stylesheet" type="text/css" href="compose.css">
<STYLE>
TR.H {
	BACKGROUND-COLOR: #DFEBFD
}
</STYLE>

<style>
.b {
	border: 1px solid #6699cc;
	background: #Ffffff;
	color: #330099;
	FONT-FAMILY: "verdana" font-size : 10px;
	font-weight: plain
}

.button {
	border: 1px solid #6699cc;
	background: #Ffffff;
	color: #000000;
	FONT-FAMILY: "verdana" font-size : 11px;
	font-weight: plain
}
</style>
<script src="ylib_dom.js"></script>
<script language=JavaScript src="pim.js"></script>
<script src="pulldowns.js"></script>

<script>
function UtilBeginScript()
{
return String.fromCharCode(60, 115, 99, 114, 105, 112, 116, 62);
}

function UtilEndScript()
{
return String.fromCharCode(60, 47, 115, 99, 114, 105, 112, 116, 62);
}
</script>
<script>
function IDGenerator(nextID)
{
this.nextID = nextID;
this.GenerateID = IDGeneratorGenerateID;
}

function IDGeneratorGenerateID()
{
return this.nextID++;
}
</script>

<script>
var BUTTON_IMAGE_PREFIX = "buttonImage";
var BUTTON_DIV_PREFIX = "buttonDiv";
var BUTTON_PAD1_PREFIX = "buttonPad1";
var BUTTON_PAD2_PREFIX = "buttonPad2";
var buttonMap = new Object();

function Button(idGenerator,caption,action,text,image)
{
this.idGenerator = idGenerator;
this.caption = caption;
this.action = action;
this.text = text;
this.image = image;
this.enabled = true;
this.Instantiate = ButtonInstantiate;
this.Enable = ButtonEnable;
}

function ButtonInstantiate()
{
this.id = this.idGenerator.GenerateID();
buttonMap[this.id] = this;
var html = "";
html += '<div id="';
html += BUTTON_DIV_PREFIX;
html += this.id;
html += '" class="ButtonNormal"';
html += ' onselectstart="ButtonOnSelectStart()"';
html += ' ondragstart="ButtonOnDragStart()"';
html += ' onmousedown="ButtonOnMouseDown(this)"';
html += ' onmouseup="ButtonOnMouseUp(this)"';
html += ' onmouseout="ButtonOnMouseOut(this)"';
html += ' onmouseover="ButtonOnMouseOver(this)"';
html += ' onclick="ButtonOnClick(this)"';
html += ' ondblclick="ButtonOnDblClick(this)"';
html += ' onfocus="alert()"';
html += '>';
html += '<a href="#" style="cursor:hand" >';
html += '<table cellpadding=0 cellspacing=0 border=0><tr><td><img id="';
html += BUTTON_PAD1_PREFIX;
html += this.id;
html += '" width=2 height=2></td><td></td><td></td></tr><tr><td></td><td><table cellpadding=0 cellspacing=0 border=0><tr>';
html += '<td>';
html += '<img id="';
html += BUTTON_IMAGE_PREFIX;
html += this.id;
html += '" src="';
html += this.image;
html += '" title="';
html += this.caption;
html += '">';
html += '</td>';
if (this.text != "") {
html += '<td>&nbsp;</td>';
html += '<td class=ButtonText>';
html += this.text;
html += '</td>';
}
html += '</tr></table></td><td></td></tr><tr><td></td><td></td><td><img id="';
html += BUTTON_PAD2_PREFIX;
html += this.id;
html += '" width=2 height=2></td></tr></table>';
html += '</a>';
html += '</div>';
document.write(html);
}

function ButtonEnable(enabled)
{
this.enabled = enabled;
if (this.enabled)
{
document.all[BUTTON_DIV_PREFIX + this.id].className = "ButtonNormal";
}
else
{
document.all[BUTTON_DIV_PREFIX + this.id].className = "ButtonDisabled";
}
}

function ButtonOnSelectStart()
{
window.event.returnValue = false;
}

function ButtonOnDragStart()
{
window.event.returnValue = false;
}

function ButtonOnMouseDown(element)
{
if (event.button == 1)
{
var id = element.id.substring(BUTTON_DIV_PREFIX.length, element.id.length);
var button = buttonMap[id];
if (button.enabled)
{
ButtonPushButton(id);
}
}
}

function ButtonOnMouseUp(element)
{
if (event.button == 1)
{
var id = element.id.substring(BUTTON_DIV_PREFIX.length, element.id.length);
var button = buttonMap[id];
if (button.enabled)
{
ButtonReleaseButton(id);
}
}
}

function ButtonOnMouseOut(element)
{
var id = element.id.substring(BUTTON_DIV_PREFIX.length, element.id.length);
var button = buttonMap[id];
if (button.enabled)
{
ButtonReleaseButton(id);
}
}

function ButtonOnMouseOver(element)
{
var id = element.id.substring(BUTTON_DIV_PREFIX.length, element.id.length);
var button = buttonMap[id];
if (button.enabled)
{
ButtonReleaseButton(id);
document.all[BUTTON_DIV_PREFIX + id].className = "ButtonMouseOver";
}
}

function ButtonOnClick(element)
{
var id = element.id.substring(BUTTON_DIV_PREFIX.length, element.id.length);
var button = buttonMap[id];
if (button.enabled)
{
eval(button.action);
}
}

function ButtonOnDblClick(element)
{
ButtonOnClick(element);
}

function ButtonPushButton(id)
{
document.all[BUTTON_PAD1_PREFIX + id].width = 3;
document.all[BUTTON_PAD1_PREFIX + id].height = 3;
document.all[BUTTON_PAD2_PREFIX + id].width = 1;
document.all[BUTTON_PAD2_PREFIX + id].height = 1;
document.all[BUTTON_DIV_PREFIX + id].className = "ButtonPressed";
}

function ButtonReleaseButton(id)
{
document.all[BUTTON_PAD1_PREFIX + id].width = 2;
document.all[BUTTON_PAD1_PREFIX + id].height = 2;
document.all[BUTTON_PAD2_PREFIX + id].width = 2;
document.all[BUTTON_PAD2_PREFIX + id].height = 2;
document.all[BUTTON_DIV_PREFIX + id].className = "ButtonNormal";
}
</script>




<script>
var IMAGE_CHOOSER_FRAME_PREFIX = "imageChooserFrame";
var IMAGE_CHOOSER_CONTENT_PREFIX = "imageChooserContent";
var IMAGE_CHOOSER_IMG_PREFIX = "imageChooserImg";
var IMAGE_CHOOSER_ICON_PREFIX = "imageChooserIcon";
var imageChooserMap = new Object();

function ImageChooser
(
idGenerator,
numRows,
numCols,
imageWidth,
imageHeight,
images,
callback
)
{
this.idGenerator = idGenerator;
this.numRows = numRows;
this.numCols = numCols;
this.imageWidth = imageWidth;
this.imageHeight = imageHeight;
this.images = images;
this.callback = callback;
this.Instantiate = ImageChooserInstantiate;
this.Show = ImageChooserShow;
this.Hide = ImageChooserHide;
this.IsShowing = ImageChooserIsShowing;
this.SetUserData = ImageChooserSetUserData;
}

function ImageChooserInstantiate()
{
this.id = this.idGenerator.GenerateID();
imageChooserMap[this.id] = this;
var width = (this.imageWidth + 4) * this.numCols + 2;
var height = (this.imageHeight + 4) * this.numRows + 2;
document.write(
'<iframe id="' + IMAGE_CHOOSER_FRAME_PREFIX + this.id + '" class="Selector" marginwidth=0 marginheight=0 frameborder=0 scrolling=no width=' + width + ' height=' + height + ' style="display:none"></iframe>'
);
ImageChooserInitContent(this.id);
}

function ImageChooserShow(x, y)
{
var f = eval(IMAGE_CHOOSER_FRAME_PREFIX + this.id);
if (
f.document.body.innerHTML == ""
) {
f.document.body.innerHTML = this.content;
}
f.document.body.style.border = "#737373 solid 1px";
d.all[IMAGE_CHOOSER_FRAME_PREFIX + this.id].style.left = x;
d.all[IMAGE_CHOOSER_FRAME_PREFIX + this.id].style.top = y;
d.all[IMAGE_CHOOSER_FRAME_PREFIX + this.id].style.display = "block";
}

function ImageChooserHide()
{
d.all[IMAGE_CHOOSER_FRAME_PREFIX + this.id].style.display = "none";
}

function ImageChooserIsShowing()
{
return d.all[IMAGE_CHOOSER_FRAME_PREFIX + this.id].style.display == "block";
}

function ImageChooserSetUserData(userData)
{
this.userData = userData;
}

function ImageChooserOnMouseOver(id)
{
var f = eval(IMAGE_CHOOSER_FRAME_PREFIX + id);
if (f.event.srcElement.tagName == "IMG") {
var underscore = f.event.srcElement.id.indexOf("_");
if (underscore != -1) {
var id = f.event.srcElement.id.substring(IMAGE_CHOOSER_IMG_PREFIX.length, underscore);
var index = f.event.srcElement.id.substring(underscore + 1);
f[IMAGE_CHOOSER_ICON_PREFIX + id + "_" + index].style.borderColor = "black";
}
}
}

function ImageChooserOnMouseOut(id)
{
var f = eval(IMAGE_CHOOSER_FRAME_PREFIX + id);
if (f.event.srcElement.tagName == "IMG") {
var underscore = f.event.srcElement.id.indexOf("_");
if (underscore != -1) {
var id = f.event.srcElement.id.substring(IMAGE_CHOOSER_IMG_PREFIX.length, underscore);
var index = f.event.srcElement.id.substring(underscore + 1);
f[IMAGE_CHOOSER_ICON_PREFIX + id + "_" + index].style.borderColor = "white";
}
}
}

function ImageChooserOnClick(id)
{
var f = eval(IMAGE_CHOOSER_FRAME_PREFIX + id);
if (f.event.srcElement.tagName == "IMG") {
var underscore = f.event.srcElement.id.indexOf("_");
if (underscore != -1) {
var id = f.event.srcElement.id.substring(IMAGE_CHOOSER_IMG_PREFIX.length, underscore);
var imageChooser = imageChooserMap[id];
imageChooser.Hide();
var index = f.event.srcElement.id.substring(underscore + 1);
if (imageChooser.callback) {
imageChooser.callback(imageChooser.images[index], imageChooser.userData);
}
}
}
}

function ImageChooserInitContent(id)
{
imageChooser = imageChooserMap[id];
imageChooser.content = "";
imageChooser.content += '<table id="' + IMAGE_CHOOSER_CONTENT_PREFIX + imageChooser.id + '" cellpadding=1 cellspacing=0 border=0>';
for (var i = 0; i < imageChooser.numRows; i++) {
imageChooser.content += '<tr>';
for (var j = 0; j < imageChooser.numCols; j++) {
imageChooser.content += '<td>';
var k = i * imageChooser.numCols + j;
imageChooser.content += '<div id="' + IMAGE_CHOOSER_ICON_PREFIX + imageChooser.id + '_' + k + '" style="border:white solid 1px;cursor:hand">';
imageChooser.content += '<img src="' + imageChooser.images[k] + '" id="' + IMAGE_CHOOSER_IMG_PREFIX + imageChooser.id + '_' + k + '" width=' + imageChooser.imageWidth + ' height=' + imageChooser.imageHeight + ' onmouseover="parent.ImageChooserOnMouseOver(' + imageChooser.id + ')" onmouseout="parent.ImageChooserOnMouseOut(' + imageChooser.id + ')" onclick="parent.ImageChooserOnClick(' + imageChooser.id + ')">';
imageChooser.content += '</div>';
imageChooser.content += '</td>';
}
imageChooser.content += '</tr>';
}
imageChooser.content += '</table>';
}
</script>
<script>
var EDITOR_COMPOSITION_PREFIX = "editorComposition";
var EDITOR_TOOLBAR_PREFIX = "editorToolbar";
var EDITOR_SMILEY_BUTTON_PREFIX = "editorSmileyButton";
var EDITOR_IMAGE_CHOOSER_PREFIX = "editorImageChooser";
var EDITOR_DEFAULT_FONT_FAMILY = "verdana";
var EDITOR_DEFAULT_FONT_SIZE = "10pt";
var EDITOR_FONT_PREFIX = "editorFont";
var EDITOR_SIZE_PREFIX = "editorSize";
var EDITOR_FORE_PREFIX = "editorFore";
var EDITOR_BACK_PREFIX = "editorBack";
var EDITOR_ALIGN_PREFIX = "editorAlign";
var EDITOR_LIST_PREFIX = "editorList";
var editorMap = new Object();
var editorIDGenerator = null;
var editorActive = 0;

function Editor(idGenerator)
{
this.idGenerator = idGenerator;
this.textMode = false;
this.backgroundColor = "";
this.backgroundImage = "";
this.foregroundColor = "";
this.fontFamily = "";
this.fontSize = "";
this.stationery = false;
this.stationeryWindow = null;
this.instantiated = false;
this.Instantiate = EditorInstantiate;
this.GetText = EditorGetText;
this.SetText = EditorSetText;
this.GetHTML = EditorGetHTML;
this.SetHTML = EditorSetHTML;
this.Focus = EditorFocus;
this.SetDomain = SetDomain;
this.SetBackgroundColor = EditorSetBackgroundColor;
this.GetBackgroundColor = EditorGetBackgroundColor;
this.RemoveBackgroundColor = EditorRemoveBackgroundColor;
this.SetBackgroundImage = EditorSetBackgroundImage;
this.GetBackgroundImage = EditorGetBackgroundImage;
this.RemoveBackgroundImage = EditorRemoveBackgroundImage;
this.SetForegroundColor = EditorSetForegroundColor;
this.GetForegroundColor = EditorGetForegroundColor;
this.RemoveForegroundColor = EditorRemoveForegroundColor;
this.SetFontFamily = EditorSetFontFamily;
this.GetFontFamily = EditorGetFontFamily;
this.RemoveFontFamily = EditorRemoveFontFamily;
this.SetFontSize = EditorSetFontSize;
this.GetFontSize = EditorGetFontSize;
this.RemoveFontSize = EditorRemoveFontSize;
this.SetStationery = EditorSetStationery;
this.GetStationery = EditorGetStationery;
this.ViewHTMLSource = EditorViewHTMLSource;
this.Unload = EditorUnload;
}

function EditorInstantiate()
{
if (this.instantiated) {
return;
}
this.id = this.idGenerator.GenerateID();
editorMap[this.id] = this;
editorIDGenerator = this.idGenerator;
var html = "";
html += "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\">";
html += "<tr>";
html += "<td id=\"" + EDITOR_TOOLBAR_PREFIX + this.id + "\" class=\"Toolbar\">";
html += "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">";
html += "<tr>";
<!-- cut, paste, copy -->
html += "<td>";
html += UtilBeginScript();
html += "var cutButton = new Button(";
html += "editorIDGenerator,";
html += "\"Cut\",";
html += "\"EditorOnCut(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_cut_1.gif\"";
html += ");";
html += "cutButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
html += "<td>";
html += UtilBeginScript();
html += "var copyButton = new Button(";
html += "editorIDGenerator,";
html += "\"Copy\",";
html += "\"EditorOnCopy(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_copy_1.gif\"";
html += ");";
html += "copyButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
html += "<td>";
html += UtilBeginScript();
html += "var pasteButton = new Button(";
html += "editorIDGenerator,";
html += "\"Paste\",";
html += "\"EditorOnPaste(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_paste_1.gif\"";
html += ");";
html += "pasteButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
html += "<td>";
html += "<div class=\"Divider\"></div>";
html += "</td>";
<!-- font -->
html += "<td>";
html += UtilBeginScript();
html += "var fontButton = new Button(";
html += "editorIDGenerator,";
html += "\"Font Face\",";
html += "\"EditorOnFontDropDown(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_fontface_1.gif\"";
html += ");";
html += "fontButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
<!-- size -->
html += "<td>";
html += UtilBeginScript();
html += "var sizeButton = new Button(";
html += "editorIDGenerator,";
html += "\"Font Size\",";
html += "\"EditorOnSizeDropDown(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_fontsize_1.gif\"";
html += ");";
html += "sizeButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
<!-- bold, italic, underline-->
html += "<td>";
html += "<div class=\"Divider\"></div>";
html += "</td>";
html += "<td>";
html += UtilBeginScript();
html += "var boldButton = new Button(";
html += "editorIDGenerator,";
html += "\"Bold\",";
html += "\"EditorOnBold(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_bold_1.gif\"";
html += ");";
html += "boldButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
html += "<td>";
html += UtilBeginScript();
html += "var italicButton = new Button(";
html += "editorIDGenerator,";
html += "\"Italic\",";
html += "\"EditorOnItalic(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_italic_1.gif\"";
html += ");";
html += "italicButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
html += "<td>";
html += UtilBeginScript();
html += "var underlineButton = new Button(";
html += "editorIDGenerator,";
html += "\"Underline\",";
html += "\"EditorOnUnderline(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_uline_1.gif\"";
html += ");";
html += "underlineButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
html += "<td>";
html += "<div class=\"Divider\"></div>";
html += "</td>";
<!-- foreground text color -->
html += "<td>";
html += UtilBeginScript();
html += "var foregroundTextColorButton = new Button(";
html += "editorIDGenerator,";
html += "\"Text Color\",";
html += "\"EditorOnForegroundTextColor(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_coltext_1.gif\"";
html += ");";
html += "foregroundTextColorButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
<!-- background text color -->
html += "<td>";
html += UtilBeginScript();
html += "var backgroundTextColorButton = new Button(";
html += "editorIDGenerator,";
html += "\"Highlight Color\",";
html += "\"EditorOnBackgroundTextColor(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_colhilite_1.gif\"";
html += ");";
html += "backgroundTextColorButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
<!-- smiley button -->
html += "<td id=\"" + EDITOR_SMILEY_BUTTON_PREFIX + this.id + "\">";
html += UtilBeginScript();
html += "var insertSmileyButton = new Button(";
html += "editorIDGenerator,";
html += "\"Insert Emoticon\",";
html += "\"EditorOnStartInsertSmiley(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_smiley_1.gif\"";
html += ");";
html += "insertSmileyButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
<!-- insert weblink -->
html += "<td>";
html += UtilBeginScript();
html += "var createHyperlinkButton = new Button(";
html += "editorIDGenerator,";
html += "\"Create Hyperlink\",";
html += "\"EditorOnCreateHyperlink(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_link_1.gif\"";
html += ");";
html += "createHyperlinkButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
html += "<td>";
html += "<div class=\"Divider\"></div>";
html += "</td>";
<!-- alignment -->
html += "<td>";
html += UtilBeginScript();
html += "var alignmentButton = new Button(";
html += "editorIDGenerator,";
html += "\"Align Text\",";
html += "\"EditorOnAlignment(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_justpd_1.gif\"";
html += ");";
html += "alignmentButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
<!-- bulleted list -->
html += "<td>";
html += UtilBeginScript();
html += "var bulletedListButton = new Button(";
html += "editorIDGenerator,";
html += "\"List\",";
html += "\"EditorOnList(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_listpd_1.gif\"";
html += ");";
html += "bulletedListButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
html += "<td>";
html += "<div class=\"Divider\"></div>";
html += "</td>";
html += "<td>";
html += UtilBeginScript();
html += "var decreaseIndentButton = new Button(";
html += "editorIDGenerator,";
html += "\"Decrease Indent\",";
html += "\"EditorOnDecreaseIndent(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_ileft_1.gif\"";
html += ");";
html += "decreaseIndentButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
html += "<td>";
html += UtilBeginScript();
html += "var increaseIndentButton = new Button(";
html += "editorIDGenerator,";
html += "\"Increase Indent\",";
html += "\"EditorOnIncreaseIndent(" + this.id + ")\",";
html += "\"\",";
html += "\"images/compose/tb_iright_1.gif\"";
html += ");";
html += "increaseIndentButton.Instantiate();";
html += UtilEndScript();
html += "</td>";
<!-- stationery -->
html += "</tr>";
html += "</table>";
html += "</td>";
html += "</tr>";
html += "<tr>";
html += "<td>";
html += "<iframe id=\"" + EDITOR_COMPOSITION_PREFIX + this.id + "\" width=\"100%\" height=\"220\">";
html += "</iframe>";
html += "</td>";
html += "</tr>";
html += "</table>";
html += UtilBeginScript();
html += "var " + EDITOR_IMAGE_CHOOSER_PREFIX + this.id + " = new ImageChooser(";
html += "editorIDGenerator,";
html += "8, 5,";
html += "18, 18,";
html += "[";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/01.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/02.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/03.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/04.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/05.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/06.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/07.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/08.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/09.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/10.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/11.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/12.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/13.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/14.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/15.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/16.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/17.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/18.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/19.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/20.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/21.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/22.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/23.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/24.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/25.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/26.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/27.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/28.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/29.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/30.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/31.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/32.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/33.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/34.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/35.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/37.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/39.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/40.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/47.gif\",";
html += "\"http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/50.gif\"";
html += "],";
html += "EditorOnEndInsertSmiley";
html += ");";
html += EDITOR_IMAGE_CHOOSER_PREFIX + this.id + ".SetUserData(" + this.id + ");";
html += EDITOR_IMAGE_CHOOSER_PREFIX + this.id + ".Instantiate();";
html += UtilEndScript();
html +="<iframe id='" + EDITOR_FONT_PREFIX + this.id + "' class=Selector width=125 height=235 marginwidth=0 marginheight=0 frameborder=0 scrolling=no style='top:30px;left:86px;display:none'></iframe>";
html += "<iframe id='" + EDITOR_SIZE_PREFIX + this.id + "' class=Selector width=145 height=256 marginwidth=0 marginheight=0 frameborder=0 scrolling=no style='top:30px;left:114px;display:none'></iframe>";
html += "<iframe id='" + EDITOR_ALIGN_PREFIX + this.id + "' class=Selector width=102 height=88 marginwidth=0 marginheight=0 frameborder=0 scrolling=no style='top:30px;left:344px;display:none'></iframe>";
html += "<iframe id='" + EDITOR_LIST_PREFIX + this.id + "' class=Selector width=121 height=60 marginwidth=0 marginheight=0 frameborder=0 scrolling=no style='top:30px;left:372px;display:none'></iframe>";
html += "<iframe id='" + EDITOR_FORE_PREFIX + this.id + "' class=Selector src='' width=168 height=186 frameborder=0 scrolling=no style='top:30px;left:230px;display:none;'></iframe>";
html += "<iframe id='" + EDITOR_BACK_PREFIX + this.id + "' class=Selector src='' width=168 height=186 frameborder=0 scrolling=no style='top:30px;left:258px;display:none;'></iframe>";
document.write(html);
html = '';
html += '<body  onpaste="return false;" style="font-family:' + EDITOR_DEFAULT_FONT_FAMILY + ';font-size:' + EDITOR_DEFAULT_FONT_SIZE + '">';
html += '<div></div>';
html += '</body>';
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.designMode = "on";
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.open();
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.write(html);
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.close();
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.onclick = new Function("EditorOnClick(" + this.id + ")");
EditorInitDropDowns(this.id);
editorIDGenerator = null;
this.instantiated = true;
}

function EditorGetText()
{
return eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.innerText;
}

function EditorSetText(text)
{
text = text.replace(/\n/g, "<br>");
text = "<div>" + text + "</div>";
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.innerHTML = text;
}

function EditorGetHTML()
{
if (this.textMode) {
return eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.innerText;
}
var html =  eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.innerHTML;
return html.toLowerCase() == "<div></div>" ? "" : html;
}

function EditorSetHTML(html)
{
if (this.textMode) {
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.innerText = html;
}
else {
html = "<div>" + html + "</div>";
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.innerHTML = html;
}
}

function EditorFocus()
{
eval(EDITOR_COMPOSITION_PREFIX + this.id).focus();
}

function SetDomain(d)
{
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.domain = d;
}

function EditorOnCut(id)
{
EditorFormat(id, "cut");
}

function EditorOnCopy(id)
{
EditorFormat(id, "copy");
}

function EditorOnPaste(id)
{
EditorFormat(id, "paste");
}

function EditorOnBold(id)
{
EditorFormat(id, "bold");
}

function EditorOnItalic(id)
{
EditorFormat(id, "italic");
}

function EditorOnUnderline(id)
{
EditorFormat(id, "underline");
}

function EditorOnAlignLeft(id)
{
EditorFormat(id, "justifyleft");
}

function EditorOnCenter(id)
{
EditorFormat(id, "justifycenter");
}

function EditorOnAlignRight(id)
{
EditorFormat(id, "justifyright");
}

function EditorOnNumberedList(id)
{
EditorFormat(id, "insertOrderedList");
}

function EditorOnBulletedList(id)
{
EditorFormat(id, "insertUnorderedList");
}

function EditorOnDecreaseIndent(id)
{
EditorFormat(id, "outdent");
}

function EditorOnIncreaseIndent(id)
{
EditorFormat(id, "indent");
}

function EditorOnStationery(id)
{
if (!EditorValidateMode(id)) {
return;
}


EditorHideAllDropDowns(id);
var editor = editorMap[id];
var width = 382;
var height = 348;
var left = (screen.availWidth - width) / 2;
var top = (screen.availHeight - height) / 2;


}

function EditorOnCreateHyperlink(id)
{
if (!EditorValidateMode(id)) {
return;
}
EditorHideAllDropDowns(id);
var anchor = EditorGetElement("A", eval(EDITOR_COMPOSITION_PREFIX + id).document.selection.createRange().parentElement());
var link = prompt("enter link location (eg. http://www.yahoo.com):", anchor ? anchor.href : "http://");
if (link && link != "http://") {
if (eval(EDITOR_COMPOSITION_PREFIX + id).document.selection.type == "None") {
var range = eval(EDITOR_COMPOSITION_PREFIX + id).document.selection.createRange();
range.pasteHTML('<A HREF="' + link + '"></A>');
range.select();
}
else {
EditorFormat(id, "CreateLink", link);
}
}
}

function EditorOnStartInsertSmiley(id)
{
if (!EditorValidateMode(id)) {
return;
}
if (eval(EDITOR_IMAGE_CHOOSER_PREFIX + id).IsShowing()) {
eval(EDITOR_IMAGE_CHOOSER_PREFIX + id).Hide();
}
else {
EditorHideAllDropDowns(id);
var editor = editorMap[id];
editor.selectionRange = eval(EDITOR_COMPOSITION_PREFIX + id).document.selection.createRange();
eval(EDITOR_IMAGE_CHOOSER_PREFIX + id).Show(eval(EDITOR_SMILEY_BUTTON_PREFIX + id).offsetLeft+2, eval(EDITOR_TOOLBAR_PREFIX + id).offsetTop+30);

}
}

function EditorOnEndInsertSmiley(image, id)
{
if (!EditorValidateMode(id)) {
return;
}
var imgTag = '<img src="' + image + '">';
var editor = editorMap[id];
var bodyRange = eval(EDITOR_COMPOSITION_PREFIX + id).document.body.createTextRange();
if (bodyRange.inRange(editor.selectionRange)) {
editor.selectionRange.pasteHTML(imgTag);
eval(EDITOR_COMPOSITION_PREFIX + id).focus();
}
else {
eval(EDITOR_COMPOSITION_PREFIX + id).document.body.innerHTML += imgTag;
editor.selectionRange.collapse(false);
editor.selectionRange.select();
}
}

function EditorOnFont(id, select)
{
EditorFormat(id, "fontname", select);
}

function EditorOnSize(id, select)
{
EditorFormat(id, "fontsize", select);
}

function EditorOnFontDropDown(id)
{
if (!EditorValidateMode(id)) {
return;
}
EditorToggleDropDown(id, EDITOR_FONT_PREFIX);
}

function EditorOnSizeDropDown(id)
{
if (!EditorValidateMode(id)) {
return;
}
EditorToggleDropDown(id, EDITOR_SIZE_PREFIX);
}

function EditorOnForegroundTextColor(id)
{
if (!EditorValidateMode(id)) {
return;
}
EditorToggleDropDown(id, EDITOR_FORE_PREFIX);
}

function EditorOnBackgroundTextColor(id)
{
if (!EditorValidateMode(id)) {
return;
}
EditorToggleDropDown(id, EDITOR_BACK_PREFIX);
}

function EditorOnAlignment(id)
{
if (!EditorValidateMode(id)) {
return;
}
EditorToggleDropDown(id, EDITOR_ALIGN_PREFIX);
}

function EditorOnList(id)
{
if (!EditorValidateMode(id)) {
return;
}
EditorToggleDropDown(id, EDITOR_LIST_PREFIX);
}

function EditorOnViewHTMLSource(id, textMode)
{
var editor = editorMap[id];
editor.ViewHTMLSource(textMode);
}

function EditorOnClick(id)
{
EditorHideAllDropDowns(id);
}

function EditorValidateMode(id)
{
var editor = editorMap[id];
if (!editor.textMode) {
return true;
}
alert("Please uncheck the \"View HTML Source\" checkbox to use the toolbars.");
eval(EDITOR_COMPOSITION_PREFIX + id).focus();
return false;
}

function EditorFormat(id, what, opt)
{
if (!EditorValidateMode(id)) {
return;
}
if (opt == "removeFormat") {
what = opt;
opt = null;
}
EditorHideAllDropDowns(id);
eval(EDITOR_COMPOSITION_PREFIX + id).focus();
if (opt == null) {
eval(EDITOR_COMPOSITION_PREFIX + id).document.execCommand(what);
}
else
{
eval(EDITOR_COMPOSITION_PREFIX + id).document.execCommand(what,"",opt);
}
}

function EditorCleanHTML(id)
{
var fonts = eval(EDITOR_COMPOSITION_PREFIX + id).document.body.all.tags("FONT");
for (var i = fonts.length - 1; i >= 0; i--) {
var font = fonts[i];
if (font.style.backgroundColor == "#ffffff") {
font.outerHTML = font.innerHTML;
}
}
}

function EditorGetElement(tagName, start)
{
while (start && start.tagName != tagName) {
start = start.parentElement;
}
return start;
}

function EditorSetBackgroundColor(color)
{
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.style.backgroundColor = color;
this.backgroundColor = color;
}

function EditorGetBackgroundColor()
{
return this.backgroundColor;
}

function EditorRemoveBackgroundColor(color)
{
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.style.backgroundColor = "";
this.backgroundColor = "";
}

function EditorSetBackgroundImage(url)
{
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.style.backgroundImage = 'url(' + url + ')';
this.backgroundImage = url;
}

function EditorGetBackgroundImage()
{
return this.backgroundImage;
}

function EditorRemoveBackgroundImage(url)
{
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.style.backgroundImage = "none";
this.backgroundImage = "";
}

function EditorSetForegroundColor(color)
{
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.style.color = color;
this.foregroundColor = color;
}

function EditorGetForegroundColor()
{
return this.foregroundColor;
}

function EditorRemoveForegroundColor(color)
{
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.style.color = "";
this.foregroundColor = "";
}

function EditorSetFontFamily(fontFamily)
{
if (fontFamily == "") {
fontFamily = EDITOR_DEFAULT_FONT_FAMILY;
}
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.style.fontFamily = fontFamily;
this.fontFamily = fontFamily;
}

function EditorGetFontFamily()
{
return this.fontFamily;
}

function EditorRemoveFontFamily(font)
{
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.style.fontFamily = EDITOR_DEFAULT_FONT_FAMILY;
this.fontFamily = EDITOR_DEFAULT_FONT_FAMILY;
}

function EditorSetFontSize(fontSize)
{
if (fontSize == "") {
fontSize = EDITOR_DEFAULT_FONT_SIZE;
}
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.style.fontSize = fontSize;
this.fontSize = fontSize;
}

function EditorGetFontSize()
{
return this.fontSize;
}

function EditorRemoveFontSize(font)
{
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.style.fontSize = EDITOR_DEFAULT_FONT_SIZE;
this.fontSize = EDITOR_DEFAULT_FONT_SIZE;
}

function EditorSetStationery(on)
{
this.stationery = on;
}

function EditorGetStationery()
{
return this.stationery;
}

function EditorViewHTMLSource(textMode)
{
this.textMode = textMode;
if (this.textMode) {
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.innerText = eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.innerHTML;
}
else {
eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.innerHTML = eval(EDITOR_COMPOSITION_PREFIX + this.id).document.body.innerText;
}
eval(EDITOR_COMPOSITION_PREFIX + this.id).focus();
}

function EditorUnload()
{
if (this.stationeryWindow != null) {
this.stationeryWindow.close();
}
}

function EditorShowDropDown(id, prefix)
{
editorActive = id;
EditorHideAllDropDowns(id);
EditorPrepareDropDownContents(id, prefix);
eval(prefix + id).document.body.style.border = "#737373 solid 1px";
d.all[prefix + id].style.display = "inline";
}

function EditorHideDropDown(id, prefix)
{
d.all[prefix + id].style.display = "none";
}

function EditorToggleDropDown(id, prefix)
{
if (d.all[prefix + id].style.display == "none") {
EditorShowDropDown(id, prefix);
}
else {
EditorHideDropDown(id, prefix);
}
}

function EditorHideAllDropDowns(id)
{
var editor = editorMap[id];
for (var i in editor.dropDownMap) {
EditorHideDropDown(id, i);
}
eval(EDITOR_IMAGE_CHOOSER_PREFIX + id).Hide();
}

function EditorPrepareDropDownContents(id, prefix)
{
var editor = editorMap[id];
var dropDown = editor.dropDownMap[prefix];
if (dropDown.external) {
if (d.all[prefix + id].src == "") {
d.all[prefix + id].src = dropDown.content;
}
}
else {
if (eval(prefix + id).document.body.innerHTML == "") {
eval(prefix + id).document.body.innerHTML = dropDown.content;
}
}
}

function EditorInitDropDowns(id)
{
var editor = editorMap[id];
editor.dropDownMap = new Object();
editor.dropDownMap[EDITOR_FONT_PREFIX] = {
external: false,
content: (
"<div onclick=\"parent.EditorHideDropDown(" + id + ", '" + EDITOR_FONT_PREFIX + "')\">"
+
"<table width=100% cellpadding=5 cellspacing=0 border=0>" 
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='arial' size=-1><a class=SelectItem href=\"javascript:parent.EditorOnFont(" + id + ",'arial');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Arial</a></font></td></tr>" 
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='arial narrow' size=-1><a class=SelectItem href=\"javascript:parent.EditorOnFont(" + id + ",'arial narrow');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Arial Narrow</a></font></td></tr>" 
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='arial black' size=-1><a class=SelectItem href=\"javascript:parent.EditorOnFont(" + id + ",'arial black');void(0);\" style=\"text-decoration:none;color:black;width:100%;width:100%;\">Arial Black</a></font></td></tr>" 
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='comic sans ms' size=-1><a class=SelectItem href=\"javascript:parent.EditorOnFont(" + id + ",'comic sans ms');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Comic Sans MS</a></font></td></tr>" 
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='courier' size=-1><a class=SelectItem href=\"javascript:parent.EditorOnFont(" + id + ",'courier');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Courier</a></font></td></tr>" 
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='system' size=-1><a class=SelectItem href=\"javascript:parent.EditorOnFont(" + id + ",'system');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">System</a></font></td></tr>" 
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='times new roman' size=-1><a class=SelectItem href=\"javascript:parent.EditorOnFont(" + id + ",'times new roman');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Times New Roman</a></font></td></tr>" 
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='verdana' size=-1><a class=SelectItem href=\"javascript:parent.EditorOnFont(" + id + ",'verdana');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Verdana</a></font></td></tr>" 
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='wingdings' size=-1><a class=SelectItem href=\"javascript:parent.EditorOnFont(" + id + ",'wingdings');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Wingdings</a></font></td></tr>" 
+
"</table>"
+
"</div>"
)
};
editor.dropDownMap[EDITOR_SIZE_PREFIX] = {
external: false,
content: (
"<div onclick=\"parent.EditorHideDropDown(" + id + ", '" + EDITOR_SIZE_PREFIX + "')\">"
+
"<table width=100% cellpadding=5 cellspacing=0 border=0>"
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='arial' size=1><a class=SelectItem href=\"javascript:parent.EditorOnSize(" + id + ",'1');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Size 1</a></font></td></tr>"
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='arial' size=2><a class=SelectItem href=\"javascript:parent.EditorOnSize(" + id + ",'2');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Size 2</a></font></td></tr>"
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='arial' size=3><a class=SelectItem href=\"javascript:parent.EditorOnSize(" + id + ",'3');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Size 3</a></font></td></tr>"
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='arial' size=4><a class=SelectItem href=\"javascript:parent.EditorOnSize(" + id + ",'4');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Size 4</a></font></td></tr>"
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='arial' size=5><a class=SelectItem href=\"javascript:parent.EditorOnSize(" + id + ",'5');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Size 5</a></font></td></tr>"
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='arial' size=6><a class=SelectItem href=\"javascript:parent.EditorOnSize(" + id + ",'6');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Size 6</a></font></td></tr>"
+
"<tr><td onmouseover=\"this.style.backgroundColor='#dddddd';window.status='';return true;\" onMouseOut=\"this.style.backgroundColor='white';\"><font face='arial' size=7><a class=SelectItem href=\"javascript:parent.EditorOnSize(" + id + ",'7');void(0);\" style=\"text-decoration:none;color:black;width:100%;\">Size 7</a></font></td></tr>"
+
"</table>"
+
"</div>"
)
};
editor.dropDownMap[EDITOR_ALIGN_PREFIX] = {
external: false,
content: (
"<div onclick=\"parent.EditorHideDropDown(" + id + ", '" + EDITOR_ALIGN_PREFIX + "')\">"
+
"<table width=100% border=0 cellspacing=0 cellpadding=2>"
+
"<tr><td><a href=javascript:parent.EditorOnAlignLeft(0);void(0); style=\"text-decoration:none;color:black;\"><img src=http://192.168.10.79:8100/mail_new/images/compose/tb_justleft_1.gif style=\"border:1px solid white;\" onmouseover='this.style.border=\"1px solid black\";window.status=\"\";return true;' onmouseout='this.style.border=\"1px solid white\";\'></a></td><td style='font-family:Verdana;font-size:11px;'>Flush Left</td></tr>"
+
"<tr><td><a href=javascript:parent.EditorOnCenter(0);void(0); style=\"text-decoration:none;color:black;\"><img src=http://192.168.10.79:8100/mail_new/images/compose/tb_justctr_1.gif style=\"border:1px solid white;\" onmouseover='this.style.border=\"1px solid  black\";window.status=\"\";return true;' onmouseout='this.style.border=\"1px solid white\";\'></td><td style='font-family:Verdana;font-size:11px;'>Centered</td></tr>"
+
"<tr><td><a href=javascript:parent.EditorOnAlignRight(0);void(0); style=\"text-decoration:none;color:black;\"><img src=http://192.168.10.79:8100/mail_new/images/compose/tb_justright_1.gif style=\"border:1px solid white;\" onmouseover='this.style.border=\"1px solid black\";window.status=\"\";return true;' onmouseout='this.style.border=\"1px solid white\";\'></td><td style='font-family:Verdana;font-size:11px;'>Flush Right</td></tr>"
+
"</table>"
+
"</div>"
)
};
editor.dropDownMap[EDITOR_LIST_PREFIX] = {
external: false,
content: (
"<div onclick=\"parent.EditorHideDropDown(" + id + ", '" + EDITOR_LIST_PREFIX + "')\">"
+
"<table width=100% border=0 cellspacing=0 cellpadding=2>"
+
"<tr><td><a href=javascript:parent.EditorOnNumberedList(0);void(0); style=\"text-decoration:none;color:black;\"><img src=http://192.168.10.79:8100/mail_new/images/compose/tb_listnum_1.gif style=\"border:1px solid white;\" onmouseover='this.style.border=\"1px solid black\";window.status=\"\";return true;' onmouseout='this.style.border=\"1px solid white\";\'></a></td><td style='font-family:Verdana;font-size:11px;'>Numbered List</td></tr>"
+
"<tr><td><a href=javascript:parent.EditorOnBulletedList(0);void(0); style=\"text-decoration:none;color:black;\"><img src=http://192.168.10.79:8100/mail_new/images/compose/tb_listblt_1.gif style=\"border:1px solid white;\" onmouseover='this.style.border=\"1px solid  black\";window.status=\"\";return true;' onmouseout='this.style.border=\"1px solid white\";\'></td><td style='font-family:Verdana;font-size:11px;'>Bulleted List</td></tr>"
+
"</table>"
+
"</div>"
)
};
editor.dropDownMap[EDITOR_FORE_PREFIX] = {
external: true,
content: "Static.html"
};
editor.dropDownMap[EDITOR_BACK_PREFIX] = {
external: true,
content: "back.html"
};
}
</script>


<script>
var remote=null;
var sigAttMap = [false];

function OnFromAddrChange()
{
var i = document.Compose.FromAddr.selectedIndex;
if (i >= 0 && i < sigAttMap.length) {
document.all.SA.checked = sigAttMap[i];
}
}

function OnMoneyChange()
{
var money = document.Compose.Money.value;
for (var i = 0; i < money.length; i++) {
if (money.charAt(i) != " ") {
document.Compose.SendMoney.checked = true;
return;
}
}
document.Compose.SendMoney.checked = false;
}

function rs(n,u,w,h,x) {
args="width="+w+",height="+h+",resizable=yes,scrollbars=yes,status=0";
remote=window.open(u,n,args);
if (remote != null) {
if (remote.opener == null)
remote.opener = self;
}
if (x == 1) { return remote; }
}

function setFormat()
{
if(document.Compose.Format.checked) {
document.Compose.Format.value="html";
} else {
document.Compose.Format.value="plain";
}
}


function AttachFiles()
{
SetVals();
document.Compose.ATT.value = "1";
document.Compose.submit();
}

function AttachVideo()
{
SetVals();
document.Compose.VID.value = "1";
document.Compose.submit();
}

function RemoveAttachment(index)
{
SetVals();
document.Compose.action += "&UNATTACH=File" + index;
document.Compose.submit();
}

function RemoveVideo()
{
SetVals();
document.Compose.Video.value = "";
document.Compose.submit();
}

function Switch()
{
if (editor.GetText() != "" && editor.GetText() != editor.GetHTML()) {
var conf = confirm("This will convert your message into plain text.  All formatting will be lost.  Continue?");
if (!conf) {
return;
}
}
document.Compose.Body.value = editor.GetHTML();
document.Compose.action = document.Compose.action + "&SWITCH=1";
document.Compose.submit();
}


function SetHtml() {
editor.SetHTML(document.Compose.PlainMsg.value);
}

function RestoreBackground()
{
editor.SetBackgroundImage(
""
);
}

function SetVals() {
document.Compose.Body.value = editor.GetHTML();
}

function SaveMsg()
{
document.Compose.PlainMsg.value = editor.GetHTML();
}

function SetBackground(ref, desc, def, fg, ff, fs, solid, custom)
{
document.Compose.BGRef.value = ref;
document.Compose.BGDesc.value = desc;
document.Compose.BGDef.value = def;
document.Compose.BGFg.value = fg;
document.Compose.BGFF.value = ff;
document.Compose.BGFS.value = fs;
document.Compose.BGSolid.value = solid ? "1" : "0";
document.Compose.BGCustom.value = custom ? "1" : "0";
if (solid) {
editor.SetBackgroundColor(ref);
}
else {
editor.SetBackgroundImage(
custom ? 
("/ym/Stationery?Data=" + ref + "&UrlExtras") 
: 
ref
);
}
editor.SetForegroundColor(fg);
editor.SetFontFamily(ff);
editor.SetFontSize(fs);
}

function RemoveBackground()
{
document.Compose.BGRef.value = "";
document.Compose.BGSolid.value = "";
document.Compose.BGCustom.value = "";
editor.RemoveBackgroundColor();
editor.RemoveBackgroundImage();
editor.RemoveForegroundColor();
editor.RemoveFontFamily();
editor.RemoveFontSize();
}

function GetBackground()
{
return {
ref: document.Compose.BGRef.value,
desc: document.Compose.BGDesc.value,
def: document.Compose.BGDef.value,
fg: document.Compose.BGFg.value,
ff: document.Compose.BGFF.value,
fs: document.Compose.BGFS.value,
solid: document.Compose.BGSolid.value == "1",
custom: document.Compose.BGCustom.value == "1"
};
}

var oldBackground = null;

function SaveOldBackground()
{
oldBackground = GetBackground();
}

function RestoreOldBackground()
{
if (oldBackground) {
RemoveBackground();
SetBackground(
oldBackground.ref,
oldBackground.desc,
oldBackground.def,
oldBackground.fg,
oldBackground.ff,
oldBackground.fs,
oldBackground.solid,
oldBackground.custom
);
}
}

</script>
<script>
function OnLoad()
{
document.Compose.To.focus();
SetHtml();
RestoreBackground();
document.Compose.ATT.value = "";
}
</script>

<script FOR="window" EVENT="onunload" LANGUAGE="javascript">
editor.Unload();
</script>


<script language=javascript>
function cancel()
{
	
 document.Compose.to.value="";
 document.Compose.subject.value="";
 document.Compose.cc.value="";
 document.Compose.bcc.value="";
 editor.SetHTML("");
 
}
function sp(name)
{
Name=name;
Name=eval("document.Compose."+Name+".value");
var spchararray=["~","`","!","(",")","$","%","^","&","*","+","|","<",">","/","?","#","[","]","\"","=",":","{","}","[","]","\\"];
for(i=0;i<=Name.length;i++){
var b=Name.charAt(i);
{
for(j=0;j<=spchararray.length;j++){
if(b==spchararray[j])
{
alert("Should not  allowed special characters, expect  @ , - , _ , ; ,and , ");
eval("document.Compose."+name+".focus()");
return true; 
}
}
}

}		
}
function email(mail)
{
if ((mail.indexOf('@')==-1)||(mail.indexOf('.')==-1)||((mail.indexOf('.'))-2)==(mail.indexOf('@'))||((mail.indexOf('.'))-1)== (mail.indexOf('@'))||(mail.charAt(mail.indexOf('@')-1)==""))
{	
alert("correct this mail id    "+mail);
document.Compose.cc.focus();
return true;
}
}
function mail(mail)
{
if ((mail.indexOf('@')==-1)||(mail.indexOf('.')==-1)||((mail.indexOf('.'))-2)==(mail.indexOf('@'))||((mail.indexOf('.'))-1)== (mail.indexOf('@'))||(mail.charAt(mail.indexOf('@')-1)==""))
{	
alert("correct this mail id    "+mail);
document.Compose.bcc.focus();
return true;
}
}
function validation()
{
if ((document.Compose.to.value == "")||(document.Compose.to.value.indexOf('@') == -1)||(document.Compose.to.value.indexOf('.') == -1)) 
{
alert("please check your 'To' emailid");	
document.Compose.to.select();
return false;
}
if ((document.Compose.from.value == "")||(document.Compose.from.value.indexOf('@') == -1)||(document.Compose.from.value.indexOf('.') == -1)) 
{
alert("please check your 'From' emailid");	
document.Compose.from.select();
return false;
}  
if(document.Compose.subject.value == "") 
{
alert("please enter the subject");	
document.Compose.subject.focus();
return false;
}  
if(document.Compose.body.value == "")
{
alert("Please enter the message");
//dcument.Compose.body.focus();
return false;
}

var name=document.Compose.cc.value;
if(name !=""){
var flag=false;
j=0;
for(i=0;i<name.length;i++){
if(name.charAt(i)==','||name.charAt(i)==';')
{
chk=name.substring(j,i);
if(email(chk))return false;
j=i+1;
flag=true;
}
}
if(flag==true)
{
name1=name.substring(j,name.length);
if(email(name1))return false;
}
if(flag==false){
if(email(name))return false;
}
if(name!=""){
if(sp('cc'))return false;
}
}
var name=document.Compose.bcc.value;
if(name !=""){
var flag=false;
j=0;
for(i=0;i<name.length;i++){
if(name.charAt(i)==','||name.charAt(i)==';')
{
chk=name.substring(j,i);
if(mail(chk))return false;
j=i+1;
flag=true;
}
}
if(flag==true)
{
name1=name.substring(j,name.length);
if(mail(name1))return false;
}
if(flag==false){
if(mail(name))return false;
}
if(name!=""){
if(sp('bcc'))return false;
}
}
return true;
}
</script>
<BODY onload="javascript:document.Compose.to.focus();" topmargin=0
	leftmargin=0 MARGINWIDTH=0 MARGINHEIGHT=0>
<%
	String name = (String) session.getValue("name");
	if (name == null) {
%>
<jsp:forward page="/login.jsp">
	<jsp:param name="control" value="mail" />
</jsp:forward>

<%
	}
	String nana = String.valueOf(name.charAt(0));
	nana = nana.toUpperCase();
	String sss = name.substring(1, name.length());

	String come = request.getParameter("come");
	String h1;
	if (come == null)
		h1 = "no";
	else
		h1 = "yes";
	String fcount1 = (String) session.getValue("fcount");
	int cg;
	if (fcount1 == null)
		cg = 0;
	else
		cg = Integer.parseInt(fcount1);

	fcount1 = (fcount1 == null) ? "" : fcount1;
	

	String username = (String) session.getValue("ID");
	String password = (String) session.getValue("password");
	
	String body = request.getParameter("body");
	body = (body == null) ? "" : body;
	String bcc = request.getParameter("bcc");
	bcc = (bcc == null) ? "" : bcc;
	String cc = request.getParameter("cc");
	cc = (cc == null) ? "" : cc;
	String subject = request.getParameter("subject");
	subject = (subject == null) ? "" : subject;
	String to = request.getParameter("to");
	to = (to == null) ? "" : to;
%>
<form action="confirm.jsp" method="post" name="Compose" onSubmit=" return trs()"><!--  action="/vijay/vijaymail/velu/confirm.jsp"    action="http://www.ayushman.net/mail/send.asp"      name="Compose" >-->
<input type=hidden name="control" value="fusionmail/confirm.jsp">
<input type=hidden name="from" value="<%=username%>@ayushhealth.com">
<table border=0 width="100%" cellspacing=0 cellpadding=0>
	<table border=0 width="780" align=center cellspacing=0 cellpadding=0>
		<tr>
			<td>
		<tr>
			<td colspan="2"><jsp:include page="./mailtop2.html" flush="true" />
			</td>
		</tr>
		<tr>
			<td valign=top align=center width="15%" bgcolor=#ECECFD>
			<table border="0" cellpadding=0 cellspacing=0>
				<tr>
					<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
					<td class="navBorderOut"><img src="images/dot.gif" height=1
						width=1 border=0 alt=""></td>
					<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
				</tr>
				<tr>
					<td class="navBorderOut"><img src="images/dot.gif" height=1
						width=1 border=0 alt=""></td>
					<td class="navBg">
					<table border="0" cellpadding=0 cellspacing=0 width="138">
						<tr>
							<td colspan=2 class="navBorderIn"><img src="images/dot.gif"
								height=1 width=1 border=0 alt=""></td>
						</tr>
						<tr>
							<td class="navBg"><img src="images/dot.gif" height=19
								width=8 border=0 alt=""></td>
							<td width="100%" class="navBg"><font
								face="Verdana,Sans-serif" color="#003366" size=1><a
								href="mail_homepage.jsp"
								onmouseover="status='Mail Home';return true" class="navtxt">Mail
							Home</a></font></td>
						</tr>
						<tr>
							<td colspan=2 class="navBorderOut"><img src="images/dot.gif"
								height=1 width=1 border=0 alt=""></td>
						</tr>
						<tr>
							<td colspan=2 class="navBorderIn"><img src="images/dot.gif"
								height=1 width=1 border=0 alt=""></td>
						</tr>
						<tr>
							<td class="navBgSelected"><img
								src="images/sm_blue_arrow.gif" height="19" width="8" border="0"
								alt=""><img src="images/dot.gif" height=19 width=8
								border=0 alt=""></td>
							<td width="100%" class="navBgSelected"><font
								face="Verdana,Sans-serif" color="#FFFFFF" size=1><b>Compose</b></a></font></td>
						</tr>
						<tr>
							<td colspan=2 class="navBorderOut"><img src="images/dot.gif"
								height=1 width=1 border=0 alt=""></td>
						</tr>
						<tr>
							<td colspan=2 class="navBorderIn"><img src="images/dot.gif"
								height=1 width=1 border=0 alt=""></td>
						</tr>
						<tr>
							<td class="navBg"><img src="images/dot.gif" height=19
								width=8 border=0 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif"
								color="#FFFFFF" size=1><a href="read_mail.jsp"
								onmouseover="status='Inbox';return true" class="navtxt">Inbox</a></font></td>
						</tr>
						<tr>
							<td colspan=2 class="navBorderOut"><img src="images/dot.gif"
								height=1 width=1 border=0 alt=""></td>
						</tr>
						<tr>
							<td colspan=2 class="navBorderIn"><img src="images/dot.gif"
								height=1 width=1 border=0 alt=""></td>
						</tr>
						<tr>
							<td class="navBg"><img src="images/dot.gif" height=19
								width=8 border=0 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif"
								color="#FFFFFF" size=1><a href="view_address.jsp"
								onmouseover="status='Address Book';return true" class="navtxt">Address
							Book</a></font></td>
						</tr>
						<tr>
							<td colspan=2 class="navBorderOut"><img src="images/dot.gif"
								height=1 width=1 border=0 alt=""></td>
						</tr>
						<tr>
							<td colspan=2 class="navBorderIn"><img src="images/dot.gif"
								height=1 width=1 border=0 alt=""></td>
						</tr>
						<tr>
							<td class="navBg"><img src="images/dot.gif" height=19
								width=8 border=0 alt=""></td>
							<td width="100%"><a href="bounce_shtml.htm"><font
								face="Verdana,Sans-serif" color="#FFFFFF" class='navtxt' size=1>Options</a></font></td>
						</tr>
						<tr>
							<td colspan=2 class="navBorderOut"><img src="images/dot.gif"
								height=1 width=1 border=0 alt=""></td>
						</tr>
						<tr>
							<td colspan=2 class="navBorderIn"><img src="images/dot.gif"
								height=1 width=1 border=0 alt=""></td>
						</tr>
						<tr>
							<td class="navBg"><img src="images/dot.gif" height=19
								width=8 border=0 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif"
								color="#FFFFFF" size=1>System Status</a></font></td>
						</tr>
						<tr>
							<td colspan=2 class="navBorderOut"><img src="images/dot.gif"
								height=1 width=1 border=0 alt=""></td>
						</tr>
						<tr>
							<td colspan=2 class="navBorderIn"><img src="images/dot.gif"
								height=1 width=1 border=0 alt=""></td>
						</tr>

						<tr>
							<td class="navBg"><img src="images/dot.gif" height=19
								width=8 border=0 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif"
								color="#FFFFFF" size=1><a
								href="/servlet/logoff?control=mail"
								onmouseover="status='SignOut';return true" class="navtxt">SignOut</a></font></td>
						</tr>
					</table>
					</td>
					<td class="navBorderOut"><img src="images/dot.gif" height=1
						width=1 border=0 alt=""></td>
				</tr>
				<tr>
					<td><img src="/images/dot.gif" height=1 width=1 border=0
						alt=""></td>
					<td class="navBorderOut"><img src="images/dot.gif" height=1
						width=1 border=0 alt=""></td>
					<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
				</tr>
				<tr>
					<td></td>
				</tr>
			</table>
			</td>
			<td width=80% valign=top>&nbsp;&nbsp;&nbsp; <font face=verdana
				size=5 color=#996699><b>Compose</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font
				face=veradana size=3 color=#996745><b>Welcome</b> </font> <font
				color=red face=veradana size=3><b><%=nana + sss%></b></font><font
				face="veradana" size=3 color=#996745></font><br>

			<table BORDER=0 id=styleboxoutside width="95%" BGCOLOR=#D6E9FC
				ALIGN=CENTER cellpadding=0 cellspacing=0>
				<tr>
					<td>
					<table BORDER=0 id=styleboxinside width="100%" BGCOLOR=#D6E9FC
						ALIGN=CENTER cellpadding=0 cellspacing=0>
						<TR>
							<td>&nbsp;&nbsp;</td>
							<TD>&nbsp;&nbsp;<a href="javascript:void(0)"
								onClick="showAddress()"><font face=verdana size=1>Insert
							addresses (seperated by comma and colon)</a></TD>
						</TR>
						<TR>
							<TD align=right WIDTH=10%><FONT face="Verdana,Sans-serif"
								size=1><font color=#3300CC>To:&nbsp;</FONT></TD>
							<TD width=420 colspan=3>&nbsp;&nbsp;<INPUT maxLength=200
								name=to size=60 value="<%=to%>"></TD>
						</TR>
						<tr>
							<td height=5></td>
						</tr>
						
						<tr>
							<td height=5></td>
						</tr>
						<TR>
							<td align=right><FONT face="Verdana,Sans-serif" size=1><font
								color=#3300CC>Cc: </B></FONT></TD>
							<TD>&nbsp;&nbsp;<INPUT maxLength=200 name=cc size=60
								value=<%=cc%>></TD>
						</TR>
						<tr>
							<td height=5></td>
						</tr>
						<TR>
							<TD align=right><FONT face="Verdana,Sans-serif" size=1><font
								color=#3300CC>Bcc: </B></FONT></TD>
							<TD>&nbsp;&nbsp;<INPUT maxLength=400 name=bcc size=60
								value=<%=bcc%>></td>
						</TR>
						<tr>
							<td height=5></td>
						</tr>
						<TR>
							<TD align=right><FONT face="Verdana,Sans-serif" size=1><font
								color=#3300CC>Subject:&nbsp; </B></FONT></TD>
							<TD colspan=3>&nbsp;&nbsp;<INPUT maxLength=200 name=subject
								size=60 value=<%=subject%>></TD>
						</TR>
						<TR>
							<TD align=right><FONT face="Verdana,Sans-serif" size=1><font
								color=#3300CC>Attachments &nbsp;&nbsp;</B></FONT></a></TD>
							<TD
								style="border-bottom: 1px solid #769DB5; padding-bottom: 5px;">&nbsp;&nbsp;<br>
							<input type=submit name=b1 value='Add/Edit Attachment'
								onClick="javascript:attach()">
							<table>
								<%
									for (int i = 0; i < cg; i++) {
								%><tr>
									<td><%=(String) session.getValue("attach" + i)%>&nbsp;&nbsp;<a
										href="attachment/remove.jsp?mode=remove<%=i%>">Remove</a></td>
								</tr>
								<%
									}
								%>
							</table>
							<!--   <INPUT type = button value ="Add/Edit Attachments" class=sbttn tabindex="5" onClick="javascript:attach()"> --><input
								type="hidden" name='h1' value=<%=h1%>>&nbsp;&nbsp;&nbsp;&nbsp;
							<!-- <input type=file name=file1 class='sbttn' onBlur="upload()">&nbsp;&nbsp;&nbsp;&nbsp; -->
							<!-- 	<input type=file name='file2' class='sbttn' onclick="upload()"> --><br>
							<input type=hidden name='f11'> <input type=hidden
								name='f12'></td>
						</TR>
						<tr>
							<td colspan=2 align=right style="padding-top: 5px;"><!--<input type=submit class=sbttn value=Send onClick="SetVals()">&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit class=sbttn value=Cancel>--></td>
						</tr>
						<tr bgcolor=#B1CAE3>
							<td>&nbsp;</td>
							<td>&nbsp;&nbsp;
							<table cellpadding=2 width=95% cellspacing=0 border=0>
								<tr>
									<td colspan=2>
									<div style='position: relative; top =0px; left =0px; height: 250' width=100%>
							<textarea name="body" style='visibility: hidden; position: absolute; top: 0px; left: 0px'><%=body %>
</textarea><input type='hidden' name='body1'> 
<script>
function trs()
{

document.Compose.body.value=editor.GetText();
if(validation())
{
	return true;
}
else
{
	return false;
}

}
var idGenerator = new IDGenerator(0);
var editor = new Editor(idGenerator);

editor.SetStationery(true);
editor.Instantiate();

</script></div>

									</td>
								</tr>
								<tr>
									<td><input type=checkbox name="SigAtt" value="1" id="SA"><font
										face=verdana size=1 color=#000099>Use my signature</td>
									<td align=right><input type=checkbox
										onclick="editor.ViewHTMLSource(this.checked)"> <font
										face=verdana size=1 color=#000099>View HTML Source <input
										type=hidden name=Format id=Format value="html"></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td colspan=2 align=right style="padding-top: 5px;"><input
								type=submit class=sbttn value=Send>&nbsp;&nbsp;&nbsp;&nbsp;<input
								type=button class=sbttn value=Cancel onclick="cancel()">

							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<input type=hidden name=PlainMsg value="''">
	<%!String cont;%>
	<%
		cont = (String) request.getAttribute("ForwardContent");
		if (cont != null) {
	%>
	<script language="javascript">
editor.SetHTML("<%=cont%>");
</script>
	<%
		}
	%>

	</form>
</BODY>
<script>
function showAddress()
{
window.open("insert_address.jsp","jani"," height=600,width=550,location=no,scrollbars,toolbar=no");

}
function SetVals() {

document.Compose.Body.value = editor.GetHTML();

}


function attach()
{

var h1="yes"
var sub=document.Compose.subject.value;
var to=document.Compose.to.value;
var bcc=document.Compose.bcc.value;
var cc=document.Compose.cc.value;
var come="compose";
document.Compose.action="./attachment/attach.jsp?to='"+to+"'&bcc='"+bcc+"'&cc='"+cc+"'&sub='"+sub+"'&h1='"+h1+"'&come='"+come+"'";	
}
</script>
</HTML>
<%-- <%@ include file="/bottom.jsp"%> --%>