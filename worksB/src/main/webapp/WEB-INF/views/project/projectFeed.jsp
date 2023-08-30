<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	 
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<link href="${pageContext.request.contextPath}/resources/dateTimePicker/jquery.datetimepicker.min.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/resources/dateTimePicker/jquery.datetimepicker.full.min.js"></script>
	
	<style>
	html{
	  scroll-behavior: smooth;
	}
	
	input:-webkit-autofill {
		webkit-box-shadow: 0 0 0 1000px white inset;
		box-shadow: 0 0 0 1000px white inset;
	}
	
	a {
	    text-decoration: none;
	    color: var(--color-dark-beige);
	}
	
	.board-insert-btn {
		display: block;
		float: right;
		margin:20px 15% 30px 0;
		width: 15%;
		height: 40px;
		border-radius: 5px;
		background-color: var(--color-dark-beigie);		
		color: var(--color-light-grey);	
		font-weight: var(--weight-bold);
		transition: all 0.5s;
	}
	
	.board-insert-btn:hover {
		background-color: var(--color-dark-red);
		color: white;
	}
	
	.pin-board {
		clear: both;
	    width : 70%;
	    height: 300px;
	    margin: 30px auto;
	    overflow: auto;
	    overflow-x: hidden;
	}
	
	.pin-board-title {
		color: var(--color-dark-red);
		font-weight: var(--weight-bold);
		padding: 10px 0;
	}
	
	.all-board-title {
		color: var(--color-dark-red);
		font-weight: var(--weight-bold);
		width: 70%;
		margin: 10px auto;
		padding: 0 10px;
	}
	
	.pin-board li {
	    width : 99%;
	    display: flex;
		align-items: center;
		justify-content: flex-start;
		padding: 10px 0;
		background-color: rgba(240, 240, 240, 0.1);
		margin: 5px 0;
		border-radius: 5px;
		border: 1px solid var(--color-dark-beigie);
		font-weight: var(--weight-bold);
		color: var(--color-dark-grey);
		cursor: pointer;
	}
	
	.pin-board li:hover {
		border: 1px solid var(--color-light-blue);
	}
	
	.pin-board-icon {
		margin: 0 10px;
	}
	
	.board-container{
		border: 1px solid var(--color-beigie);
	    border-radius: 20px;
	    width : 70%;
	    box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
	    margin: 0 auto 30px;
	}
	
	.profile {
		width: 40px;
		height: 40px;
		border-radius: 10px;
	}
	
	.board-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 20px 40px;
	}
	
	.board-header-info {
		display: flex;
		align-items: center;
	}
	
	.board-headder-info__memberName {
		margin: 0 20px;
		font-weight: var(--weight-bold);
	}
	
	.board-header-btn {
		cursor: pointer;
		padding-left: 10px;
	}
	
	.board-title {
		font-size: var(--font-small);
		font-weight: var(--weight-bold);
		padding: 5px;
		margin: 0 40px;
		border-bottom: 1px solid var(--color-dark-beigie);
		color: var(--color-dark-grey);
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.f-start {
		justify-content: flex-start;
	}
	
	
	.board-title span {
		color: var(--color-blue);
	}
	
	.board-content{
		margin: 30px 40px;
		font-size: var(--font-micro);
		color: var(--color-dark-grey);	
	}
	
	.board-footer {
		display: flex;
		justify-content: space-between;
		margin: 10px 40px;
		font-size: var(--font-micro);
	}
	
	.board-footer-icon {
		margin-right: 10px;
	}
	
	.board-footer-icon:hover {
		color: var(--color-dark-red);
		cursor: pointer;
	}
	
	.board-footer-info {
		margin-left: 10px;
	}
	
	.board-comment {
	
	}
	
	.comment-input {
		border-top: 1px solid var(--color-dark-beigie);
		padding: 20px 40px;	
		display: flex;
		align-items: center;
		position: relative;
	}
	
	.comment-input input{
		width: 90%;
		height: 40px;
		border: 1px solid var(--color-dark-beigie);
		border-radius: 5px;
		margin-left: 20px;
	}
	
	.comment-input button {
		width: 50px;
		height: 30px;
		position: absolute;
		top: 25px;
		right: 60px;
		border-radius: 5px;
		background-color: var(--color-dark-beigie);		
		color: var(--color-light-grey);	
		transition: all 0.5s;
		font-size: var(--font-micro);
	}
	
	.comment-input button:hover {
		background-color: var(--color-dark-red);	
		color: white;
	}
	
	.sche-date {
		font-weight: var(--weight-bold);
		font-size: 15px;
		color: var(--color-dark-red);
		margin: 10px 40px;
	}
	
	.sche-addr {
		font-weight: var(--weight-bold);
		font-size: 15px;
		color: var(--color-dark-grey);
		margin: 10px 40px;
	}
	
	.sche-date .text, .task-manager .text {
		font-size: 15px;
		color: var(--color-dark-grey);
	}
	
	.sche-alarm {
		font-weight: var(--weight-bold);
		font-size: 15px;
		color: var(--color-light-blue);
	}
		
	.sche-btns {
		margin: 20px auto;
		text-align: center;
	}
	
	.sche-btns button {
		width: 70px;
		height: 35px;
		background-color: var(--color-light-red);
		border-radius: 5px;
		color: white;
		font-weight: var(--weight-bold);
		margin: 0 20px;
		transition: all 0.3s;
	}
	
	.sche-btns button:hover, .sche-btns button.active {
		background-color: var(--color-dark-red);
	}
	
	.btn-green {
		background-color: #def4c6 !important;
	}
	
	.btn-green:hover, .btn-green.active {
		background-color: var(--color-green) !important;
	}
	
	
	.sche-particir, .sche-nonParticir, .vote-particir {
		font-size: var(--font-micro);
		padding: 0 10px;
		cursor: pointer;
	}
	
	.sche-particir, .sche-particir-count, .vote-particir, .vote-particir-count {
		color: var(--color-green) !important;
	}
	
	.sche-nonParticir, .sche-nonParticir-count {
		color: var(--color-dark-red) !important;
	}
	
	.voteContent {
		margin: 0 40px;
		margin-bottom: 30px;
	}
	
	.voteContent-info {
		text-align: right;
		font-size: var(--font-micro);
	}
	
	.anonyVote {
		color: var(--color-light-blue);
		margin-left: 20px;
	} 
	
	.compnoVote{
		color: var(--color-dark-red);
	}
	
	.vote-lists input {
		display: none;
	}
	
	.vote-lists label {
		cursor: pointer;
		width: 15px;
		height: 15px;
		border: 3px solid var(--color-light-red);
		border-radius: 50%;
		position: relative;
		transition: all 0.3s;
		margin-right: 10px;
	}
	
	.vote-lists input:checked + label {
		background-color: var(--color-dark-red);
		border: 3px solid var(--color-dark-red);
	}
	
	.vote-lists img {
		width: 15px;
		height: 15px;
		line-height: 10px;
		position: absolute;
		top: 0;
		right: 0;
	}
	
	.vote-list {
		display: flex;
		align-items: center;
		justify-content: flex-start;
		padding: 5px 10px;
		background-color: rgba(240, 240, 240, 0.2);
		margin: 5px;
		border-radius: 5px;
	}
	
	.vote-btn {
		margin-top: 20px;
		text-align: center;
		transition: all 0.3s;
	}
	
	.vote-btn button {
		width: 70px;
		height: 35px;
		background-color: var(--color-light-red);
		border-radius: 5px;
		color: white;
		font-weight: var(--weight-bold);
		margin: 0 auto;
		transition: all 0.5s;
	}
	
	.vote-btn button.active {
		background-color: var(--color-dark-red);
	}
	
	
	.board-title div[data-hightaskid] {
		font-size: var(--font-micro);
		padding: 5px;
		border: 1px solid var(--color-dark-red);
		border-radius: 5px;
		color: var(--color-dark-red);
	}
	
	.task-manager{
		display: flex;
		font-weight: var(--weight-bold);
		font-size: 13px;
		color: var(--color-blue);
		margin: 10px 40px;
		align-items: center;
	}
	
	.task-manager span {
		margin-right: 10px;
		cursor: pointer;
	}
	
	.d-flex {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	div[data-prioriy] {
		font-size: var(--font-micro);
		color: var(--color-green);
		font-weight: var(--weight-bold);
	}
	
	div[data-state] {
		margin: 0 40px;
		text-align: left;
	}
	
	div[data-state] button{
		width: 50px;
		height: 10px;
		background-color: var(--color-dark-beigie);
		padding: 10px;
		border-radius: 5px;
		color: white;
		font-weight: var(--weight-bold);
		line-height: 10px;
	}
	
	div[data-processivity] {
		display: flex;
		align-items: center;
		color: var(--color-green);
	}
	
	.processivity {
		width: 150px;
		height: 7px;
		border-radius:2px;
		background-color: var(--color-light-white);
		margin-right: 10px;
	}
	
	.processivity-value {
		width: 1%;
		height: 7px;
		border-radius:2px;
		background-color: var(--color-green);
	}
	
	.sub-task-lists {
		margin: 0 40px 30px 40px;
	}
	
	.sub-task-lists-title {
		margin: 10px 0;
		font-size: var(--font-micro);
		font-weight: var(--weight-bold);
		color: var(--color-dark-grey);
	}
	
	.sub-task-item {
		display: flex;
		align-items: center;
		padding: 5px 10px;
		background-color: rgba(240, 240, 240, 0.2);
		justify-content: flex-start;
		margin: 5px 0;
		border-radius: 5px;
		text-align: center;
	}
	
	.sub-state {
		width: 50px;
		height: 7px;
		background-color: var(--color-blue);
		padding: 10px;
		border-radius: 5px;
		color: white;
		font-weight: var(--weight-bold);
		font-size: var(--font-micro);
		line-height: 7px;
		margin-right: 20px;
	}
	
	.modalBoard{
	    top:0;
	    left:0;
	}
	
	.insert-board-modal {
		border: 1px solid var(--color-dark-beigie);
	    border-radius: 20px;
	    width : 50%;
	    height: 850px;
	    box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
	    margin: 5px auto;
	    background-color: white;
	}
	
	.insert-board-modal-header {
		margin: 30px 30px 0 30px;
	}
	
	.insert-board-modal-title {
		display: flex;
		align-items: center;
		justify-content: space-between;
		font-weight: var(--weight-bold);
		color: var(--color-dark-grey);
	}
	
	.insert-board-list {
		display: flex;
		align-items: center;
		justify-content: space-between;
		text-align: center;
	}
	
	.insert-list-item {
		flex-grow: 1;
		cursor: pointer;
		transition: all 0.5s;
		margin-top: 15px;
		font-size: var(--font-micro);
	    color: var(--color-dark-grey);
	    padding: 5px 0;
	    border-bottom: 2px solid var(--color-dark-beigie);
	}
	
	.insert-list-item:hover {
		border-bottom: 2px solid var(--color-dark-red);
	}
	
	.dis-none {
		display: none;
	}
	
	.d-b {
		display: block !important;
	}
	.insert-board-area {
		overflow: scroll;
		overflow-x: hidden;
		max-height: 550px;
	}
	
	.insert-board-area::-webkit-scrollbar, .pin-board::-webkit-scrollbar, .bookmark-board-contets::-webkit-scrollbar {
	    width: 10px;
	  }
	  .insert-board-area::-webkit-scrollbar-thumb, .pin-board::-webkit-scrollbar-thumb, .bookmark-board-contets::-webkit-scrollbar-thumb {
	    background-color: #2f3542;
	    border-radius: 10px;
	    background-clip: padding-box;
	    border: 2px solid transparent;
	    background-color: var(--color-dark-beigie);
	  }
	  .insert-board-area::-webkit-scrollbar-track, .pin-board::-webkit-scrollbar-track, .bookmark-board-contet::-webkit-scrollbar-track {
	    background-color: grey;
	    border-radius: 10px;
	    box-shadow: inset 0px 0px 5px white;
	    background-color: var(--color-dark-beigie);
	  }
	
	.board-form {
		margin: 10px 30px 0;
		color: var(--color-dark-grey);
		
	}
	
	.board-form-title {
		width: 100%;
		height: 50px;
		border-bottom: 1px solid var(--color-dark-beigie);
		padding: 0 10px;
		margin-bottom: 20px;
	}
	
	.ck.ck-list__item .ck-button {
	    width: 90% !important;
	}
	
	.ck-editor__editable {
	    min-height: 700px;
	}
	
	.modal-footer {
		margin: 0 30px;
		display: block;
		text-align: right;
	}
	
	.modal-footer-select {
		width : 200px;
		height : 40px;
		border : 1px solid var(--color-dark-beigie);
	}
	
	.modal-footer-btn {
		width: 100px;
		height: 50px;
		border-radius: 5px;
		background-color: var(--color-dark-beigie);		
		color: var(--color-light-grey);	
		transition: all 0.5s;
		font-size: var(--font-micro);
		margin-bottom: 20px;
	}
	
	.modal-footer-btn:hover {
		background-color: var(--color-dark-red);	
		color: white;
	}
	
	.board-state {
		text-align: left;
	}
	
	.board-state label {
		width: 70px;
		height: 14px;
		background-color: var(--color-dark-beigie);
		padding: 10px;
		border-radius: 5px;
		color: white;
		font-weight: var(--weight-bold);
		line-height: 14px;
		cursor: pointer;
		text-align: center;
		margin: 0 10px;
		margin-bottom: 20px;
	}
	
	.board-state input:checked + label {
		background-color: var(--color-dark-red);
		border: 3px solid var(--color-dark-red);
	}
	
	.add-taskManager-select{
		width: 130px;
		height: 30px;
		border: 1px solid var(--color-dark-beigie);
		background-color: white;
		color: var(--color-dark-grey);
		font-size: var(--font-micro);
		margin-left: 20px;
	}
	
	.add-taskManager-select option:disabled {
		color: var(--color-light-white);
	}
	
	.board-taskManager {
		margin-bottom: 20px;
	}
	
	.board-taskManager span {
		margin-right: 10px;
	}
	
	.add-manager-btn {
		text-decoration: underline;
		color: var(--color-dark-red);
		cursor: pointer;
	}
	
	.startDate, .endDate {
		width: 200px;
		height: 30px;
		border: 1px solid var(--color-dark-beigie) !important;
		color: var(--color-dark-grey);
		font-size: var(--font-micro);
		margin-right: 20px;
	}
	
	.progress-bar {
		background-color: var(--color-light-white);
		width: 300px;
		height: 20px;
		border-radius:5px;
		margin: 10px;
	}
	
	.progress-bar-size {
		width: 1%;
		height: 20px;
		border-radius:5px;
		background-color: var(--color-green);
		transition: all 0.5s;
	}
	
	.progress-value {
		width: 20px;
	}
	
	.js-progress {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding-right: 200px;
		margin: 10px 0;
	}
	
	.board-progress {
		display: flex;
		align-items: center;
	}
	
	.select-priority {
		display: flex;
		align-items: center;
	}
	
	select[name=priority] {
		width: 100px;
		height: 30px;
		border: 1px solid var(--color-dark-beigie);
		background-color: white;
		color: var(--color-dark-grey);
		font-size: var(--font-micro);
		margin-left: 20px;
	}
	
	.board-sub-task {
		margin: 20px 30px;
	}
	
	.add-sub-task-btn, .add-vote-list-btn {
		text-decoration: underline;
		color: var(--color-blue);
		cursor: pointer;
	}
	
	.sub-task-manager input, .sub-task-manager select {
		width: 200px;
		height: 30px;
		border: 1px solid var(--color-dark-beigie) !important;
		color: var(--color-dark-grey);
		font-size: var(--font-micro);
	}
	
	.board-sub-task-title {
		color: var(--color-dark-grey);
		font-weight: var(--weight-bold);
		font-size: var(--font-small);
		margin-bottom: 10px;
	}
	
	select[name=alarmDateCode] {
		width: 200px;
		height: 30px;
		border: 1px solid var(--color-light-red);
		background-color: white;
		color: var(--color-dark-grey);
		font-size: var(--font-micro);
		margin-left: 20px;
	}
	
	input[name=scheAddr] {
		border-bottom: 1px solid var(--color-dark-beigie);
		padding-left: 10px;
		font-size: var(--font-micro);
		color: var(--color-dark-grey);
		width: 350px;
	}
	
	#scheAddrDetail {
		border-bottom: 1px solid var(--color-dark-beigie);
		font-size: var(--font-micro);	
		color: var(--color-dark-grey);
		width: 250px;
		padding-left: 10px;
	}
	
	.form-check {
		margin-right: 30px;
	}
	
	input[name=listContent] {
		display: block;
		width: 80%;
		margin: 5px auto;
		height: 40px;
		border-radius: 5px;
		background-color: var(--color-beigie);
		padding: 0 20px;
	}
	
	div[data-boardmodal] {
		position: fixed;
		width: 100vw;
		height: 100vh;
		font-size: 12px;
		left: 0;
		top: 0;
		background-color: rgba(0,0,0,0.1);
	}
	
	.board-modal-content {
		position: absolute;
		width: 6%;
		height: 10%;
		right: 4%;
		top: 4%;
		background-color: white;
		border: 1px solid var(--color-dark-beigie);
		border-radius: 10px;
		padding: 5px 15px;
		z-index: 10;
	}
	
	.board-modal-content p{
		margin-bottom: 5px;
		padding: 5px;
		color: var(--color-dark-grey);
		cursor: pointer;
	}
	
	.board-modal-content p:hover {
		background-color: var(--color-beigie);
	}
	
	.bookmark-board {
		position: fixed;
		width: 360px;
	    margin: 0 auto;
	    top: 220px;
	}
	
	.bookmark-board-title {
		display: flex;
		align-items: center;
		justify-content: flex-start;
		padding: 10px;
		color: var(--color-dark-red);
		font-weight: var(--weight-bold);
	}
	
	.bookmark-board-contets {
		border: 1px solid var(--color-beigie);
	    border-radius: 20px;
	    box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
    	overflow: auto;
    	overflow-x: hidden;
    	padding: 20px 0;
    	min-height: 250px;
    	max-height: 350px;
	}
	
	.bookmark-board-contets ul {
		display: flex;
		flex-direction: column;
		align-items: center;	
	}
	
	.bookmark-board-contets li {
	    width : 90%;
	    display: flex;
		align-items: center;
		justify-content: flex-start;
		padding: 10px 0;
		background-color: rgba(240, 240, 240, 0.1);
		margin: 5px 0;
		border-radius: 5px;
		border: 1px solid var(--color-dark-beigie);
		font-weight: var(--weight-bold);
		color: var(--color-dark-grey);
		cursor: pointer;
	}
	
	.bookmark-board-contets li:hover {
		border: 1px solid var(--color-light-blue);
	}
	
	.m-bt {
		margin-bottom: 10px;
	}
	</style>
</head>
<body>
	<!-- ckeditor -->
	<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
	<script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/super-build/ckeditor.js"></script>
	<!-- 사진 업로드를 위한 ckfinder -->
	<script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
	
		<!--부드러운 스크롤 효과-->
		<script>	
			$(document).ready(function(){
			    $('a[href^="#"]').on('click',function (e) {
			        e.preventDefault();
	
			        let target = this.hash;
					let $target = $(target);
					
			        $('#main').stop().animate({
			            'scrollTop': main.scrollTop + document.querySelector(target).getBoundingClientRect().top
			        }, 500, 'swing');
			    });
			});
		</script>
	
	<!-- 게시글 출력 HTML -->
	<div style="display : flex;">
		<div style="width: 65%;">
			<button type="button" class="board-insert-btn" data-bs-toggle="modal" data-bs-target="#boardInsertModal">게시글 작성</button>
			<!-- 상단 고정 게시글 -->
			<c:if test="${pinBoardInfo.size() ne 0 }">
				<div class="pin-board">
					<div class="pin-board-title">상단고정 ${pinBoardInfo.size() }</div>
					<ul>
						<c:forEach items="${pinBoardInfo }" var="pinBoard">
							<li>
								<a href="#${pinBoard.boardType }${pinBoard.prjBoardId}" style="width: 100%">
									<img class="pin-board-icon" src="${pageContext.request.contextPath }/resources/icon/thumbtack-solid.svg" alt="상단고정 아이콘" style="margin-left: 20px;">
									<img class="pin-board-icon" src="${pageContext.request.contextPath }/resources/icon/${pinBoard.boardIconName}" alt="게시글 아이콘">
									<!-- <img alt="게시글 아이콘" src=""> -->
									<span>${pinBoard.prjBoardTitle }</span>
								</a>	
							</li>						
						</c:forEach>
					</ul>
				</div>			
			</c:if>
			<!-- 게시글 조회 -->
			<div class="all-board-title" style="clear: both;">전체</div>
			<c:forEach items="${boards }" var="board">
				<!-- C5 일반 게시글 -->
				<c:if test="${board.boardType eq 'C5'}">
					<div data-list="board" data-type="${board.boardType}" data-id="${board.prjBoardId }" class="board-container" id="${board.boardType }${board.prjBoardId }">
						<div class="board-header">
							<div class="board-header-info">
								<c:if test="${board.realProfilePath eq null }">
									<img src="${pageContext.request.contextPath }/resources/img/user.png" alt="기본 프로필 사진" class="profile">
								</c:if>
								<c:if test="${board.realProfilePath ne null }">
									<img src="${pageContext.request.contextPath}/images/${board.realProfilePath }" alt="기본 프로필 사진" class="profile">
								</c:if>
								<div class="board-headder-info__memberName">${board.memberName } </div>
								<fmt:formatDate value="${board.prjBoardRegdate }" pattern="yyyy-MM-dd hh:mm"/>
							</div>
							<div>
							<img class="board-header-btn" src="${pageContext.request.contextPath }/resources/icon/ellipsis-vertical-solid.svg">
							</div>
						</div>
						<div class="board-title">
							<div>
								<span>[일반]</span> ${board.prjBoardTitle }
							</div>
						</div>
						<div class="board-content">
							${board.prjBoardSubject }
						</div>
						<div class="board-footer">
							<div >
								<span class="board-footer-icon"><img alt="좋아요 아이콘" src="${pageContext.request.contextPath }/resources/icon/face-laugh-wink-solid.svg"> 좋아요</span>
								<c:if test="${board.bookmarkByMember eq 1 }">
									<span class="board-footer-icon" data-bookmark="yes"><img alt="북마크 아이콘" src="${pageContext.request.contextPath }/resources/icon/bookmark-solid.svg"> 북마크</span>								
								</c:if>
								<c:if test="${board.bookmarkByMember eq 0 }">
									<span class="board-footer-icon" data-bookmark="no"><img alt="북마크 아이콘" src="${pageContext.request.contextPath }/resources/icon/bookmark-regular.svg"> 북마크</span>								
								</c:if>
								
							</div>
							<div>
								<span class="board-footer-info">댓글 7</span>
								<span class="board-footer-info">좋아요 14</span>
							</div>
						</div>
						<c:if test="ㄴㅇㄹ">
							<div>
								댓글 더보기
							</div>
							<!-- for each로 최신 댓글 2개만 -->
								<div class="board-comment">
									<div>
										<img alt="#" src="#">
										<div>
											<div>
												회원정보
											</div>
											<div>
												댓글내용
											</div>
										</div>
									</div>
									<div>
										<a href="#">수정</a>
										<a href="#">삭제</a>
									</div>
								</div>
							<!-- 여기까지 -->	
						</c:if>
						<div class="comment-input">
							<c:if test="${memberInfo.realProfilePath eq null }">
								<img src="${pageContext.request.contextPath }/resources/img/user.png" alt="기본 프로필 사진" class="profile">
							</c:if>
							<c:if test="${memberInfo.realProfilePath ne null }">
								<img src="${pageContext.request.contextPath}/images/${memberInfo.realProfilePath }" alt="기본 프로필 사진" class="profile">
							</c:if>
								<input type="text" placeholder="댓글을 입력해주세요."><button type="button">등록</button>
						</div>
						<!-- board 버튼 클릭 시 모달 -->
						<div class="d-none" data-boardmodal>
							<div class="board-modal-content">
								<c:if test="${board.pinYn eq 'A2' or board.pinYn eq null}">
									<p data-type="pinY">상단고정</p>
								</c:if>
								<c:if test="${board.pinYn eq 'A1'}">
									<p data-type="pinN">상단고정 해제</p>
								</c:if>
								<p data-type="update">게시글 수정</p>
								<p data-type="delete">게시글 삭제</p>
							</div>			
						</div>
					</div>
				</c:if>
	
				<!-- C6 일정-->
				<c:if test="${board.boardType eq 'C6'}">
					<div data-list="board" data-type="${board.boardType}" data-id="${board.prjBoardId }" class="board-container" id="${board.boardType }${board.prjBoardId }">
						<div class="board-header">
							<div class="board-header-info">
								<c:if test="${board.realProfilePath eq null }">
									<img src="${pageContext.request.contextPath }/resources/img/user.png" alt="기본 프로필 사진" class="profile">
								</c:if>
								<c:if test="${board.realProfilePath ne null }">
									<img src="${pageContext.request.contextPath}/images/${board.realProfilePath }" alt="기본 프로필 사진" class="profile">
								</c:if>
								<div class="board-headder-info__memberName">${board.memberName } </div>
								<fmt:formatDate value="${board.prjBoardRegdate }" pattern="yyyy-MM-dd hh:mm"/>
							</div>
							<div>
							<img class="board-header-btn" src="${pageContext.request.contextPath }/resources/icon/ellipsis-vertical-solid.svg">
							</div>
						</div>
						<div class="board-title">
							<div>
								<span>[일정]</span> ${board.prjBoardTitle }
							</div>
							<div>
								<span class="sche-particir">참석 <span class="sche-particir-count"></span></span>
								<span class="sche-nonParticir">불참 <span class="sche-nonParticir-count"></span></span>
							</div>
						</div>
						<div class="d-flex" style="margin-right: 40px;">
							<div class="sche-date">
								<span class="text">기간 : </span>
								<span data-start></span>
								<span> ~ </span>
								<span data-end></span>
							</div>
							<div class="sche-alarm">
								<span></span>
							</div>
						</div>
						<div class="d-flex" style="margin-right: 40px;">
							<div class="sche-addr">
								<span class="text">장소 : </span>
							</div>
						</div>
						<div class="board-content">
							<div>
								${board.prjBoardSubject }
							</div>
						</div>
						<div class="sche-btns">
							<button type="button" class="btn-green" name="attend">참석</button>
							<button type="button" name="nonAttend">불참</button>
						</div>
						<div class="board-footer">
							<div >
								<span class="board-footer-icon"><img alt="좋아요 아이콘" src="${pageContext.request.contextPath }/resources/icon/face-laugh-wink-solid.svg"> 좋아요</span>
								<c:if test="${board.bookmarkByMember eq 1 }">
									<span class="board-footer-icon" data-bookmark="yes"><img alt="북마크 아이콘" src="${pageContext.request.contextPath }/resources/icon/bookmark-solid.svg"> 북마크</span>
								</c:if>
								<c:if test="${board.bookmarkByMember eq 0 }">
									<span class="board-footer-icon" data-bookmark="no"><img alt="북마크 아이콘" src="${pageContext.request.contextPath }/resources/icon/bookmark-regular.svg"> 북마크</span>								
								</c:if>
							</div>
							<div>
								<span class="board-footer-info">댓글 7</span>
								<span class="board-footer-info">좋아요 14</span>
							</div>
						</div>
						<c:if test="ㄴㅇㄹ">
							<div>
								댓글 더보기
							</div>
							<!-- for each로 최신 댓글 2개만 -->
								<div class="board-comment">
									<div>
										<img alt="#" src="#">
										<div>
											<div>
												회원정보
											</div>
											<div>
												댓글내용
											</div>
										</div>
									</div>
									<div>
										<a href="#">수정</a>
										<a href="#">삭제</a>
									</div>
								</div>
							<!-- 여기까지 -->
						</c:if>
						<div class="comment-input">
							<c:if test="${memberInfo.realProfilePath eq null }">
								<img src="${pageContext.request.contextPath }/resources/img/user.png" alt="기본 프로필 사진" class="profile">
							</c:if>
							<c:if test="${memberInfo.realProfilePath ne null }">
								<img src="${pageContext.request.contextPath}/images/${memberInfo.realProfilePath }" alt="기본 프로필 사진" class="profile">
							</c:if>
								<input type="text" placeholder="댓글을 입력해주세요."><button type="button">등록</button>
						</div>
						<!-- board 버튼 클릭 시 모달 -->
						<div class="d-none" data-boardmodal>
							<div class="board-modal-content">
								<c:if test="${board.pinYn eq 'A2' or board.pinYn eq null}">
									<p data-type="pinY">상단고정</p>
								</c:if>
								<c:if test="${board.pinYn eq 'A1'}">
									<p data-type="pinN">상단고정 해제</p>
								</c:if>
								<p data-type="update">게시글 수정</p>
								<p data-type="delete">게시글 삭제</p>
							</div>			
						</div>
					</div>
				</c:if>
				
				<!-- C7 투표 -->
				<c:if test="${board.boardType eq 'C7'}">
					<div data-list="board" data-type="${board.boardType}" data-id="${board.prjBoardId }" class="board-container" id="${board.boardType }${board.prjBoardId }">
						<div class="board-header">
							<div class="board-header-info">
								<c:if test="${board.realProfilePath eq null }">
									<img src="${pageContext.request.contextPath }/resources/img/user.png" alt="기본 프로필 사진" class="profile">
								</c:if>
								<c:if test="${board.realProfilePath ne null }">
									<img src="${pageContext.request.contextPath}/images/${board.realProfilePath }" alt="기본 프로필 사진" class="profile">
								</c:if>
								<div class="board-headder-info__memberName">${board.memberName } </div>
								<fmt:formatDate value="${board.prjBoardRegdate }" pattern="yyyy-MM-dd hh:mm"/>
							</div>
							<div>
							<img class="board-header-btn" src="${pageContext.request.contextPath }/resources/icon/ellipsis-vertical-solid.svg">
							</div>
						</div>
						<div class="board-title">
							<div>
								<span>[투표]</span> ${board.prjBoardTitle }						
							</div>
							<div>
								<span class="vote-particir">참여인원 <span class="vote-particir-count"></span></span>
							</div>
						</div>
						<div class="sche-date">
							<span class="text">투표 마감일 : </span>
							<span> ~ </span>
							<span data-end></span>
						</div>
						<div class="board-content">
							<div>
								${board.prjBoardSubject }
							</div>
						</div>
						<div class="voteContent">
							<div class="voteContent-info">
								<span class="compnoVote"></span>
								<span class="anonyVote"></span>
							</div>
							<div class="vote-lists">
								<ul>
								</ul>
							</div>
							<div class="vote-btn">
								<button type="button" disabled name="voteAttend" class="dis-none d-b">투표</button>
								<button type="button" name="voteNonAttend" class="dis-none">투표취소</button>
							</div>
						</div>
						<div class="board-footer">
							<div >
								<span class="board-footer-icon"><img alt="좋아요 아이콘" src="${pageContext.request.contextPath }/resources/icon/face-laugh-wink-solid.svg"> 좋아요</span>
								<c:if test="${board.bookmarkByMember eq 1 }">
									<span class="board-footer-icon" data-bookmark="yes"><img alt="북마크 아이콘" src="${pageContext.request.contextPath }/resources/icon/bookmark-solid.svg"> 북마크</span>								
								</c:if>
								<c:if test="${board.bookmarkByMember eq 0 }">
									<span class="board-footer-icon" data-bookmark="no"><img alt="북마크 아이콘" src="${pageContext.request.contextPath }/resources/icon/bookmark-regular.svg"> 북마크</span>								
								</c:if>
							</div>
							<div>
								<span class="board-footer-info">댓글 7</span>
								<span class="board-footer-info">좋아요 14</span>
							</div>
						</div>
						<c:if test="ㄴㅇㄹ">
							<div>
								댓글 더보기
							</div>
							<!-- for each로 최신 댓글 2개만 -->
								<div class="board-comment">
									<div>
										<img alt="#" src="#">
										<div>
											<div>
												회원정보
											</div>
											<div>
												댓글내용
											</div>
										</div>
									</div>
									<div>
										<a href="#">수정</a>
										<a href="#">삭제</a>
									</div>
								</div>
							<!-- 여기까지 -->	
						</c:if>
						<div class="comment-input">
							<c:if test="${memberInfo.realProfilePath eq null }">
								<img src="${pageContext.request.contextPath }/resources/img/user.png" alt="기본 프로필 사진" class="profile">
							</c:if>
							<c:if test="${memberInfo.realProfilePath ne null }">
								<img src="${pageContext.request.contextPath}/images/${memberInfo.realProfilePath }" alt="기본 프로필 사진" class="profile">
							</c:if>
								<input type="text" placeholder="댓글을 입력해주세요."><button type="button">등록</button>
						</div>
						<!-- board 버튼 클릭 시 모달 -->
						<div class="d-none" data-boardmodal>
							<div class="board-modal-content">
								<c:if test="${board.pinYn eq 'A2' or board.pinYn eq null}">
									<p data-type="pinY">상단고정</p>
								</c:if>
								<c:if test="${board.pinYn eq 'A1'}">
									<p data-type="pinN">상단고정 해제</p>
								</c:if>
								<p data-type="update">게시글 수정</p>
								<p data-type="delete">게시글 삭제</p>
							</div>			
						</div>
					</div>
				</c:if>
				
				<!-- C8 업무 -->
				<c:if test="${board.boardType eq 'C8'}">
					<div data-list="board" data-type="${board.boardType}" data-id="${board.prjBoardId }" class="board-container" id="${board.boardType }${board.prjBoardId }">
						<div class="board-header">
							<div class="board-header-info">
								<c:if test="${board.realProfilePath eq null }">
									<img src="${pageContext.request.contextPath }/resources/img/user.png" alt="기본 프로필 사진" class="profile">
								</c:if>
								<c:if test="${board.realProfilePath ne null }">
									<img src="${pageContext.request.contextPath}/images/${board.realProfilePath }" alt="기본 프로필 사진" class="profile">
								</c:if>
								<div class="board-headder-info__memberName">${board.memberName } </div>
								<fmt:formatDate value="${board.prjBoardRegdate }" pattern="yyyy-MM-dd hh:mm"/>
							</div>
							<div>
							<img class="board-header-btn" src="${pageContext.request.contextPath }/resources/icon/ellipsis-vertical-solid.svg">
							</div>
						</div>
						<div class="board-title">
							<div>
								<span>[업무]</span> ${board.prjBoardTitle }
							</div>
							<div data-hightaskid></div>
						</div>
						<div class="sche-date d-flex">
							<div>
								<span class="text">기간 : </span>
								<span data-start></span>
								<span> ~ </span>
								<span data-end></span>
							</div>
							<div data-processivity>
								<div class="processivity">
									<div class="processivity-value"></div>
								</div>
								<span data-processivityvalue></span>
							</div>
						</div>
						<div class="d-flex" style="margin-right: 40px;">
							<div class="task-manager"> 
								<span class="text">담당자 : </span>
							</div>
							<div data-prioriy></div>
						</div>
						<div data-state>
							<button type="button" value="G1">요청</button>
							<button type="button" value="G2">진행</button>
							<button type="button" value="G3">피드백</button>
							<button type="button" value="G4">완료</button>
							<button type="button" value="G5">보류</button>
						</div>
						<div class="board-content">
							<div>
								${board.prjBoardSubject }
							</div>
						</div>
						<div class="sub-task-lists">
							<div class="sub-task-lists-title">하위업무 <span data-subtaskcount></span></div>
							<div class="sub-task-list">
							</div>
						</div>
						<div class="board-footer">
							<div >
								<span class="board-footer-icon"><img alt="좋아요 아이콘" src="${pageContext.request.contextPath }/resources/icon/face-laugh-wink-solid.svg"> 좋아요</span>
								<c:if test="${board.bookmarkByMember eq 1 }">
									<span class="board-footer-icon" data-bookmark="yes"><img alt="북마크 아이콘" src="${pageContext.request.contextPath }/resources/icon/bookmark-solid.svg"> 북마크</span>								
								</c:if>
								<c:if test="${board.bookmarkByMember eq 0 }">
									<span class="board-footer-icon" data-bookmark="no"><img alt="북마크 아이콘" src="${pageContext.request.contextPath }/resources/icon/bookmark-regular.svg"> 북마크</span>								
								</c:if>
							</div>
							<div>
								<span class="board-footer-info">댓글 7</span>
								<span class="board-footer-info">좋아요 14</span>
							</div>
						</div>
						<c:if test="ㄴㅇㄹ">
							<div>
								댓글 더보기
							</div>
							<!-- for each로 최신 댓글 2개만 -->
								<div class="board-comment">
									<div>
										<img alt="#" src="#">
										<div>
											<div>
												회원정보
											</div>
											<div>
												댓글내용
											</div>
										</div>
									</div>
									<div>
										<a href="#">수정</a>
										<a href="#">삭제</a>
									</div>
								</div>
							<!-- 여기까지 -->	
						</c:if>
						<div class="comment-input">
							<c:if test="${memberInfo.realProfilePath eq null }">
								<img src="${pageContext.request.contextPath }/resources/img/user.png" alt="기본 프로필 사진" class="profile">
							</c:if>
							<c:if test="${memberInfo.realProfilePath ne null }">
								<img src="${pageContext.request.contextPath}/images/${memberInfo.realProfilePath }" alt="기본 프로필 사진" class="profile">
							</c:if>
								<input type="text" placeholder="댓글을 입력해주세요."><button type="button">등록</button>
						</div>
						<!-- board 버튼 클릭 시 모달 -->
						<div class="d-none" data-boardmodal>
							<div class="board-modal-content">
								<c:if test="${board.pinYn eq 'A2' or board.pinYn eq null}">
									<p data-type="pinY">상단고정</p>
								</c:if>
								<c:if test="${board.pinYn eq 'A1'}">
									<p data-type="pinN">상단고정 해제</p>
								</c:if>
								<p data-type="update">게시글 수정</p>
								<p data-type="delete">게시글 삭제</p>
							</div>			
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>	
		<!-- 게시글 조회 끝 -->
		<div style="width: 25%;">
			<div class="bookmark-board">
				<div class="bookmark-board-title">북마크</div>
				<div class="bookmark-board-contets">
					<ul>
						<c:if test="${bookmarkList.size() eq 0}">
							<span style="font-size: var(--font-micro);">북마크 된 게시글이 없습니다.</span>
						</c:if>
						<c:if test="${bookmarkList ne null}">
							<c:forEach items="${bookmarkList }" var="bookmark">
								<li>
									<a href="#${bookmark.boardType }${bookmark.prjBoardId}" style="width: 100%">
										<img class="pin-board-icon" alt="북마크 아이콘" src="${pageContext.request.contextPath }/resources/icon/bookmark-solid.svg" style="margin-right: 10px;">
										<img class="pin-board-icon" src="${pageContext.request.contextPath }/resources/icon/${bookmark.boardIconName}" alt="게시글 아이콘">
										<!-- <img alt="게시글 아이콘" src=""> -->
										<span>${bookmark.prjBoardTitle }</span>									
									</a>
								</li>						
							</c:forEach>						
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- 모달 페이지 -->
	<script >
		//모달페이지 출력
		$('.board-header-btn').on('click', function(e) {
			let modal = $(e.currentTarget).closest('.board-container').find('div[data-boardmodal]');
			let modalContent = modal.children('.board-modal-content');
			let x = e.clientX + 15;
			let y = e.clientY + 5;
			
			modalContent.css('top', y + 'px');
			modalContent.css('left',x + 'px');
			modal.addClass('d-b');
		});
		
		//여백 누르면 모달페이지 종료
		$('div[data-boardmodal]').on('click', function(e) {
			$(e.currentTarget).removeClass('d-b');
		});
		
		$('.board-modal-content p').on('click', function(e) {
			e.stopPropagation();
			let boardContainer = $(e.currentTarget).closest('.board-container');
			let boardId = boardContainer.data('id');
			let prjId = '${projectInfo.projectId}';
			let type = $(e.currentTarget).data('type');
			
			if(type == 'pinY') {
				if(confirm('상단게시글에 고정하시겠습니까?')) {
					location.href='${pageContext.request.contextPath}/updatePin?projectId=' + prjId + '&prjBoardId=' + boardId + '&pinYn=A1';						
				}
			}else if(type == 'pinN') {
				if(confirm('상단게시글 고정을 해제 하시겠습니까?')) {
					location.href='${pageContext.request.contextPath}/updatePin?projectId=' + prjId + '&prjBoardId=' + boardId + '&pinYn=A2';	
				}
			}else if(type == 'update') {
				console.log(boardContainer.html);
			}else if(type == 'delete') {
				
			}
		});
	</script>
	
	<!-- 게시글 출력 SCRIPT -->
	<script>
		// 게시글 조회
		$(window).on('DOMContentLoaded', function() {
			let boardList = $('[data-list="board"]');
			
			for(let i=0; i<boardList.length; i++) {
				if (boardList[i].dataset.type == 'C6') {
					//일정
					$.ajax({
						url : '${pageContext.request.contextPath}/getScheInfo',
						type : 'GET',
						data : {'prjBoardId': boardList[i].dataset.id, 'memberId': '${memberInfo.memberId}', 'projectId': '${projectInfo.projectId}' },
						success : function(sche) {
							let startDate = $(boardList[i]).find('span[data-start]');
							let endDate = $(boardList[i]).find('span[data-end]');
							let alarmSpan = $(boardList[i]).find('.sche-alarm').children('span');
							let addrSpan = $(boardList[i]).find('.sche-addr');
							let attendYesCount = $(boardList[i]).find('.sche-particir-count');
							let attendNoCount = $(boardList[i]).find('.sche-nonParticir-count');
							let attendBtn = $(boardList[i]).find('button[name="attend"]');
							let nonAttendBtn = $(boardList[i]).find('button[name="nonAttend"]');
							
			                endDate.text(sche.endDate);
			                //알림 설정 여부
			                if(sche.alarmDateCodeLiteral != null) {
			                	alarmSpan.text(sche.alarmDateCodeLiteral);	
			                }
			                //장소 설정 여부
			                if(sche.scheAddr != null) {
			                	$(addrSpan).append('<span> ' + sche.scheAddr + sche.scheAddrDetail + '</span>');
			                }else {
			                	$(addrSpan).empty();
			                }
			                //참석 인원 값
			                attendYesCount.text(sche.attendanceYes);
			                attendNoCount.text(sche.attendanceNo);
			                
			                //일정 참여 여부
			                if(sche.myAttendance == 'A1') {
			                	attendBtn.attr('class', 'btn-green active');
			                } else if(sche.myAttendance == 'A2'){
			                	nonAttendBtn.attr('class', 'active');
			                }
							
			                
						}, error : function(reject) {
							console.log(reject);
						}
					})
				}else if (boardList[i].dataset.type == 'C7') {
					//투표
					$.ajax({
						url : '${pageContext.request.contextPath}/getVoteInfo',
						type : 'GET',
						data : {'prjBoardId': boardList[i].dataset.id, 'prjParticirId': '${particirInfo.prjParticirId }'},
						success : function(voteData) {
							let endDate = $(boardList[i]).find('span[data-end]');
							let compnoVote = $(boardList[i]).find('.compnoVote');
							let anonyVote = $(boardList[i]).find('.anonyVote');
							let voteList = $(boardList[i]).find('.vote-lists ul');
							let voteParticirCount = $(boardList[i]).find('.vote-particir-count');
							let attendBtn = $(boardList[i]).find('button[name="voteAttend"]');
							let nonAttendBtn = $(boardList[i]).find('button[name="voteNonAttend"]');
							
							// 종료일
							endDate.text(voteData.voteInfo[0].endDate);
							// 복수 투표 여부
							if (voteData.voteInfo[0].compnoVote == 'A1') {
								compnoVote.text('복수 투표');
							} else if (voteData.voteInfo[0].compnoVote == 'A2') {
								compnoVote.text('');
							}
							// 익명 투표 여부
							if (voteData.voteInfo[0].anonyVote == 'A1') {
								anonyVote.text('익명 투표');
							} else if (voteData.voteInfo[0].anonyVote == 'A2') {
								anonyVote.text('');
							}
							// 투표 참여 인원
							voteParticirCount.text(voteData.voteInfo[0].voteAttendance);	
							
							// 투표 항목
							for (let j = 0; j < voteData.voteList.length; j++) {
								//li 태그 생성
								let li = $('<li class="vote-list">');
								let checkbox = $('<input>').attr('onchange', 'checkBtn(this)');
								let label = $('<label>');
								let img = $('<img src="${pageContext.request.contextPath }/resources/icon/check-solid.svg">');
								
								checkbox.attr('type', 'checkbox').attr('id', boardList[i].dataset.id + '-' + voteData.voteList[j].listId);
								label.attr('for', boardList[i].dataset.id + '-' + voteData.voteList[j].listId);
								
								label.append(img);
								li.append(checkbox);
								li.append(label);
								li.append(voteData.voteList[j].listContent);
								
								voteList.append(li);
							}
							// 투표 여부 확인
							if(voteData.voteListMine.length != 0) {
								attendBtn.removeClass('d-b');
								nonAttendBtn.addClass('d-b');
								nonAttendBtn.addClass('active');
								
								for(let j=0; j<voteData.voteListMine.length; j++) {
									$('#' + boardList[i].dataset.id + '-' + voteData.voteListMine[j].listId).prop('checked',true);
									voteList.find('.vote-list input').prop('disabled', true);
								}
							}
						}, error : function(reject) {
							console.log(reject);
						}
					});
				} else if (boardList[i].dataset.type == 'C8') {
					//업무
					$.ajax({
						url : '${pageContext.request.contextPath}/getTaskInfo',
						type : 'GET',
						data : {'prjBoardId' : boardList[i].dataset.id},
						success : function(taskData) {
							// 상위 업무 정보
							let highTaskId = $(boardList[i]).find('div[data-hightaskid]');
							let startDate = $(boardList[i]).find('span[data-start]');
			                let endDate = $(boardList[i]).find('span[data-end]');
			                let state = $(boardList[i]).find('div[data-state]');
			                let processivity = $(boardList[i]).find('div[data-processivity]');
			                let processivityValueDiv = $(boardList[i]).find('.processivity-value');
			                let prioriy = $(boardList[i]).find('div[data-prioriy]');
			                let taskManagers = $(boardList[i]).find('.task-manager');
			                let processivityValue = $(boardList[i]).find('span[data-processivityvalue]');
							let highTask = taskData.highTask[0];
							let highManagers = taskData.highManager;
							let subTasks = taskData.subTask;
	
					        // 업무 번호
					        highTaskId.text('업무 번호 ' + taskData.highTask[0].taskId);
					        // 기간
					        if(taskData.highTask[0].startDate != null) {
					        	startDate.text(taskData.highTask[0].startDate);
				                endDate.text(taskData.highTask[0].endDate);	
					        }else {
					        	startDate.parent().remove();
					        }
			                // 진행상태 버튼 활성화
			                state.children('button[value=' + highTask.state + ']' ).css('background-color', 'var(--color-dark-red)');
			                //진척도
			                processivityValueDiv.css('width', highTask.processivity + "%");
			                processivityValue.text(highTask.processivity + "%");		                
			             	// 우선 순위
			             	 if(highTask.priorityName != null) {
			             		prioriy.text('우선순위 : ' + highTask.priorityName);
					        }else {
					        	prioriy.remove();
					        }
					     	// 상위 업무 담당자
					     	if(highManagers.length >1) {
					     		taskManagers.append('<span>' + highManagers[0].memberName + ' 외 ' + (highManagers.length-1) + '명</span>');	
					     	} else if(highManagers.length == 0) {
					     		taskManagers.append('<span>없음</span>');
					     	} else {
					     		taskManagers.append('<span>' + highManagers[0].memberName + '</span>');
					     	} 
					     	
					     	// 하위 업무 리스트
					     	if(subTasks.length == 0) {
					     		$(boardList[i]).find('.sub-task-lists').empty();
					     		return;
					     	}
					     	
					     	let countSpan = $(boardList[i]).find('span[data-subtaskcount]');
					     	let subTaskList = $(boardList[i]).find(".sub-task-list");
							// 하위 업무 갯수 
					     	countSpan.text(subTasks.length);
					     	// 정보 입력
					        for (let j = 0; j < subTasks.length; j++) {
					        	let subTask = subTasks[j];
								let li = $('<li class="sub-task-item">');
					        	let subState = $('<span class="sub-state">');
					        	let subTitle = $('<span class="sub-title">');
							
					        	subState.text(subTask.stateName);
					        	subTitle.text(subTask.prjBoardTitle);
					        	
								li.append(subState);
								li.append(subTitle);
								
								subTaskList.append(li);
					        }
					    }, error : function(reject) {
							console.log(reject);
						}
					});
				}
			}
		});
		
		//북마크
		$('span[data-bookmark]').on('click', function(e) {
			let boardContainer = $(e.currentTarget).closest('.board-container');
			let prjBoardId = boardContainer.data('id');
			let boardType = boardContainer.data('type');
			let prjId = '${projectInfo.projectId}';
			let memberId = '${memberInfo.memberId}';
			let bookmark = $(e.currentTarget).data('bookmark');
			let data = {'memberId': memberId, 'projectId': prjId, 'prjBoardId': prjBoardId, 'boardType':boardType};
			
			if(bookmark == 'no') {
				if(confirm('이 게시글을 북마크 하시겠습니까?')) {
					$.ajax({
						url : '${pageContext.request.contextPath}/insertBookmark',
						type : 'POST',
						data : {'memberId': memberId, 'projectId': prjId, 'prjBoardId': prjBoardId, 'boardType':boardType},
						success : function(projectId) {
							location.href ='${pageContext.request.contextPath}/projectFeed?projectId=' + projectId;
						},
						error : function(reject) {
							console.log(reject);
						}
					});	
				}
			}else if(bookmark == 'yes') {
				if(confirm('북마크를 해제 하시겠습니까?')) {
					$.ajax({
						url : '${pageContext.request.contextPath}/deleteBookmark',
						type : 'POST',
						data : {'memberId': memberId, 'projectId': prjId, 'prjBoardId': prjBoardId, 'boardType':boardType},
						success : function(projectId) {
							location.href ='${pageContext.request.contextPath}/projectFeed?projectId=' + projectId;
						},
						error : function(reject) {
							console.log(reject);
						}
					});	
				}
			}
		});
		
		//투표 항목 선택 시 버튼 색상 변경 && 복수 투표 여부
		function checkBtn(e) {
			let checkBox = $(e).closest('.vote-lists').find('input[type=checkbox]');
			let voteBtn = $(e).closest('.vote-lists').next().children('button');
			let compnoSpan = $(e).closest('.vote-lists').prev().children('.compnoVote');
			let count = $(e).closest('.vote-lists').find('input[type=checkbox]:checked').length;
			let isChecked = false;
			
			for(let i=0; i<checkBox.length; i++) {
				if(checkBox[i].checked == true) {
					isChecked = true;
				}	
			}
			
			if(isChecked) {
				voteBtn.addClass('active');
				voteBtn.attr("disabled", false);
			} else {
				voteBtn.removeClass('active');
				voteBtn.attr("disabled", true);
			}
			
			if(compnoSpan.text() == '') { //단일 투표
				if(count > 1) {
					alert('한개의 항목만 투표 가능합니다.');
					$(e).prop("checked", false);
				}	
			}
		}; 
		
		// 일정 참여
		$('.sche-btns button').on('click', function(e) {
			let btn = $(e.currentTarget);
			let prjParticirId = '${particirInfo.prjParticirId }';
			let boardContainer = $(e.currentTarget).closest('.board-container');
			let attendYesCount = boardContainer.find('.sche-particir-count');
			let attendNoCount = boardContainer.find('.sche-nonParticir-count');
			let boardId = boardContainer.data('id');
			let attendance = '';
			//DB 저장
			if (btn.hasClass('btn-green')) {
					btn.next().removeClass('active');
					btn.attr('class', 'btn-green active');	
					attendance = 'A1';
				}	
				else {
					btn.prev().removeClass('active');
					btn.attr('class', 'active');
					attendance = 'A2';
				}
			
			$.ajax({
				url : '${pageContext.request.contextPath}/sheParticipate',
				type : 'POST',
				data : {'prjParticirId' : prjParticirId ,'prjBoardId' : boardId, 'attendance' : attendance},
				success : function() {
					//새 정보
					$.ajax({
						url : '${pageContext.request.contextPath}/getScheInfo',
						type : 'GET',
						data : {'prjBoardId': boardId, 'memberId': '${memberInfo.memberId}', 'projectId': '${projectInfo.projectId}' },
						success : function(sche) {
			                //참석 인원 값
			                attendYesCount.text(sche.attendanceYes);
			                attendNoCount.text(sche.attendanceNo);
						}, error : function(reject) {
							console.log(reject);
						}
					})
				},
				error : function(reject) {
					console.log(reject);
				}
			});
		})
		
		//투표기능
		$('.vote-btn button').on('click', function(e) {
			let btn = $(e.currentTarget);
			let boardContainer = $(e.currentTarget).closest('.board-container');
			let inputList = boardContainer.find('.vote-list input:checked');
			let prjBoardId = boardContainer.data('id');
			let prjParticirId = '${particirInfo.prjParticirId}';
			let voteParticir = [];
			
			//투표참여
			if(btn.attr('name') == 'voteAttend') {
				
				for(let i=0; i<inputList.length; i++) {
					let listId = $(inputList[i]).prop('id');
					listId = listId.substring(listId.indexOf('-')+1, listId.length);
					
					voteParticir.push({prjParticirId, prjBoardId, listId});		
				}
				
				$.ajax({
					url : '${pageContext.request.contextPath}/votePaticir',
					type : 'POST',
					data:JSON.stringify(voteParticir),
					contentType:'application/json',
					success : function(string) {
						btn.removeClass('d-b');
						btn.next().addClass('d-b');
						boardContainer.find('.vote-list input').prop('disabled', true);
						
						//새정보 입력
						$.ajax({
							url : '${pageContext.request.contextPath}/getVoteInfo',
							type : 'GET',
							data : {'prjBoardId': prjBoardId, 'prjParticirId': '${particirInfo.prjParticirId }'},
							success : function(voteData) {
								let voteParticirCount = boardContainer.find('.vote-particir-count');
								// 투표 참여 인원
								voteParticirCount.text(voteData.voteInfo[0].voteAttendance);
							}, error : function(reject) {
								console.log(reject);
							}
						});
					},
					error : function(reject) {
						console.log(reject);
					}
				});
			} //투표취소 
			else if(btn.attr('name') == 'voteNonAttend') {
				$.ajax({
					url : '${pageContext.request.contextPath}/votePaticirDelete',
					type : 'POST',
					data:{'prjParticirId': prjParticirId, 'prjBoardId': prjBoardId},
					success : function(string) {
						btn.removeClass('d-b');
						btn.prev().addClass('d-b');
						boardContainer.find('.vote-list input').prop('disabled', false);
						boardContainer.find('.vote-list input').prop('checked', false);
						
						//새정보 입력
						$.ajax({
							url : '${pageContext.request.contextPath}/getVoteInfo',
							type : 'GET',
							data : {'prjBoardId': prjBoardId, 'prjParticirId': '${particirInfo.prjParticirId }'},
							success : function(voteData) {
								let voteParticirCount = boardContainer.find('.vote-particir-count');
								// 투표 참여 인원
								voteParticirCount.text(voteData.voteInfo[0].voteAttendance);
							}, error : function(reject) {
								console.log(reject);
							}
						});
					},
					error : function(reject) {
						console.log(reject);
					}
				});
			}
		});
		</script>
	<!-- 게시글 출력 종료 -->
	
	<!-- 게시글 작성 HTML -->
	<div class="modal modalBoard" tabindex="-1" id="boardInsertModal">
	<div class="insert-board-modal">
		<!-- 공통 양식 -->
	    <div class="insert-board-modal-header">
	    	<!-- 모달페이지 띄우기 위함 -->
	    	<input type="hidden" class="modal-dialog d-none">
			<input type="hidden" class="modal-content d-none">
	    	<div class="insert-board-modal-title">
	    		<div>게시물 작성</div>		
	    		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	    	</div>
	    	<ul class="insert-board-list">
	    		<li class="insert-list-item">글</li>
	    		<li class="insert-list-item">업무</li>
	    		<li class="insert-list-item">일정</li>
	    		<li class="insert-list-item">투표</li>
	    	</ul>
	    	<input type="hidden" name="memberId" value="${memberInfo.memberId }" id="memberId">
			<input type="hidden" name="projectId" value="${projectInfo.projectId}" id="projectId">
		</div>
		<!-- 일반 게시글 작성 폼 -->
		<form action="${pageContext.request.contextPath }/boardInsert" method="post" class="dis-none d-b" id="board">
			<div class="insert-board-area">
				<div class="board-form" >
					<input type="text" class="board-form-title" name="prjBoardTitle" placeholder="제목을 입력하세요.">
					<textarea name="prjBoardSubject" placeholder="내용을 입력하세요." id="editor1"></textarea>
				</div>
	        </div>
	        <div class="modal-footer">
				<select name="inspYn" class="modal-footer-select">
					<option value="E2">전체 공개</option>
					<option value="E1">프로젝트 관리자만</option>
				</select>
				<input type="hidden" name="boardType" value="C5">
         		<input type="hidden" name="projectId" value="${projectInfo.projectId}">
              	<button type="reset" class="modal-footer-btn">임시저장</button>
              	<button type="submit" class="modal-footer-btn" data-bs-dismiss="modal">등록</button>
              	<div><a href="#">임시저장 게시글 보기</a></div>
			</div>
		</form>
        <!-- 게시글 작성 폼 끝!!! -->
		
		<!-- 상위 업무 작성 폼!!! -->
		<form class="dis-none" id="task">
			<div class="insert-board-area">
				<div class="board-form" >
					<input type="text" class="board-form-title" name="prjBoardTitle" placeholder="제목을 입력하세요.">
					<div class="board-state">
						<input type="radio" class="btn-check" name="state" value="G1" id="option1" autocomplete="off" checked>
						<label for="option1">요청</label>
						
						<input type="radio" class="btn-check" name="state" value="G2" id="option2" autocomplete="off">
						<label for="option2">진행</label>
						
						<input type="radio" class="btn-check" name="state" value="G3" id="option3" autocomplete="off">
						<label for="option3">피드백</label>
						
						<input type="radio" class="btn-check" name="state" value="G4" id="option4" autocomplete="off">
						<label for="option4">완료</label>
						
						<input type="radio" class="btn-check" name="state" value="G5" id="option5" autocomplete="off">
						<label for="option5">보류</label>
					</div>
					<div>
						<label for="startDate">시작일 : </label>
						<input type="text" name="startDate" class="date-input startDate" data-date autocomplete="off">
						
						<label for="endDate">마감일 : </label>
						<input type="text" name="endDate" class="date-input endDate" disabled autocomplete="off">
					</div>
					
					<!-- 진척도 -->
					<div class="js-progress create-content-cell">
						<!-- 우선 순위 -->
						<div class="select-priority">
							<div>우선 순위 : </div>
							<select name="priority">
								<option value="">=======</option>
								<option value="F3">낮음</option>
								<option value="F2">보통</option>
								<option value="F1">긴급</option>
							</select>
						</div>
						<!-- 진행율 -->
						<div class="board-progress">
							<div>진행율 : </div>
							<div class="progress-bar">
					       		<div class="progress-bar-size"></div>
							</div>
							<div class="progress-value">0%</div>
							<input type="hidden" name="processivity" value="0">
						</div>
					</div>
					
					<!-- 업무 담당자 -->
					<div class="board-taskManager">
						<span class="add-manager-btn">담당자 추가</span>
						<div class="highManagerList"></div>
					</div>
					<!-- 업무 담당자 끝 -->
					
					<textarea name="prjBoardSubject" placeholder="내용을 입력하세요." id="editor2"></textarea>
				</div>
				
				<!-- 하위업무 등록 -->
				<div class="board-sub-task">
					<div class="board-sub-task-title">하위 업무</div>
					<div class="sub-task-manager"></div>
					<span class="add-sub-task-btn">하위 업무 추가</span>
				</div>
	        </div>
	        
	        <div class="modal-footer">
				<select name="inspYn" class="modal-footer-select">
					<option value="E2">전체 공개</option>
					<option value="E1">프로젝트 관리자만</option>
				</select>
				<input type="hidden" name="boardType" value="C5">
	        		<input type="hidden" name="projectId" value="${projectInfo.projectId}">
	             	<button type="reset" class="modal-footer-btn">임시저장</button>
	             	<button type="button" class="modal-footer-btn" id="btnAddTask" data-bs-dismiss="modal">등록</button>
	             	<div><a href="#">임시저장 게시글 보기</a></div>
			</div>
		</form>
	
		<!-- 일정 작성 폼!!! -->
		<form action="${pageContext.request.contextPath }/boardInsert" method="post" class="dis-none" id="sche">
			<div class="insert-board-area">
				<div class="board-form" >
					<input type="text" class="board-form-title" name="prjBoardTitle" placeholder="제목을 입력하세요.">
					<div class="m-bt">
						<label for="startDate">시작일 : </label>
						<input type="text" name="startDate" class="date-input startDate" data-date autocomplete="off">
						
						<label for="endDate">마감일 : </label>
						<input type="text" name="endDate" class="date-input endDate" disabled autocomplete="off">
					</div>
					<div class="d-flex m-bt" style="justify-content: flex-start;">
						<div>
							<label>장소 : </label>
							<input type="text" placeholder="일정 장소를 설정해주세요." id="scheAddr" name="scheAddr">
							<input type="text" id="scheAddrDetail" name="scheAddrDetail" placeholder="상세주소" disabled>
						</div>
						<select name="alarmDateCode">
							<option value="" selected>알림 설정</option>
							<option value="L1">10분 전 미리 알림</option>
							<option value="L2">1시간 전 미리 알림</option>
							<option value="L3">1일 전 미리 알림</option>
							<option value="L4">7일 전 미리 알림</option>
						</select>
					</div>
					<textarea name="prjBoardSubject" placeholder="내용을 입력하세요." id="editor3"></textarea>
				</div>
	        </div>
	        
	        <div class="modal-footer">
				<select name="inspYn" class="modal-footer-select">
					<option value="E2">전체 공개</option>
					<option value="E1">프로젝트 관리자만</option>
				</select>
					<input type="hidden" name="boardType" value="C6">
	        		<input type="hidden" name="projectId" value="${projectInfo.projectId}">
	             	<button type="reset" class="modal-footer-btn">임시저장</button>
	             	<button type="submit" class="modal-footer-btn" id="btnAddTask" data-bs-dismiss="modal">등록</button>
	             	<div><a href="#">임시저장 게시글 보기</a></div>
			</div>
		</form>
	        
		<!-- 투표 작성 폼!!! -->
		<form action="${pageContext.request.contextPath }/boardInsert" method="post" class="dis-none" id="vote">
			<div class="insert-board-area">
				<div class="board-form" >
					<input type="text" class="board-form-title" name="prjBoardTitle" placeholder="제목을 입력하세요.">
					
					<div class="d-flex m-bt" style="justify-content: flex-start;">
						<div class="form-check form-switch">
							<input name="anonyVote" value="A1" class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
							<label class="form-check-label" for="flexSwitchCheckDefault">익명 투표</label>
						</div>
						<div class="form-check form-switch">
							<input name="compnoVote" value="A1" class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
							<label class="form-check-label" for="flexSwitchCheckDefault">복수 투표</label>
						</div>
						<div class="form-check form-switch">
							<input name="resultYn" value="A1" class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
							<label class="form-check-label" for="flexSwitchCheckDefault">결과 나만 보기</label>
						</div>
					</div>
					
					
					<div class="m-bt">
						<label for="endDate">마감일 : </label>
						<input type="text" name="endDate" class="date-input endDate" data-date autocomplete="off">
					</div>
					
					<textarea name="prjBoardSubject" placeholder="내용을 입력하세요." id="editor4"></textarea>
				</div>
				
				<!-- 하위업무 등록 -->
				<div class="board-sub-task">
					<div class="board-sub-task-title">투표 항목</div>
					<div class="board-vote-list"></div>
					<span class="add-vote-list-btn">투표 항목 추가</span>
				</div>
	        </div>
	        
	        <div class="modal-footer">
				<select name="inspYn" class="modal-footer-select">
					<option value="E2">전체 공개</option>
					<option value="E1">프로젝트 관리자만</option>
				</select>
				<input type="hidden" name="boardType" value="C7">
	        		<input type="hidden" name="projectId" value="${projectInfo.projectId}">
	             	<button type="reset" class="modal-footer-btn">임시저장</button>
	             	<button type="submit" class="modal-footer-btn" id="btnAddTask" data-bs-dismiss="modal">등록</button>
	             	<div><a href="#">임시저장 게시글 보기</a></div>
			</div>
		</form>
    </div>
</div>
	
	<!-- 게시글 작성 SCRIPT -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		//ckeditor 시작
		for(let i =1; i<5; i++) {
			CKEDITOR.ClassicEditor.create(document.querySelector('#editor' + i), {
		        toolbar: {
		        	 items: [
						'alignment', '|',
						'heading', '|',
						'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor', 'highlight', '|',
						'exportPDF', 'insertImage', 'mediaEmbed',
						'-',
						'specialCharacters', '|',
						'bold', 'italic', 'strikethrough', 'underline', 'subscript', 'superscript', '|',                     
						'findAndReplace', 'selectAll'
		             ],
		             shouldNotGroupWhenFull: true
		         },
		        // Changing the language of the interface requires loading the language file using the <script> tag.
		        language: 'ko',
		        // https://ckeditor.com/docs/ckeditor5/latest/features/headings.html#configuration
		        heading: {
		            options: [
		                { model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
		                { model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1' },
		                { model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
		                { model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' },
		                { model: 'heading4', view: 'h4', title: 'Heading 4', class: 'ck-heading_heading4' },
		                { model: 'heading5', view: 'h5', title: 'Heading 5', class: 'ck-heading_heading5' },
		                { model: 'heading6', view: 'h6', title: 'Heading 6', class: 'ck-heading_heading6' }
		            ]
		        },
		        // https://ckeditor.com/docs/ckeditor5/latest/features/editor-placeholder.html#using-the-editor-configuration
		        placeholder: '내용을 입력하세요.',
		        // https://ckeditor.com/docs/ckeditor5/latest/features/font.html#configuring-the-font-family-feature
		        fontFamily: {
		            options: [
		                'default',
		                '궁서체',
			    		'돋움',
		                'Arial, Helvetica, sans-serif',
		                'Courier New, Courier, monospace',
		                'Georgia, serif',
		                'Lucida Sans Unicode, Lucida Grande, sans-serif',
		                'Tahoma, Geneva, sans-serif',
		                'Times New Roman, Times, serif',
		                'Trebuchet MS, Helvetica, sans-serif',
		                'Verdana, Geneva, sans-serif',
		            ],
		            supportAllValues: true
		        },
		        // https://ckeditor.com/docs/ckeditor5/latest/features/font.html#configuring-the-font-size-feature
		        fontSize: {
		            options: [ 10, 12, 14, 16, 18, 20, 22 ],
		            supportAllValues: true
		        },
		        // The "super-build" contains more premium features that require additional configuration, disable them below.
		        // Do not turn them on unless you read the documentation and know how to configure them and setup the editor.
		        removePlugins: [
		            // These two are commercial, but you can try them out without registering to a trial.
		            // 'ExportPdf',
		            // 'ExportWord',
		            'CKBox',
		            'EasyImage',
		            // This sample uses the Base64UploadAdapter to handle image uploads as it requires no configuration.
		            // https://ckeditor.com/docs/ckeditor5/latest/features/images/image-upload/base64-upload-adapter.html
		            // Storing images as Base64 is usually a very bad idea.
		            // Replace it on production website with other solutions:
		            // https://ckeditor.com/docs/ckeditor5/latest/features/images/image-upload/image-upload.html
		            // 'Base64UploadAdapter',
		            'RealTimeCollaborativeComments',
		            'RealTimeCollaborativeTrackChanges',
		            'RealTimeCollaborativeRevisionHistory',
		            'PresenceList',
		            'Comments',
		            'TrackChanges',
		            'TrackChangesData',
		            'RevisionHistory',
		            'Pagination',
		            'WProofreader',
		            // Careful, with the Mathtype plugin CKEditor will not load when loading this sample
		            // from a local file system (file://) - load this site via HTTP server if you enable MathType
		            'MathType'
		        ]
		   	}).then(newEditor => {
		   	 	window['editor'+i] = newEditor;
		    })
		    .catch( error => {
		        console.error( error );
		    });	
		};
		//ckeditor 종료
		
		//다음 주소 api
		$('#scheAddr').on('click', function() {
			new daum.Postcode({
				oncomplete: function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					$('#scheAddrDetail').prop('disabled', false);
					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var addr = ''; // 주소 변수
					var extraAddr = ''; // 참고항목 변수
					
					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					    addr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
					    addr = data.jibunAddress;
					}
					
					// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					if(data.userSelectedType === 'R'){
					    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
					    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
					        extraAddr += data.bname;
					    }
					    // 건물명이 있고, 공동주택일 경우 추가한다.
					    if(data.buildingName !== '' && data.apartment === 'Y'){
					        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					    }
					    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					    if(extraAddr !== ''){
					        extraAddr = ' (' + extraAddr + ')';
					    }
					    // 조합된 참고항목을 해당 필드에 넣는다.
					    	addr = addr + extraAddr;
					} 
					// 주소 정보를 해당 필드에 넣는다.
					document.getElementById("scheAddr").value = addr;
					// 커서를 상세주소 필드로 이동한다.
					document.getElementById("scheAddrDetail").focus();
				}
			}).open();
		});
		//다음 주소 api 종료
		
		// 게시글 유형 폼 선택
		$('ul.insert-board-list li').click(function(e){
			let target = e.currentTarget.textContent;
			let visibleDiv = $('.d-b');
			if(target == '글') {
				visibleDiv.removeClass('d-b');
				$('#board').addClass('d-b');
			}else if(target == '업무') {
				visibleDiv.removeClass('d-b');
				$('#task').addClass('d-b');
			}else if(target == '일정') {
				visibleDiv.removeClass('d-b');
				$('#sche').addClass('d-b');
			}else if(target == '투표') {
				visibleDiv.removeClass('d-b');
				$('#vote').addClass('d-b');
			}	
		});
		
		// 업무 등록 시작
		//담당자 추가 클릭 시 구성원 불러오고 셀렉트 박스
		$(document).on('click', '.add-manager-btn', function(e) {
			let boardTaskManager = $(e.currentTarget).closest('.board-taskManager');
			let addManagerBtn = $(e.currentTarget);
			let selectBox = $('<select class="add-taskManager-select" onchage="addManager(this)")><option value="" selected disabled>담당자 추가</option></select>');
			
			addManagerBtn.remove();
			
			$.ajax({
		    	url : '${pageContext.request.contextPath}/particirList',
		        type: 'GET',
		        data: {'projectId': "${projectInfo.projectId}"},
		        success: function(particir){
		        	for(let i=0; i<particir.length; i++) {
						let option = $('<option>');
						
						option.val(particir[i].prjParticirId);
						option.text(particir[i].memberName);
						
						selectBox.append(option);
					}
		        },
		        error: function(reject){
		            console.log(reject);
		        }
		    });	
			
			boardTaskManager.prepend(selectBox);
			boardTaskManager.prepend('<span>담당자 : </span>');
		});
		
		//담당자 선택시 스팬 추가
		$(document).on('change','.add-taskManager-select', function(e) {
			let managerSpan = $('<span>');
			let memberId = `<input type="hidden" name="taskManager">`;
			let selectBox = $(e.currentTarget);
			let checkedOption = selectBox.find('option:checked');
			
			if(selectBox.find('option:disabled').length == 4) {
				managerSpan.text('외 1명');
				selectBox.before(managerSpan);
			}else if (selectBox.find('option:disabled').length > 4) {
				selectBox.prev().remove();
				managerSpan.text('외' + (selectBox.find('option:disabled').length-3) + '명');
				selectBox.before(managerSpan);
			} else {
				managerSpan.text(checkedOption.text());
				selectBox.before(managerSpan);
			}
			//담당자 아이디 저장
			memberId = $(memberId).val(checkedOption.val());
			selectBox.next().append(memberId);
			
			checkedOption.prop('disabled', true);
		});
		
		// 시작일자, 마감일자 범위 선택하기
		$(document).on('click', 'input[data-date]', function(e) {
			//startDate 클릭 시
			if($(e.currentTarget).hasClass('startDate')) {
				let startDate = $(e.currentTarget);
				let endDate = startDate.siblings('.endDate');
				
				// 시작일
				startDate.datetimepicker({
					format:'Y-m-d H:i',
					lang:'kr',
					onSelectDate:function() {
						endDate.prop('disabled', false);
					}
				});
				
				// 마감일
				endDate.datetimepicker({
					format:'Y-m-d H:i',
					lang:'kr',
					// 오늘 이후로 선택 가능하게 설정
					onShow:function(){
						let date = new Date(startDate.val());
						date.setDate(date.getDate() + 1);
						
						this.setOptions({
							minDate:startDate.val()?date:false
						})
					}
				});
			} //endDate 클릭 시 
			else if($(e.currentTarget).hasClass('endDate')) {
				let endDate = $(e.currentTarget);
				
				endDate.datetimepicker({
					format:'Y-m-d H:i',
					// 오늘 이후로 선택 가능하게 설정
					minDate: 0
				});
			}
		});
			
		//진척도!!
		const progressBar = document.querySelector(".progress-bar");
		const progressBarInner = document.querySelector(".progress-bar-size");
	
		progressBar.addEventListener("click", (event) => {
			// 클릭 위치
			// 창 왼쪽부터 클릭한 위치까지 거리 - 프로그레스바 왼쪽 좌표 = 클릭 위치
			const clickedPosition = event.clientX - progressBar.getBoundingClientRect().left;
			
			// 프로그레스 전체 길이
			const totalWidth = progressBar.offsetWidth;
			
			// 진척도 값 계산
			const selectedProgress = Math.round((clickedPosition / totalWidth) * 100 / 10) * 10;
	
			// 클릭한 진척도 값으로 프로그레스 채우기
			progressBarInner.style.width = selectedProgress + "%";
			
			// input에 선택 한 값 넣기
		    const hiddenInput = document.querySelector("input[name='processivity']");
			
			if (hiddenInput) {
				hiddenInput.value = selectedProgress;
	
				// 선택된 값 표시
				const progressValue = document.querySelector(".progress-value");
				progressValue.textContent = selectedProgress + "%";
			}
		});
		
		// 하위 업무 추가하기
	    $('.add-sub-task-btn').on('click', function() {
	        var subtaskForm = `
	            <div class="task-add" style="padding-right: 150px;">
	        		<div class="d-flex m-bt">
	        			<div>
	        				<span>업무 제목 : </span>
	        				<input type="text" name="prjBoardTitle" placeholder="제목을 입력하세요." style="margin-left: 20px;">
	        			</div>
		                <div class="select-state">
		                	<span>진행 상태 : </span>
						    <select name="state" class="task-select" style="margin-left: 20px;">
						        <option value="G1">요청</option>
						        <option value="G2">진행</option>
						        <option value="G3">피드백</option>
						        <option value="G4">완료</option>
						        <option value="G5">보류</option>
						    </select>
						</div>
	        		</div>
	                <div class="d-flex m-bt">
		        		<div class="select-priority">
		        			<span>우선 순위 : </span>
		                    <select name="priority">
		                        <option value="">=======</option>
		                        <option value="F3">낮음</option>
		                        <option value="F2">보통</option>
		                        <option value="F1">긴급</option>
		                    </select>
		                </div>
		                <div>
		                    <label for="endDate">마감일 : </label>
		                    <input type="text" name="endDate" class="date-input endDate" data-date autocomplete="off" style="margin:0 0 0 20px;">
		                </div>
	                </div>
	                <div class="board-taskManager">
						<span class="add-manager-btn">담당자 추가</span>
						<div class="subManagerList"></div>
					</div>
	            </div>`;
	        
	            $('.sub-task-manager').append(subtaskForm);
	    	});
		
		// 업무 등록하기
		$('#btnAddTask').on('click', function(){
			let data={}
			let prjBoardTitle = $('#task').find('[name=prjBoardTitle]').val();
			let prjBoardSubject = editor2.getData();
			let state = $('#task').find('[name=state]:checked').val();
			let inspYn = $('#task').find('[name=inspYn]').val();
			let startDate = $('#task').find('[name=startDate]').val();
			let endDate = $('#task').find('[name=endDate]').val();
			let priority = $('#task').find('[name=priority]').val();
			let processivity = $('#task').find('[name=processivity]').val();
			let boardType = 'C8';
			let memberId = $('#memberId').val();
			let projectId = $('#projectId').val();
			
			
			let boardVO = {prjBoardTitle, prjBoardSubject, inspYn, projectId, boardType, memberId}
			let taskVO = {state, startDate, endDate, priority, processivity}
			
			// 상위 업무 담당자 리스트
			let prjManager =[];
			$('.highManagerList input[name="taskManager"]').each(function(index, item){
		        let prjParticirId = $(item).val();
		        prjManager.push({prjParticirId});
		    });
			
			// 하위 업무
			let subTask = [];
			let subManager = [];
			$('.task-add').each(function(index,item){
				let prjBoardTitle = $(item).find('[name=prjBoardTitle]').val();
				// 하위 업무 리스트
				if (prjBoardTitle !== "") {
	                state = $(item).find('[name=state]').val();
	                let endDate = $(item).find('[name=endDate]').val();
	                let priority = $(item).find('[name=priority]').val();
	                let managerList = $(item).find('input[name="taskManager"]');
	                
	                subTask.push({ prjBoardTitle, state, endDate, priority });
	            	
	            // 하위 업무 담당자
					$(managerList).each(function(idx, manager) {
						let prjParticirId = $(manager).val();
						let prjBoardId = index;
						console.log()
						subManager.push({prjBoardId, prjParticirId});
					});               
	            }
			});
			
			console.log(JSON.stringify({boardVO, taskVO, subTask, prjManager, subManager}));
			$.ajax({
				url:'${pageContext.request.contextPath}/taskInsert',
				type:'POST',
				data:JSON.stringify({boardVO, taskVO, subTask, prjManager, subManager}),
				contentType:'application/json',
				success:function(data){
					location.href='${pageContext.request.contextPath}/projectFeed?projectId=' + data;
				},error: function(reject) {
					console.log(reject);
				}
			});
		})
		// 업무 등록 종료
		
		
		// 투표 항목 추가하기           
        $('.add-vote-list-btn').on('click', function () {                                        
            $('.board-vote-list').append (                        
                '<input type="text" name="listContent" placeholder="내용을 입력해주세요.">'                    
            ); // end append                            
        });                                           
	</script>
	<!-- 게시글 작성 종료 -->
</body>
</html>