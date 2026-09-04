<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .settings-card {
        border: 1px solid #e2e8f0;
        border-radius: 20px;
        background: #ffffff;
        box-shadow: 0 12px 32px rgba(10, 37, 64, 0.05);
        overflow: hidden;
    }

    .settings-card-header {
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
        border-top-right-radius: 10px;
        border-bottom-right-radius: 10px;
        font-size: 0.95rem;
    }

    .form-control:focus {
        border-color: #0284c7;
        box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.15);
    }

    .info-note-box {
        background-color: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        padding: 1rem 1.25rem;
        font-size: 0.875rem;
        color: #64748b;
    }

    .btn-save {
        background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
        color: #ffffff;
        font-weight: 600;
        padding: 0.75rem 1.5rem;
        border-radius: 10px;
        border: none;
        box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
        transition: all 0.2s ease;
    }

    .btn-save:hover {
        background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 6px 16px rgba(2, 132, 199, 0.3);
    }
</style>

<!-- Top Title Bar -->
<div class="d-flex align-items-center justify-content-between mb-4">
    <div class="d-flex align-items-center gap-3">
        <div class="header-icon-box fs-4">
            <i class="bi bi-gear-fill"></i>
        </div>
        <div>
            <h4 class="fw-bold text-dark mb-0">Clinic Settings</h4>
            <p class="text-muted small mb-0">Configure global parameters and default consultation charges</p>
        </div>
    </div>
    <a href="<%=request.getContextPath()%>/AdminPanelServlet" class="btn btn-light border fw-semibold text-secondary px-3 py-2">
        <i class="bi bi-arrow-left me-1"></i> Admin Panel
    </a>
</div>

<div class="row justify-content-center">
    <div class="col-lg-6 col-xl-5">
        <div class="card settings-card">
            <!-- Header -->
            <div class="settings-card-header d-flex align-items-center gap-2">
                <i class="bi bi-cash-coin text-primary fs-5"></i>
                <h5 class="fw-bold text-dark mb-0">Consultation Fee Configuration</h5>
            </div>

            <div class="card-body p-4 p-sm-5">
                <!-- Info Callout Box -->
                <div class="info-note-box d-flex align-items-start gap-2 mb-4">
                    <i class="bi bi-info-circle-fill text-primary fs-6 mt-0.5"></i>
                    <span>This flat fee is automatically added to the treatment cost when generating bills. Updating this value affects future bills only—existing receipts remain unchanged.</span>
                </div>

                <!-- Form -->
                <form method="post" action="<%=request.getContextPath()%>/ManageSettingsServlet">
                    <div class="mb-4">
                        <label class="form-label"><i class="bi bi-tag me-1"></i> Standard Consultation Fee *</label>
                        <div class="input-group">
                            <span class="input-group-text">Rs.</span>
                            <input type="number" name="consultationFee" class="form-control" required step="0.01" min="0"
                                   value="${consultationFee}" placeholder="0.00">
                        </div>
                    </div>

                    <button type="submit" class="btn btn-save w-100 d-inline-flex align-items-center justify-content-center gap-2">
                        <i class="bi bi-check-lg"></i>
                        <span>Save Changes</span>
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>