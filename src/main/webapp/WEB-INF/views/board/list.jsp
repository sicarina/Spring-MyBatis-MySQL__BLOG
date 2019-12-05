<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
		<section class="site-section pt-5" style="padding-bottom:0px;">
			<div class="container">
				<div class="row blog-entries">
					<div class="col-md-12 main-content">
						<div class="row mb-4">
							<div class="col-md-6">
								<h2 class="mb-4">게시판</h2>
							</div>
						</div>
						<div class="row mb-5 mt-5">
							<div class="col-md-12">
								<c:choose>
								<c:when test="${not empty boards}">
								<c:forEach var="board" items="${boards}">
									<div class="post-entry-horzontal text-center">
										<a href="/board/detail/${board.id}">
											<c:choose>
											<c:when test="${board.id % 2 eq 1}">
											<div class="image element-animate" data-animate-effect="fadeIn" style="background-image: url('/bootstrap/images/img_5.jpg');"></div>
											</c:when>
											<c:otherwise>
											<div class="image element-animate" data-animate-effect="fadeIn" style="background-image: url('/bootstrap/images/img_2.jpg');"></div>
											</c:otherwise>
											</c:choose>
											<span class="text">
												<h2 style="display: -webkit-box; -webkit-box-orient: vertical; text-align: left; overflow: hidden; text-overflow: ellipsis; white-space: normal; line-height: 1.2; height: 1.2em; -webkit-line-clamp: 1; word-break:break-all">${board.title}</h2>
												<div class="post-meta">
													<span class="author mr-2"> ${board.username}</span>
													&bullet;<span class="mr-2"> ${board.insDt}</span>
												</div>
												<div style="display: -webkit-box; -webkit-box-orient: vertical; text-align: left; overflow: hidden; text-overflow: ellipsis; white-space: normal; line-height: 1.2; height: 2.3em; -webkit-line-clamp: 2; word-break:break-all">${board.content}</div>
											</span>
										</a>
									</div>
								</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="post-entry-horzontal text-center">
										<span class="text">
											<h2>작성된 게시물이 없습니다.</h2>
											상단의 Posting을 눌러 게시물을 작성해주세요.
										</span>
									</div>
								</c:otherwise>
								</c:choose>
							</div>
						</div>
		
						<div class="row mt-5">
							<div class="col-md-12 text-center">
								<nav aria-label="Page navigation" class="text-center">
									<ul class="pagination">
										<c:choose>
											<c:when test="${page ne 1}">
												<li class="page-item">
													<a href="/board/list/${page-1}" class="page-link" aria-label="Previous">&lt;</a>
												</li>
											</c:when>
											<c:otherwise>
												<li class="page-item disabled">
													<a href="/board/list/1" class="page-link" aria-label="Previous">&lt;</a>
												</li>
											</c:otherwise>
										</c:choose>
										<c:forEach var="maxPage" begin="1" end="${maxPage}" step="1">
											<c:choose>
												<c:when test="${page eq maxPage}">
													<li class="page-item active"><a href="/board/list/${maxPage}" class="page-link">${maxPage}</a></li>
												</c:when>
												<c:otherwise>
													<li class="page-item"><a href="/board/list/${maxPage}" class="page-link">${maxPage}</a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<c:choose>
											<c:when test="${page ne maxPage}">
												<li class="page-item">
													<a href="/board/list/${page+1}" class="page-link" aria-label="Next">&gt;</a>
												</li>
											</c:when>
											<c:otherwise>
												<li class="page-item disabled">
													<a href="/board/list/${maxPage}" class="page-link" aria-label="Next">&gt;</a>
												</li>
											</c:otherwise>
										</c:choose>
									</ul>
								</nav>
							</div>
						</div>
					</div>
					<!-- END main-content -->
				</div>
			</div>
		</section>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>