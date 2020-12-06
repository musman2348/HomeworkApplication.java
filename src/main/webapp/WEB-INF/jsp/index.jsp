<%@ include file="common/header.jspf" %>
<div class="container my-2">
    <div class="card card-cascade wider">
        <div class="view view-cascade gradient-card-header morpheus-den-gradient">
            <h2 class="card-header-title mb-3 text-center text-light">Select Criteria</h2>

        </div>
        <div class="card-body card-body-cascade text-center">

            <form action="/stats">

                <select class="col custom-select custom-select-sm" name='country'>
                    <option selected>Select Country</option>
                    <c:forEach items="${countries}" var="country">
                        <option value="${country.key}">${country.value}</option>
                    </c:forEach>
                </select>
                <div class="col md-form md-outline input-with-post-icon datepicker ">
                    <input required placeholder="Select date" name="date" type="date" id="formats-example"
                           class="form-control"/>
                    <label for="formats-example">Select Date</label>
                </div>


                <div class="col justify-content-center">
                    <button type="submit" class="btn btn-unique waves-effect waves-light">Fetch Data <i
                            class="fas fa-paper-plane-o ml-1"></i></button>
                </div>
            </form>

        </div>
    </div>

    <c:if test="${stats != null}">
    <div class="card card-cascade wider mt-5">
        <div class="view view-cascade gradient-card-header morpheus-den-gradient">
            <h2 class="card-header-title mb-3 text-center text-light">${countryName}</h2>

        </div>
        <div class="card-body card-body-cascade text-center">
            <ul class="list-group ">
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Date
                    <span>${stats.date}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Confirmed
                    <span>${stats.todayConfirmed}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Deaths
                    <span>${stats.todayDeaths}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today New Confirmed
                    <span>${stats.todayNewConfirmed}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today New Deaths
                    <span>${stats.todayNewDeaths}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today New Open Cases
                    <span>${stats.todayNewOpenCases}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today New Recovered
                    <span>${stats.todayNewRecovered}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Open Cases
                    <span>${stats.todayOpenCases}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Recovered
                    <span>${stats.todayRecovered}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Vs Yesterday Confirmed
                    <span>${stats.todayVsYesterdayConfirmed}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Vs Yesterday Deaths
                    <span>${stats.todayVsYesterdayDeaths}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Vs Yesterday Open Cases
                    <span>${stats.todayVsYesterdayOpenCases}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Today Vs Yesterday Recovered
                    <span>${stats.todayVsYesterdayRecovered}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Yesterday Confirmed
                    <span>${stats.yesterdayConfirmed}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Yesterday Deaths
                    <span>${stats.yesterdayDeaths}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Yesterday Open Cases
                    <span>${stats.yesterdayOpenCases}</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Yesterday Recovered
                    <span>${stats.yesterdayRecovered}</span>
                </li>

            </ul>
            <div class="row">
                <div class="col"></div>
                <div class="col"></div>
                <div class="col"></div>
                <div class="col">
                        <%--                    <form:form modelAttribute="stats" action="/save" method="POST">--%>
                        <%--                    <button type="submit" style="margin-top: 10px;"   class="btn btn-primary btn-lg btn-block btn-sm pull-right">Save</button>--%>
                        <%--                    </form:form>--%>
                    <form method="POST"
                          action="/save">

                        <input type="hidden" name="countryName" id="nameField" class="form-control"
                               value="${countryName}"/>
                        <input type="hidden" name="date" value="${stats.date}"/>
                        <input type="hidden" name="totalCases" value="${stats.todayConfirmed}"/>
                        <input type="hidden" name="totalDeaths" value="${stats.todayDeaths}"/>
                        <input type="hidden" name="newCases" value="${stats.todayNewConfirmed}"/>
                        <button type="submit" style="margin-top: 10px;"
                                class="btn btn-unique waves-effect waves-light btn-lg btn-block btn-sm pull-right">Save
                        </button>
                    </form>
                </div>
            </div>

        </div>
        </c:if>
    </div>
</div>
<script>
    $('.datepicker').datepicker({
// Escape any “rule” characters with an exclamation mark (!).
        format: 'You selecte!d: dddd, dd mmm, yyyy',
        formatSubmit: 'yyyy/mm/dd',
        hiddenPrefix: 'prefix__',
        hiddenSuffix: '__suffix'
    })
</script>
</body>

</html>
