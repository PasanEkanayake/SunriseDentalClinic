<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .treatment-card {
        border: 1px solid #e2e8f0;
        border-radius: 20px;
        background: #ffffff;
        box-shadow: 0 12px 32px rgba(10, 37, 64, 0.05);
        overflow: hidden;
    }

    .treatment-card-header {
        background: #f8fafc;
        border-bottom: 1px solid #e2e8f0;
        padding: 1.25rem 1.5rem;
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

    .form-label {
        font-weight: 600;
        font-size: 0.85rem;
        color: #475569;
        margin-bottom: 0.4rem;
    }

    .input-group-text {
        background-color: #f8fafc;
        border-color: #cbd5e1;
        color: #64748b;
        font-weight: 600;
        border-top-left-radius: 10px;
        border-bottom-left-radius: 10px;
        padding-left: 1rem;
        padding-right: 1rem;
    }

    .form-control {
        border-color: #cbd5e1;
        padding: 0.7rem 0.9rem;
        border-radius: 10px;
        font-size: 0.95rem;
    }

    .input-group .form-control {
        border-top-left-radius: 0;
        border-bottom-left-radius: 0;
    }

    .form-control:focus {
        border-color: #0284c7;
        box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.15);
    }

    .btn-add-treatment {
        background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
        color: #ffffff;
        font-weight: 600;
        padding: 0.75rem 1.5rem;
        border-radius: 10px;
        border: none;
        box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
        transition: all 0.2s ease;
    }

    .btn-add-treatment:hover {
        background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 6px 16px rgba(2, 132, 199, 0.3);
    }

    .treatment-table th {
        color: #64748b;
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-weight: 700;
        background-color: #f8fafc;
        padding: 1rem 1.25rem;
    }

    .treatment-table td {
        padding: 1rem 1.25rem;
    }

    .info-note-box {
        background-color: #f8fafc;
        border-top: 1px solid #e2e8f0;
        padding: 1rem 1.25rem;
        font-size: 0.875rem;
        color: #64748b;
    }
</style>

<!-- Top Title Bar -->
<div class="d-flex align-items-center justify-content-between mb-4">
    <div class="d-flex align-items-center gap-3">
        <div class="header-icon-box fs-4">
            <i class="bi bi-clipboard2-pulse-fill"></i>
        </div>
        <div>
            <h4 class="fw-bold text-dark mb-0">Manage Treatments</h4>
            <p class="text-muted small mb-0">Configure medical procedures and base service pricing</p>
        </div>
    </div>
    <a href="<%=request.getContextPath()%>/AdminPanelServlet" class="btn btn-light border fw-semibold text-secondary px-3 py-2">
        <i class="bi bi-arrow-left me-1"></i> Admin Panel
    </a>
</div>

<div class="row g-4">
    <!-- Form: Add New Treatment -->
    <div class="col-lg-5">
        <div class="card treatment-card">
            <div class="treatment-card-header d-flex align-items-center gap-2">
                <i class="bi bi-plus-square text-primary fs-5"></i>
                <h5 class="fw-bold text-dark mb-0">Add New Treatment Type</h5>
            </div>
            <div class="card-body p-4">
                <form method="post" action="<%=request.getContextPath()%>/ManageTreatmentServlet">
                    <div class="mb-3">
                        <label class="form-label"><i class="bi bi-journal-medical me-1"></i> Treatment Name *</label>
                        <input type="text" name="treatmentName" class="form-control" required value="${f_treatmentName}" placeholder="e.g. Dental Implant">
                    </div>
                    <div class="mb-4">
                        <label class="form-label"><i class="bi bi-tag me-1"></i> Cost *</label>
                        <div class="input-group">
                            <span class="input-group-text">Rs.</span>
                            <input type="number" name="cost" class="form-control" required step="0.01" min="0.01" value="${f_cost}" placeholder="e.g. 25000.00">
                        </div>
                        <div class="form-text small text-muted mt-1">This is the base procedure cost. The standard consultation fee is added automatically during billing.</div>
                    </div>
                    <button type="submit" class="btn btn-add-treatment w-100 d-inline-flex align-items-center justify-content-center gap-2">
                        <i class="bi bi-check-lg"></i>
                        <span>Add Treatment Type</span>
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Table: Existing Treatment Types -->
    <div class="col-lg-7">
        <div class="card treatment-card">
            <div class="treatment-card-header d-flex align-items-center gap-2">
                <i class="bi bi-list-ul text-primary fs-5"></i>
                <h5 class="fw-bold text-dark mb-0">All Treatment Types</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover treatment-table mb-0 align-middle">
                        <thead>
                        <tr>
                            <th>Treatment</th>
                            <th>Cost</th>
                            <th>Status</th>
                            <th class="text-end">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty treatmentList}">
                                <tr>
                                    <td colspan="4" class="text-center text-muted py-5">
                                        <i class="bi bi-clipboard-x fs-2 d-block mb-2 opacity-50"></i>
                                        No treatment types found.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="t" items="${treatmentList}">
                                    <tr>
                                        <td>
                                            <div class="fw-semibold text-dark"><c:out value="${t.treatmentName}"/></div>
                                        </td>
                                        <td>
                                            <span class="font-monospace fw-medium text-dark">Rs. <fmt:formatNumber value="${t.cost}" pattern="#,##0.00"/></span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${t.active}">
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
                                            <form method="post" action="<%=request.getContextPath()%>/ManageTreatmentServlet" class="d-inline">
                                                <input type="hidden" name="action" value="toggle">
                                                <input type="hidden" name="treatmentId" value="${t.treatmentId}">
                                                <input type="hidden" name="newStatus" value="${t.active ? '0' : '1'}">
                                                <button type="submit" class="btn btn-sm ${t.active ? 'btn-outline-danger' : 'btn-outline-success'} rounded-2 px-2.5 py-1 fw-semibold"
                                                        onclick="return confirm('${t.active ? 'Deactivate' : 'Reactivate'} this treatment type?');">
                                                    <i class="bi ${t.active ? 'bi-slash-circle' : 'bi-check-circle'} me-1"></i>
                                                    <c:out value="${t.active ? 'Deactivate' : 'Reactivate'}"/>
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
                    <span>Deactivating a treatment hides it from the appointment registration form while preserving all existing appointment and billing history.</span>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>