<%@ include file="common/header.jspf" %>
<div class="container my-2">
    <div class="card card-cascade wider ">
        <div class="view view-cascade gradient-card-header morpheus-den-gradient ">
            <h2 class="card-header-title mt-3 text-center text-light">Manage SnapShots</h2>

        </div>
        <div class="card-body card-body-cascade text-centery">

            <c:if test="${role.equals('ROLE_USER')}">
                <table class="table table-striped" style="margin-top: 20px;">
                    <thead>
                    <tr>
                        <th scope="col">Country</th>
                        <th scope="col">Total Cases</th>
                        <th scope="col">Total Deaths</th>
                        <th scope="col">New Cases</th>
                        <th scope="col">Actions</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach items="${stats}" var="stat">
                        <tr>

                            <td>${stat.getCountryName()}</td>
                            <td>${stat.getTotalCases()}</td>
                            <td>${stat.getTotalDeaths()}</td>
                            <td>${stat.getNewCases()}</td>
                            <td>
                                <form method="GET" action="/delete/stat">
                                    <input type="hidden" value="${stat.getId()}" name="statId">
                                    <button type="submit" class="btn btn-unique waves-effect waves-light btn-sm">delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${role.equals('ROLE_ADMIN')}">

                <table class="table table-striped" style="margin-top: 20px;">
                    <thead>
                    <tr>
                        <th scope="col">Country</th>
                        <th scope="col">Total Cases</th>
                        <th scope="col">Total Deaths</th>
                        <th scope="col">New Cases</th>
                        <th scope="col">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${stats}" var="stat">
                        <tr>
                            <form method="POST" action="/update/stat">
                                <td>
                                    <input type="text" value="${stat.getCountryName()}" name="countryName">

                                </td>
                                <td>
                                    <input type="text" value="${stat.getTotalCases()}" name="totalCases">

                                </td>
                                <td>
                                    <input type="text" value="${stat.getTotalDeaths()}" name="totalDeaths">

                                </td>
                                <td>
                                    <input type="text" value="${stat.getNewCases()}" name="newCases">

                                </td>

                                <td>

                                    <input type="hidden" value="${stat.getId()}" name="statId">
                                    <button type="submit" class="btn btn-unique waves-effect waves-light btn-sm">update</button>

                                </td>
                            </form>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

            </c:if>
        </div>
    </div>
</div>