<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .dentist-card {
        border: 1px solid #e2e8f0;
        border-radius: 20px;
        background: #ffffff;
        box-shadow: 0 12px 32px rgba(10, 37, 64, 0.05);
        overflow: hidden;
    }

    .dentist-card-header {
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

    .form-control {
        border-color: #cbd5e1;
        padding: 0.7rem 0.9rem;
        border-radius: 10px;
        font-size: 0.95rem;
    }

    .form-control:focus {
        border-color: #0284c7;
        box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.15);
    }

    .btn-add-dentist {
        background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
        color: #ffffff;
        font-weight: 600;
        padding: 0.75rem 1.5rem;
        border-radius: 10px;
        border: none;
        box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
        transition: all 0.2s ease;
    }

    .btn-add-dentist:hover {
        background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 6px 16px rgba(2, 132, 199, 0.3);
    }

    .dentist-table th {
        color: #64748b;
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-weight: 700;
        background-color: #f8fafc;
        padding: 1rem 1.25rem;
    }

    .dentist-table td {
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
            <i class="bi bi-person-badge-fill"></i>
        </div>
        <div>
            <h4 class="fw-bold text-dark mb-0">Manage Dentists</h4>
            <p class="text-muted small mb-0">Add clinical practitioners or adjust active availability</p>
        </div>
    </div>
    <a href="<%=request.getContextPath()%>/AdminPanelServlet" class="btn btn-light border fw-semibold text-secondary px-3 py-2">
        <i class="bi bi-arrow-left me-1"></i> Admin Panel
    </a>
</div>

<div class="row g-4">
    <!-- Form: Add New Dentist -->
    <div class="col-lg-5">
        <div class="card dentist-card">
            <div class="dentist-card-header d-flex align-items-center gap-2">
                <i class="bi bi-person-plus text-primary fs-5"></i>
                <h5 class="fw-bold text-dark mb-0">Add New Dentist</h5>
            </div>
            <div class="card-body p-4">
                <form method="post" action="<%=request.getContextPath()%>/ManageDentistServlet">
                    <div class="mb-3">
                        <label class="form-label"><i class="bi bi-person me-1"></i> Dentist Name *</label>
                        <input type="text" name="dentistName" class="form-control" required value="${f_dentistName}" placeholder="e.g. Dr. Priya Rathnayake">
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="bi bi-award me-1"></i> Specialization</label>
                        <input type="text" name="specialization" class="form-control" value="${f_specialization}" placeholder="e.g. Pediatric Dentistry">
                    </div>
                    <div class="mb-4">
                        <label class="form-label"><i class="bi bi-telephone me-1"></i> Contact Number</label>
                        <input type="text" name="contactNumber" class="form-control" value="${f_contactNumber}" placeholder="e.g. 0712345678">
                    </div>
                    <button type="submit" class="btn btn-add-dentist w-100 d-inline-flex align-items-center justify-content-center gap-2">
                        <i class="bi bi-plus-lg"></i>
                        <span>Add Dentist</span>
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Table: Existing Dentists -->
    <div class="col-lg-7">
        <div class="card dentist-card">
            <div class="dentist-card-header d-flex align-items-center gap-2">
                <i class="bi bi-list-ul text-primary fs-5"></i>
                <h5 class="fw-bold text-dark mb-0">All Dentists</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover dentist-table mb-0 align-middle">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Specialization</th>
                            <th>Contact</th>
                            <th>Status</th>
                            <th class="text-end">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty dentistList}">
                                <tr>
                                    <td colspan="5" class="text-center text-muted py-5">
                                        <i class="bi bi-person-x fs-2 d-block mb-2 opacity-50"></i>
                                        No dentists found in the system.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="d" items="${dentistList}">
                                    <tr>
                                        <td>
                                            <div class="fw-semibold text-dark"><c:out value="${d.dentistName}"/></div>
                                        </td>
                                        <td>
                                            <span class="text-secondary small">
                                                <c:choose>
                                                    <c:when test="${not empty d.specialization}">
                                                        <c:out value="${d.specialization}"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted opacity-75">General</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="font-monospace small text-dark"><c:out value="${d.contactNumber}"/></span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${d.active}">
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
                                            <form method="post" action="<%=request.getContextPath()%>/ManageDentistServlet" class="d-inline">
                                                <input type="hidden" name="action" value="toggle">
                                                <input type="hidden" name="dentistId" value="${d.dentistId}">
                                                <input type="hidden" name="newStatus" value="${d.active ? '0' : '1'}">
                                                <button type="submit" class="btn btn-sm ${d.active ? 'btn-outline-danger' : 'btn-outline-success'} rounded-2 px-2.5 py-1 fw-semibold"
                                                        onclick="return confirm('${d.active ? 'Deactivate' : 'Reactivate'} this dentist?');">
                                                    <i class="bi ${d.active ? 'bi-slash-circle' : 'bi-check-circle'} me-1"></i>
                                                    <c:out value="${d.active ? 'Deactivate' : 'Reactivate'}"/>
                                                </button>
                                            </form>
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
                    <span>Deactivating a practitioner hides them from new appointment bookings while preserving all historical visit logs and billing records.</span>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>