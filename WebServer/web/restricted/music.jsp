<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Music | DropMusic</title>
    <jsp:include page="header.jsp"/>
    <script src="https://code.jquery.com/jquery-1.10.2.js" type="text/javascript"></script>
    <script>


        $(document).ready(function(){

            $("#associateDropboxButton").click(function() {

                $.ajax({
                type: 'POST',
                    url:'associateMusicAction.action?' +
                        '&model.albumTitle='+ document.getElementById('albumName').innerText +
                        '&model.artistName=' + document.getElementById('artistName').innerText +
                        '&model.title='+ document.getElementById('musicTitle').innerText +
                        '&model.fileName='+ document.getElementById('fileName').value
                ,
                dataType: 'text',
                success: function(data){
                    document.getElementById('rsp').innerHTML = data;
                }, error: function(data) {
                    document.getElementById('rsp').innerHTML = data;
                }
                });
                return false;
            });


            $("#shareDropboxButton").click(function() {


                $.ajax({
                    type: 'POST',
                    url:'shareMusicDropbox.action?' +
                        '&email='+ document.getElementById('email').value +
                        '&model.albumTitle='+ document.getElementById('albumName').innerText +
                        '&model.artistName=' + document.getElementById('artistName').innerText +
                        '&model.title='+ document.getElementById('musicTitle').innerText
                    ,
                    dataType: 'text',
                    success: function(data){
                        document.getElementById('rspShare').innerHTML = data;
                    }, error: function(data) {
                        document.getElementById('rspShare').innerHTML = data;
                    }
                });
                return false;
            });



        })

        $(document).ready(function() {
            $("#playButton").click(function(){
                $.ajax({
                    type: 'POST',
                    url:'playAction.action?inputModel.artistName='+ document.getElementById('artist').value
                        + '&inputModel.albumTitle='+document.getElementById('album').value
                        + '&inputModel.title='+document.getElementById('title').value,
                    dataType: 'text',
                    success: function(data){
                        document.getElementById('playBar').innerHTML = data;
                    }, error: function(data) {
                        document.getElementById('playBar').innerHTML = data;
                    }
                });
                return false;
            });
        });
    </script>
</head>
<body>

<c:choose>
    <c:when test="${result == null}">
        No result found!
    </c:when>
    <c:otherwise>
        <h1>
            <c:out value="${result.title}" /> from <c:out value="${result.albumTitle}" /> by <c:out value="${result.artistName}" /> <br />
        </h1>
        <div>
            <b>Track:</b> <c:out value="${result.title}" /> <br/>
            <b>Title:</b> <c:out value="${result.track}" /> <br/>
            <b>Lyrics:</b> <c:out value="${result.lyrics}" /> <br/>
        </div>

        <s:set var="artistName">${result.artistName}</s:set>
        <s:set var="albumName">${result.albumTitle}</s:set>
        <s:set var="title">${result.title}</s:set>

        <s:form action="playAction">
            <s:hidden name="inputModel.artistName" value="%{#artistName}" id="artist"/>
            <s:hidden name="inputModel.albumTitle" value="%{#albumName}" id="album"/>
            <s:hidden name="inputModel.title" value="%{#title}" id="title" />
            <button type="button" id="playButton">Play song!</button>
            <div id="playBar">

            </div>
        </s:form>
        <br />
        <br/>

        <p hidden id="artistName" >${result.artistName}</p>
        <p hidden id="albumName" >${result.albumTitle}</p>
        <p hidden id="musicTitle" >${result.title}</p>

        Name of file in DropBox:
        <s:textfield id="fileName" />
        <button type="button" id="associateDropboxButton">Associate</button>
        <div id="rsp"></div><br>


        <hr>
        Share with:
        <s:textfield id="email" />
        <button type="button" id="shareDropboxButton">Share</button>
        <div id="rspShare"></div><br>

    </c:otherwise>
</c:choose>

</body>
</html>
