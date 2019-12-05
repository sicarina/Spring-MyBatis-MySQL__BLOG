<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
		<section class="site-section">
			<div class="container">
				<div class="row blog-entries">
					<div class="col-md-12 col-lg-12 main-content">
						<div class="col-md-2" style="display:inline-block"></div>
						<div class="col-md-8" style="display:inline-block">
							<div class="row mb-4">
								<div class="col-md-12">
									<h1>Login</h1>
								</div>
							</div>
							<form action="/user/login" method="post" id="loginForm">
								<div class="row">
									<div class="col-md-12 form-group">
										<label for="username">아이디</label>
										<input type="text" id="username" name="username" class="form-control" required="required" />									
									</div>
									<div class="col-md-12 form-group">
										<label for="password">비밀번호</label>
										<input type="password" id="password" name="password" class="form-control" required="required" />
									</div>
								</div>
								<br/>
								<div class="row">
									<div class="col-md-12 form-group text-right">
										<input type="submit" value="로그인" class="btn btn-primary" />
									</div>
								</div>
							</form>
						</div>
						<div class="col-md-2" style="display:inline-block"></div>
					</div>
				</div>
			</div>
		</section>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>