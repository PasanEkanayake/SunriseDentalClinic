<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .inquiry-card {
        border: 1px solid #e2e8f0;
        border-radius: 20px;
        background: #ffffff;
        box-shadow: 0 12px 32px rgba(10, 37, 64, 0.05);
        overflow: hidden;
    }

    .header-icon-box {
        width: 44px;
        height: 44px;
        background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%);
        color: #0284c7;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .inquiry-table th {
        color: #64748b;
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-weight: 700;
        background-color: #f8fafc;
        padding: 1rem 1.25rem;
    }

    .inquiry-table td {
        padding: 1rem 1.25rem;
    }

    .unread-row {
        background-color: #fffbe2 !important;
    }

    .message-cell {
        max-width: 300px;
        color: #334155;
        font-size: 0.9rem;
        line-height: 1.5;
    }

    .btn-mark-read {
        background-color: #ffffff;
        border: 1px solid #10b981;
        color: #059669;
        font-weight: 600;
        transition: all 0.2s ease;
    }

    .btn-mark-read:hover {
        background-color: #10b981;
        color: #ffffff;
        box-shadow: 0 4px 12px rgba(16, 185, 129, 0.2);
    }
</style>

<!-- Top Title Bar -->
<div class="d-flex align-items-center justify-content-between mb-4">
    <div class="d-flex align-items-center gap-3">
        <div class="header-icon-box fs-4">
            <i class="bi bi-envelope-paper-fill"></i>
        </div>
        <div>
            <h4 class="fw-bold text-dark mb-0">Website Inquiries</h4>
            <p class="text-muted small mb-0">Messages submitted through the public homepage contact form</p>
        </div>
    </div>
    <a href="<%=request.getContextPath()%>/AdminPanelServlet" class="btn btn-light border fw-semibold text-secondary px-3 py-2">
        <i class="bi bi-arrow-left me-1"></i> Admin Panel
    </a>
</div>

<!-- Main Table Card -->
<div class="card inquiry-card">
    <div class="card-body p-0">
        <c:choose>
            <c:when test="${empty inquiries}">
                <div class="text-center text-muted py-5 px-4">
                    <i class="bi bi-inbox fs-1 d-block mb-2 opacity-50"></i>
                    <h6 class="fw-bold text-dark mb-1">No Inquiries Found</h6>
                    <p class="small mb-0">No messages have been submitted through the contact form yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover inquiry-table mb-0 align-middle">
                        <thead>
                        <tr>
                            <th>Received</th>
                            <th>Sender</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Message</th>
                            <th>Status</th>
                            <th class="text-end">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="inq" items="${inquiries}">
                            <tr class="${inq.read ? '' : 'unread-row'}">
                                <td class="text-nowrap text-secondary small font-monospace">
                                    <fmt:formatDate value="${inq.submittedAt}" pattern="dd MMM yyyy, hh:mm a"/>
                                </td>
                                <td>
                                    <div class="fw-semibold text-dark"><c:out value="${inq.fullName}"/></div>
                                </td>
                                <td>
                                    <a href="mailto:${inq.email}" class="text-primary text-decoration-none small fw-semibold">
                                        <i class="bi bi-envelope me-1"></i><c:out value="${inq.email}"/>
                                    </a>
                                </td>
                                <td>
                                    <span class="font-monospace small text-dark"><c:out value="${inq.phone}"/></span>
                                </td>
                                <td class="message-cell">
                                    <c:out value="${inq.message}"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${!inq.read}">
                                            <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle px-2.5 py-1 rounded-pill fw-semibold">
                                                <i class="bi bi-envelope-exclamation me-1"></i> New
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2.5 py-1 rounded-pill fw-semibold">
                                                <i class="bi bi-envelope-check me-1"></i> Read
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end">
                                    <c:if test="${!inq.read}">
                                        <form method="post" action="<%=request.getContextPath()%>/ManageInquiriesServlet" class="d-inline">
                                            <input type="hidden" name="inquiryId" value="${inq.inquiryId}">
                                            <button type="submit" class="btn btn-sm btn-mark-read rounded-2 px-2.5 py-1">
                                                <i class="bi bi-check2 me-1"></i> Mark Read
                                            </button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>