<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 수정</title>
<link  rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/projectInsert.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<body>
	<!-- 이진 -->
    <p class="form__title">프로젝트 수정</p>
    <form class="project-create-form" name="updateForm">
        <div>
            <input type="text" class="form__input-title" name="projectName" value="${projectInfo.projectName }">
        </div>

        <div class="form__divide">
            <div>
            	<!-- 부서 이름 수정!!!!! -->
                <label>부서 선택</label>
                <select class="form__select" name="departmentId" id="departmentId">
                
                    <option value="">부서를 선택하세요.</option>
                    <option value="1">부서1</option>
                    <option value="2">부서2</option>
                    <option value="3">부서3</option>
                </select>
            </div>

            <div>
                <label>회사 공개로 설정</label>
                <input type="checkbox" class="form__checkbox" name="projectAccess" value="">
            </div>

            <div>
                <label>관리자 승인 후 참여 가능</label>
                <input type="checkbox" class="form__checkbox" name="managerAccp" value="">
            </div>
        </div>
		
		
        <p class="form__category-title">권한 설정</p>
        <div>
	        <div class="permission">
	            <p class="permission__title">게시글</p>
	            <ul>
	                <li>
	                    <label>작성 권한</label>
	                    <select class="form__select" name="writeAccess">
	                        <option value="J1">전체</option>
	                        <option value="J2">프로젝트 관리자만</option>
	                    </select>
	                </li>
	                <li>
	                    <label>수정 권한</label>
	                    <select class="form__select" name="updateAccess">
	                        <option value="J1">전체</option>
	                        <option value="J3" selected>프로젝트 관리자 + 작성자만</option>
	                        <option value="J4">작성자만</option>
	                    </select>
	                </li>
	                <li>
	                    <label>조회 권한</label>
	                    <select class="form__select" name="boardAccess">
	                        <option value="J1">전체</option>
	                        <option value="J3">프로젝트 관리자 + 작성자만</option>
	                    </select>
	                </li>
	            </ul>
	        </div>
	
	        <div class="permission">
	            <p class="permission__title">댓글</p>
	            <ul>
	                <li>
	                    <label>작성 권한</label>
	                    <select class="form__select" name="commentAccess">
	                        <option value="J1">전체</option>
	                        <option value="J2">프로젝트 관리자만</option>
	                    </select>
	                </li>
	            </ul>
	        </div>
	
	        <div class="form__divide">
	            <div class="permission">
	                <p class="permission__title">파일</p>
	                <ul>
	                    <li>
	                        <label>접근 권한</label>
	                        <select class="form__select" name="fileAccess">
	                            <option value="J1">전체</option>
	                            <option value="J3">프로젝트 관리자 + 작성자만</option>
	                        </select>
	                    </li>
	                </ul>
	            </div>
	        </div>
        </div>
        <div class="form__button">
            <button type="submit">프로젝트 수정하기</button>
        </div>
    </form>
    <script>
    $(function(){
    	$("#departmentId").val("${projectInfo.departmentId}").attr("selected","selected");
    });
    </script>
</body>
</html>