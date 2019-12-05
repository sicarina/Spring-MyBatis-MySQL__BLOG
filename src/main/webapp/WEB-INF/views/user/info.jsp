<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<c:if test="${empty sessionScope.user}">
		<script>
			alert("로그인 후 사용가능한 메뉴입니다.");
			location.href = "/user/loginForm";
		</script>
	</c:if>
		<section class="site-section">
			<div class="container">
				<div class="row blog-entries">
					<div class="col-md-12 col-lg-12 main-content">
						<div class="col-md-2" style="display:inline-block"></div>
						<div class="col-md-8" style="display:inline-block">
							<div class="row mb-4">
								<div class="col-md-12">
									<h1>My Info</h1>
								</div>
							</div>
							<form onsubmit="return checkDifference();" action="/user/update" method="post" id="updateForm">
								<div class="row">
									<div class="col-md-12 form-group">
										<label for="username">아이디</label>
										<input type="text" id="username" name="username" class="form-control" required="required" readonly="readonly" style="background: white" value="${user.username}" />
									</div>
									<div class="col-md-12 form-group">
										<label for="email">이메일</label>
										<input type="email" id="email" name="email" class="form-control" required="required" value="${user.email}" />
									</div>
									<div class="col-md-12 form-group">
										<label for="address">주소</label>
										<input type="text" id="address" name="address" class="form-control" required="required" style="background: white" value="${user.address}" />
									</div>
								</div>
								<br/>
								<div class="row">
									<div class="col-md-12 form-group text-right">
										<input type="button" onClick="changePassword();" value="비밀번호 변경" class="btn btn-primary" />
										<input type="submit" value="정보수정" class="btn btn-primary" />
									</div>
								</div>
								<input type="hidden" name="id" value="${user.id}" />
							</form>
							<br/><br/>
							<form onsubmit="return uploadImg();" action="/user/upload" method="post" id="profileForm" enctype="multipart/form-data">
								<div class="row">
									<div class="col-md-12 form-group">
										프로필 사진
									</div>
									<div class="col-md-12 form-group">
										<img id="profileImg" src="${user.profile}" style="width:30%"/>
										<input type="file" id="profile" name="profile" style="vertical-align:bottom;"/>
									</div>
								</div>
								<br/>
								<div class="row">
									<div class="col-md-12 form-group text-right">
										<input type="button" onClick="deleteImg(${user.id});" value="사진 삭제" class="btn btn-primary" />
										<input type="submit" value="사진 수정" class="btn btn-primary" />
									</div>
								</div>
								<input type="hidden" name="id" value="${user.id}" />
								<input type="hidden" id="imgChk" name="imgChk"/>
							</form>
							<br/><br/>
							<div class="text-right">
								<input type="button" onClick="deleteUser(${user.id});" value="회원탈퇴" class="btn btn-primary" />
							</div>
						</div>
						<div class="col-md-2" style="display:inline-block"></div>
					</div>
				</div>
			</div>
		</section>
		<script>	
			function checkDifference(){
				if("${user.email}" === $("#email").val() && "${user.address}" === $("#address").val()){
					alert("변경된 내역이 없습니다.");
					return false;
				} else {
					return true;
				}
			}
			
			// 비밀번호 변경페이지 이동
			function changePassword(){
				var userChoice = confirm("비밀번호를 변경하시겠습니까?");
				
				if(userChoice){
					location.href = "/user/changePasswordForm"
				}
			}
			
			$("#profile").on("change", handleImgFile);
			function handleImgFile(e){
				var f = e.target.files[0];
				
				if(!f.type.match("image.*")){
					alert("이미지만 등록할 수 있습니다.");
					return;
				}
				
				var reader = new FileReader();
				
				reader.onload = function(e){
					$("#profileImg").attr("src", e.target.result);
					$("#imgChk").val("true");
				}
				
				reader.readAsDataURL(f);
			}
			
			function uploadImg(){
				if($("#imgChk").val() == "true"){
					return true;
				} else {
					alert("변경된 파일이 없습니다.");
					return false;
				}
			}
			
			function deleteImg(id){
				$.ajax({
					url: "/user/upload/delete/"+id,
					type: "post",
					contentType: "application/x-www-form-urlencoded; charset=utf-8",
					dataType: "text",
					success:function(data){
						alert("프로필 사진 변경이 완료되었습니다.");
						location.href = "/board/list/1"
					},
					error:function(error){
						console.log(error);
						alert("프로필 사진 변경에 실패하였습니다.\n다시 시도해 주세요.");
					}
				});
			}
			
			function deleteUser(id){
				if(confirm("탈퇴하시겠습니까?")){
					$.ajax({
						url: "/user/delete/"+id,
						type: "post",
						contentType: "application/x-www-form-urlencoded; charset=utf-8",
						dataType: "text",
						success:function(data){
							alert("회원 탈퇴가 완료되었습니다.");
							location.href = "/board/list/1"
						},
						error:function(error){
							console.log(error);
							alert("프로필 사진 변경에 실패하였습니다.\n다시 시도해 주세요.");
						}
					});
				}
			}
		</script>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>