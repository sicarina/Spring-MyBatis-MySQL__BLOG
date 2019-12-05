<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<c:if test="${empty sessionScope.user}">
		<script>
			alert("로그인 후 사용가능한 메뉴입니다.");
			location.href = "/user/loginForm";
		</script>
	</c:if>
	<section class="site-section pt-5" style="padding-top:0px; padding-bottom:0px;">
		<div class="container">
			<div class="row blog-entries element-animate">
				<div class="col-md-12 main-content">
					<div class="row">
						<div class="col-md-6">
							<h2 class="mb-4">글 수정</h2>
						</div>
					</div>
					<div class="row mb-5">
						<div class="col-md-12">
							<form action="/board/update" method="post" id="updateForm">
								<div class="row">
									<div class="col-md-12 form-group">
										<input type="text" id="title" name="title" class="form-control" required="required" placeholder="제목을 입력하세요." value="${board.title}"/>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12 form-group">
										<textarea name="content" id="summernote" class="form-control " cols="30" rows="8" placeholder="내용을 입력하세요.">${board.content}</textarea>
									</div>
								</div>
								<br/>
								<div class="row">
									<div class="col-md-12 form-group text-right">
										<input type="submit" value="수정" class="btn btn-primary" />
									</div>
								</div>
								<input type="hidden" name="id" value="${board.id}" />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
	<script src="/api/summernote/summernote-bs4.js"></script>

	<script>
		$('#summernote').summernote({
			placeholder: '내용을 입력하세요.',
			tabsize: 2,
			height: 200
		});
		
		$('.dropdown-toggle').dropdown();
	</script>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>