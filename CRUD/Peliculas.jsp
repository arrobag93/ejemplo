<%-- 
Author: Rafael Aragón Rodríguez
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Películas y Series</title>

        <!--Bootstrap 3-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


        <!--Bootstrap 4-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


        <!--Enlaces propios-->
        <link rel="stylesheet" type="text/css" href="main.css">
        <script type="text/javascript" src="javascript.js"></script>
        <link rel="shortcut icon" href="img/favicon.ico">

        <!--Fontawesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

    </head>
    <body>

        <%
          request.setCharacterEncoding("UTF-8");

          Class.forName("com.mysql.jdbc.Driver");
          Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "");
          Statement s = conexion.createStatement();

          ResultSet listado = s.executeQuery("SELECT * FROM socio");
          HttpSession sesion = request.getSession();
        %>

        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Películas <b>Por Ver</b> de <i><%out.print(sesion.getAttribute("nombre")); %></i></h2>
                        </div>
                        <div class="col-sm-6">
                            <a href="#addEmployeeModal" class="btn btn-secondary" data-toggle="modal"><i class="fas fa-play"></i><span>Añadir Película</span></a>						
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Nombre</th>
                            <th>Género</th>
                            <th>Saga</th>
                            <th>Duración (min)</th>
                            <th></th>
                        </tr>
                    </thead>
                    <br>
                    <input class="form-control form-control-lg" id="myInput" type="text" placeholder="Filtra por nombre, género, saga...">
                    <tbody id="myTable">
                        <%
                          while (listado.next()) {
                        %>
                        <tr>
                            <td><% out.println(listado.getString("IdPel"));  %></td>
                            <td><% out.println(listado.getString("NomPel")); %></td>
                            <td><% out.println(listado.getString("GenPel")); %></td>
                            <td><% out.println(listado.getString("SagPel")); %></td>
                            <td><% out.println(listado.getString("DurPel"));%></td>
                            <td>
                                <a href="#editEmployeeModal<%= listado.getString("IdPel")%>" class="edit" data-toggle="modal"><i class="fas fa-pencil-alt"></i></a>
                                <!--Editar Película-->
                                <div id="editEmployeeModal<%= listado.getString("IdPel")%>" class="modal fade">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <form action="actualizapelicula.jsp" method="post">
                                                <div class="modal-header">						
                                                    <h4 class="modal-title">Editar película</h4>
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                </div>
                                                <div class="modal-body">
                                                    <input type="hidden" name="actualizarPelicula" value="<%= listado.getString("IdPel")%>">
                                                    <div class="form-group">
                                                        <label>Nombre</label>
                                                        <input type="text" class="form-control" name="NomPel" placeholder="<%= listado.getString("NomPel")%>" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Género</label>
                                                        <input type="text" class="form-control" name="GenPel" placeholder="<%= listado.getString("GenPel")%>" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Saga (si tiene)</label>
                                                        <input type="text" class="form-control" name="SagPel" placeholder="<%= listado.getString("SagPel")%>">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Duración (min)</label>
                                                        <input type="number" min="1" step="1" class="form-control" name="DurPel" placeholder="<%= listado.getString("DurPel")%>" required>
                                                    </div>					
                                                </div>
                                                <div class="modal-footer">
                                                    <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancelar">
                                                    <input type="submit" class="btn btn-info" value="Editar">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <a href="#deleteEmployeeModal<%= listado.getString("IdPel")%>" class="delete" data-toggle="modal"><i class="fas fa-bomb"></i></a>
                                <!--Borrar Película-->
                                <div id="deleteEmployeeModal<%= listado.getString("IdPel")%>" class="modal fade">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <form action="borrapelicula.jsp" methos="post">
                                                <div class="modal-header">						
                                                    <h4 class="modal-title">Borrar película</h4>
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                </div>
                                                <div class="modal-body">					
                                                    <p>¿Seguro que quieres borrar esta película?</p>
                                                    <p><%= listado.getString("NomPel")%></p>
                                                    <input type="hidden" name="borrarPelicula" value="<%= listado.getString("IdPel")%>">
                                                    <p class="text-warning"><small>Una vez hecho no podrá recuperarse.</small></p>
                                                </div>
                                                <div class="modal-footer">
                                                    <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancelar">
                                                    <input type="submit" class="btn btn-danger" value="Borrar">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <%
                          }
                          conexion.close();
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <!--Añadir Película-->
        <div id="addEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="nuevapelicula.jsp" method="post">
                        <div class="modal-header">						
                            <h4 class="modal-title">Añadir Película</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <div class="form-group">
                                <label>Nombre</label>
                                <input type="text" class="form-control" name="NomPel" required>
                            </div>
                            <div class="form-group">
                                <label>Género</label>
                                <input type="text" class="form-control" name="GenPel" required>
                            </div>
                            <div class="form-group">
                                <label>Saga (si tiene)</label>
                                <input type="text" class="form-control" name="SagPel">
                            </div>
                            <div class="form-group">
                                <label>Duración (min)</label>
                                <input type="number" min="1" step="1" class="form-control" name="DurPel" required>
                            </div>					
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancelar">
                            <input type="submit" class="btn btn-success" value="Añadir">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!--Volver al índice-->
        <form action="index.jsp" method="post">
            <div class="col-11">
                <div class="col-xs-6">
                </div>
                <div class="col-xs-2">
                    <input type = "hidden" name = "nombre" value = "<%sesion.getAttribute("nombre");%>" />
                    <input type = "hidden" name = "contrasena" value = "<%sesion.getAttribute("contraseña");%>" />
                    <input type="submit" class="btn-danger btn-lg " value="Volver"> 
                </div>
            </div>
        </form>
        <script>
            $(document).ready(function () {
                $("#myInput").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#myTable tr").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
        </script>
    </body>
</html>                        