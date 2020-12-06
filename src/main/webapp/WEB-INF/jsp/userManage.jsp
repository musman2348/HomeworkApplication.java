<%@ include file="common/header.jspf" %>
<div class="container my-2">
    <%--    <div class="row">--%>
    <%--        <div class="col">--%>
    <div class="card card-cascade wider">
        <div class="view view-cascade gradient-card-header morpheus-den-gradient">
            <h2 class="card-header-title mt-3 text-center text-light">Create User</h2>

        </div>
        <div class="card-body card-body-cascade text-center">
            <form method="POST" action="/create/user">
                <div class="">
                    <input type="text" name="username" id="Form-email1" class="form-control"
                           placeholder="Username"></input>
                </div>

                <div class="mt-4 ">

                    <input type="password" name="password" id="exampleForm2" class="form-control"
                           placeholder="password">
                </div>
                <div class="md-form ">
                    <select class="custom-select custom-select-sm" name='role'>
                        <option value="ROLE_USER">USER</option>
                        <option value="ROLE_ADMIN">ADMIN</option>
                    </select>
                </div>

                <div class="text-center mb-3">
                    <button type="submit"
                            class="btn btn-unique waves-effect waves-light btn-block btn-rounded z-depth-1a">Create New
                        User
                    </button>
                </div>
            </form>
        </div>
    </div>
    <div class="card card-cascade wider mt-5">
        <div class="view view-cascade gradient-card-header morpheus-den-gradient">
            <h2 class="card-header-title mt-3 text-center text-light">Available Users</h2>

        </div>
        <div class="card-body card-body-cascade text-center">
            <table class="table table-striped" style="margin-top: 20px;">
                <thead>
                <tr>
                    <th scope="col">Username</th>
                    <th scope="col">Password</th>
                    <th scope="col">Role</th>
                    <th scope="col">Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="user">
                    <tr>

                        <td>${user.getName()}</td>
                        <td>${user.getPassword()}</td>
                        <td>${user.getRole()}</td>
                        <td>
                            <form method="POST" action="/delete/user">
                                <input type="hidden" value="${user.getId()}" name="userId">
                                <button type="submit" class="btn btn-unique waves-effect waves-light btn-sm">delete
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
    </div>


</div>
</body>

</html>
