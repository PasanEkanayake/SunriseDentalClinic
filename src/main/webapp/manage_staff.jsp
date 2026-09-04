<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .staff-card {
        border: 1px solid #e2e8f0;
        border-radius: 20px;
        background: #ffffff;
        box-shadow: 0 12px 32px rgba(10, 37, 64, 0.05);
        overflow: hidden;
    }

    .staff-card-header {
        background: #f8fafc;
        border-bottom: 1px solid #e2e8f0;
        padding: 1.25rem 1.5rem;
    }

    .form-label {
        font-weight: 600;
        font-size: 0.85rem;
        color: #475569;
        margin-bottom: 0.4rem;
    }

    .form-control, .form-select {
        border-color: #cbd5e1;
        padding: 0.7rem 0.9rem;
        border-radius: 10px;
        font-size: 0.95rem;
    }

    .form-control:focus, .form-select:focus {
        border-color: #0284c7;
        box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.15);
    }

    .btn-add-staff {
        background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
        color: #ffffff;
        font-weight: 600;
        padding: 0.75rem 1.5rem;
        border-radius: 10px;
        border: none;
        box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
        transition: all 0.2s ease;
    }

    .btn-add-staff:hover {
        background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 6px 16px rgba(2, 132, 199, 0.3);
    }

    .staff-table th {
        color: #64748b;
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-weight: 700;
        background-color: #f8fafc;
        padding: 1rem 1.25rem;
    }

    .staff-table td {
        padding: 1rem 1.25rem;
    }

    .info-note-box {
        background-color: #f8fafc;
        border-top: 1px solid #e2e8f0;
        padding: 1rem 1.25rem;
        font-size: 0.875rem;
        color: #64748b;
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
</style>

<!-- Top Title Bar -->
<div class="d-flex align-items-center justify-content-between mb-4">
    <div class="d-flex align-items-center gap-3">
        <div class="header-icon-box fs-4">
            <i class="bi bi-people-fill"></i>
        </div>
        <div>
            <h4 class="fw-bold text-dark mb-0">Manage Staff</h4>
            <p class="text-muted small mb-0">Create new staff logins and manage system access permissions</p>
        </div>
    </div>
    <a href="<%=request.getContextPath()%>/AdminPanelServlet" class="btn btn-light border fw-semibold text-secondary px-3 py-2">
        <i class="bi bi-arrow-left me-1"></i> Admin Panel
    </a>
</div>

<div class="row g-4">
    <!-- Form: Add New Staff -->
    <div class="col-lg-5">
        <div class="card staff-card">
            <div class="staff-card-header d-flex align-items-center gap-2">
                <i class="bi bi-person-plus text-primary fs-5"></i>
                <h5 class="fw-bold text-dark mb-0">Add New Staff Member</h5>
            </div>
            <div class="card-body p-4">
                <p class="text-muted small mb-4">Create a login account for an Administrator or Receptionist.</p>
                <form method="post" action="<%=request.getContextPath()%>/ManageStaffServlet">
                    <div class="mb-3">
                        <label class="form-label"><i class="bi bi-person me-1"></i> Full Name *</label>
                        <input type="text" name="fullName" class="form-control" required value="${f_fullName}" placeholder="e.g. Dilani Fernando">
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="bi bi-at me-1"></i> Username *</label>
                        <input type="text" name="username" class="form-control" required value="${f_username}" placeholder="e.g. dilani.f">
                        <div class="form-text small text-muted">3-30 characters: letters, numbers, dots, or underscores.</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="bi bi-shield-check me-1"></i> Role *</label>
                        <select name="role" class="form-select" required>
                            <option value="">-- Select Role --</option>
                            <option value="RECEPTIONIST" ${f_role == 'RECEPTIONIST' ? 'selected' : ''}>Receptionist</option>
                            <option value="ADMIN" ${f_role == 'ADMIN' ? 'selected' : ''}>Administrator</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="bi bi-lock me-1"></i> Password *</label>
                        <input type="password" name="password" class="form-control" required minlength="6" placeholder="At least 6 characters">
                    </div>
                    <div class="mb-4">
                        <label class="form-label"><i class="bi bi-key me-1"></i> Confirm Password *</label>
                        <input type="password" name="confirmPassword" class="form-control" required minlength="6" placeholder="Re-enter password">
                    </div>
                    <button type="submit" class="btn btn-add-staff w-100 d-inline-flex align-items-center justify-content-center gap-2">
                        <i class="bi bi-plus-lg"></i>
                        <span>Add Staff Member</span>
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Table: Existing Staff Accounts -->
    <div class="col-lg-7">
        <div class="card staff-card">
            <div class="staff-card-header d-flex align-items-center gap-2">
                <i class="bi bi-list-ul text-primary fs-5"></i>
                <h5 class="fw-bold text-dark mb-0">All Staff Accounts</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover staff-table mb-0 align-middle">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th class="text-end">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty staffList}">
                                <tr>
                                    <td colspan="5" class="text-center text-muted py-5">
                                        <i class="bi bi-person-x fs-2 d-block mb-2 opacity-50"></i>
                                        No staff accounts found.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="s" items="${staffList}">
                                    <tr>
                                        <td>
                                            <div class="fw-semibold text-dark d-inline-flex align-items-center gap-1">
                                                <c:out value="${s.fullName}"/>
                                                <c:if test="${s.staffId == sessionScope.staffId}">
                                                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-0.5 rounded-pill fw-semibold small ms-1">You</span>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="font-monospace small text-dark"><c:out value="${s.username}"/></span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${s.role == 'ADMIN'}">
                                                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2.5 py-1 rounded-pill fw-semibold">
                                                        <i class="bi bi-shield-lock me-1"></i> Admin
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2.5 py-1 rounded-pill fw-semibold">
                                                        <i class="bi bi-person me-1"></i> Receptionist
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${s.active}">
                                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-2.5 py-1 rounded-pill fw-semibold">
                                                        Active
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2.5 py-1 rounded-pill fw-semibold">
                                                        Inactive
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end">
                                            <c:choose>
                                                <c:when test="${s.staffId == sessionScope.staffId}">
                                                    <span class="text-muted small fst-italic">Current user</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <form method="post" action="<%=request.getContextPath()%>/ManageStaffServlet" class="d-inline">
                                                        <input type="hidden" name="action" value="toggle">
                                                        <input type="hidden" name="staffId" value="${s.staffId}">
                                                        <input type="hidden" name="newStatus" value="${s.active ? '0' : '1'}">
                                                        <button type="submit" class="btn btn-sm ${s.active ? 'btn-outline-danger' : 'btn-outline-success'} rounded-2 px-2.5 py-1 fw-semibold"
                                                                onclick="return confirm('${s.active ? 'Deactivate' : 'Reactivate'} this staff account?');">
                                                            <i class="bi ${s.active ? 'bi-slash-circle' : 'bi-check-circle'} me-1"></i>
                                                            <c:out value="${s.active ? 'Deactivate' : 'Reactivate'}"/>
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- Guidance Note -->
                <div class="info-note-box d-flex align-items-start gap-2">
                    <i class="bi bi-info-circle text-primary fs-6 mt-0.5"></i>
                    <span>Deactivated staff members cannot log in, but their historical actions and records remain preserved in system logs.</span>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>