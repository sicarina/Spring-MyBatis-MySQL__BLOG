<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<section class="site-section pt-5" style="padding-bottom:0px;">
		<div class="container">
			<div class="row blog-entries element-animate">
				<div class="col-md-12 main-content">
					<div class="row mb-5">
						<div class="col-md-12">
							<h1 class="mb-4">${board.title}</h1>
							
							<div class="post-meta">
								<span class="author mr-2">
									<img src="${board.profile}" class="mr-2"> ${board.username}
								</span>
								&bullet; 
								<span class="mr-2">${board.insDt} </span>
								<c:if test="${board.insId eq sessionScope.user.id}">
									&nbsp; &nbsp; &nbsp; 
									<div class="text-right" style="display:inline-block">
										<a href="/board/updateForm/${board.id}">
											<span style="font-size:1.5em; font-weight:bold;">UPDATE</span>
										</a>
										&nbsp; &nbsp;
										<a href="/board/delete/${board.id}">
											<span style="font-size:1.5em; font-weight:bold;">DELETE</span>
										</a>
									</div>
								</c:if>
							</div>
							<hr/>
							<div class="post-content-body">
								${board.content}
							</div>
							<br/><br/>
						</div>
					</div>
				</div>
				<!-- END main-content -->
			</div>
		</div>
	</section>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>