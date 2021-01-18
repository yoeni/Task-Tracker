<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="Task_Tracer.WebForm1" %>

<!doctype html>
<html class="no-js" lang="">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Task Tracker</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,700,900" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/owl.carousel.css">
    <link rel="stylesheet" href="css/owl.theme.css">
    <link rel="stylesheet" href="css/owl.transitions.css">
    <link rel="stylesheet" href="css/meanmenu/meanmenu.min.css">
    <link rel="stylesheet" href="css/wave/button.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/scrollbar/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="css/jvectormap/jquery-jvectormap-2.0.3.css">
    <link rel="stylesheet" href="css/notika-custom-icon.css">
    <link rel="stylesheet" href="css/wave/waves.min.css">
    <link rel="stylesheet" href="css/main2.css">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="js/vendor/modernizr-2.8.3.min.js"></script>
</head>

<body>
    <div class="header-top-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <div class="logo-area">
                        <a href="#">
                            <h1> <font face="Agency Fb" color="white">Tak Tracker</font></h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form runat="server">
        <div class="mobile-menu-area">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="mobile-menu">
                            <nav id="dropdown">
                                <ul class="mobile-menu-nav">
                                    <li><a data-target="#Charts" href="main.aspx">Home</a></li>
                                    <li><a href="addtask.aspx"><i class="notika-icon notika-edit"></i>Add Task</a></li>
                                    <li> <a ID="savebuttonmobile" OnClick="get_list_items();" Style="color: #009688; border-width: 2px; border-color: seagreen;"><i class="notika-icon notika-checked"></i> <b>KAYDET</b></a></li>
                                    <li><asp:LinkButton ID="cikisMobileButton" Style="color: coral; border-width: 2px; border-color:coral;" runat="server" OnClick="cikisMobileButton_Click">Çıkış</asp:LinkButton></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="main-menu-area mg-tb-40">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <ul class="nav nav-tabs notika-menu-wrap menu-it-icon-pro">
                            <li class="active"><a data-toggle="tab" href="#Home"><i class="notika-icon notika-house"></i>Home</a>
                            </li>
                            <li><a href="addtask.aspx"><i class="notika-icon notika-edit"></i>Add Task</a>
                            </li>
                            <%--<li style="float: right;"><a data-toggle="tab" href="#" onclick='get_list_items();' Style="color: #009688; border-width: 2px; border-color: seagreen;"><i class="notika-icon notika-checked"></i> <b>KAYDET</b></a>
                            </li>--%>
                            <li style="float:right">
                                <asp:LinkButton ID="LinkButton1" Style="color: coral; border-width: 2px; border-color:coral;" runat="server" OnClick="cikisMobileButton_Click">Çıkış</asp:LinkButton>
                                </li>
                            <li style="float: right;">
                                <a ID="savebutton" href="" OnClick="get_list_items();" Style="color: #009688; border-width: 2px; border-color: seagreen;"><i class="notika-icon notika-checked"></i> <b>KAYDET</b></a>
                               
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="realtime-statistic-area" style="width: 100%">
            <div class="container" style="width: 100%; align-content: center">
                <div class="row">
                    <asp:HiddenField ID="todo" runat="server" />
                    <asp:HiddenField ID="inprogress" runat="server" />
                    <asp:HiddenField ID="revision" runat="server" />
                    <asp:HiddenField ID="check" runat="server" />
                    <asp:HiddenField ID="done" runat="server" />
                    <div class="col-lg-2 col-md-6 col-sm-6 col-xs-12">
                        <div class="add-todo-list notika-shadow mg-t-30">
                            <div class="realtime-ctn">
                                <div class="realtime-title">
                                    <h2>Todo</h2>
                                </div>
                            </div>
                            <div class="card-box">
                                <div class="todoapp">
                                    <div class="notika-todo-scrollbar">
                                        <asp:Repeater ID="todolistRepeater" runat="server" OnItemCommand="todolistRepeater_ItemCommand">
                                            <HeaderTemplate>
                                                <ul class="list-group no-margn todo-list connectedSortable" style="height: 100%; background-color: #82d9c0; border-radius: 5px;" id="todolist">
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <li class="ui-state-default">
                                                                <input id="taskId" runat="server" type="hidden" value='<%# Eval("taskId") %>' />
                                                    <div style="background-color: #a1f2de; border-radius: 5px;">
                                                        <div class="past-statistic-an">
                                                            <div class="past-statistic-ctn\">
                                                                <font size="1" style="color:gray;"><%#  Eval("taskDate").ToString().Substring(0,10) %>-<%# Eval("name") %></font><br />
                                                                <font size="2"><b><span> <%# Eval("taskName") %></span></b></font><br />
                                                                <p><%# Eval("description") %></p>

                                                            </div>
                                                            <div class="past-statistic-graph">
                                                                <table>


                                                                    <tr>
                                                                        <td>
                                                                            <asp:LinkButton Style="border-radius: 50%; float: right; padding-top: 26%; padding-bottom: 19%; margin-bottom: 0px;" ID="deletebutton" runat="server" CommandArgument='<%# Eval("taskId") %>' class="btn btn-default btn-icon-notika waves-effect" CommandName="delete"><i class="notika-icon notika-close"></i></asp:LinkButton>

                                                                        </td>

                                                                    </tr>
                                                                    <tr>
                                                                        <td>

                                                                            <div class="form-ic-cmp"><i class="notika-icon notika-next"></i></div>
                                                                        </td>
                                                                        
                                                                    </tr>
                                                                    <tr>
                                                                        <td><div class="form-ic-cmp" style="width: 100%; padding: 0px; display: flex;">
                                                                            <asp:LinkButton ID="openbutton" runat="server"  class="btn btn-reco-mg btn-button-mg waves-effect" style="padding:0px; width:100%; font-weight:bold;" CommandArgument='<%# Eval("taskId") %>' CommandName="open">...</asp:LinkButton>
                                                                        </div>
                                                                            </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                       
                                                 </div>
                                                </li>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </ul>
                                            </FooterTemplate>
                                        </asp:Repeater>

                                    </div>
                                    <div id="todo-form">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12 col-sm-12 col-xs-12 todo-inputbar">
                                                <div class="form-group todo-flex">
                                                    <div class="todo-send">
                                                        <asp:LinkButton class="btn-primary btn-md btn-block btn notika-add-todo" id="todobutton" runat="server" OnClick="todobutton_Click">Add</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-6 col-xs-12">
                        <div class="add-todo-list notika-shadow mg-t-30">
                            <div class="realtime-ctn">
                                <div class="realtime-title">
                                    <h2>In Progress</h2>
                                </div>
                            </div>
                            <div class="card-box">
                                <div class="todoapp">
                                    <div class="notika-todo-scrollbar">

                                        <asp:Repeater ID="inprogresslistRepeater" runat="server" OnItemCommand="inprogresslistRepeater_ItemCommand">
                                            <HeaderTemplate>
                                                <ul class="list-group no-margn todo-list connectedSortable" style="height: 100%; background-color: #82d9c0; border-radius: 5px;" id="inprogresslist">
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <li class="ui-state-default">
                                                    <div style="background-color: #a1f2de; border-radius: 5px;">
                                                        <div class="past-statistic-an">
                                                            <div class="past-statistic-ctn\">
                                                                <font size="1" style="color:gray;"><%# Eval("taskDate").ToString().Substring(0,10) %>-<%# Eval("name") %></font><br />
                                                                <font size="2"><b><span> <%# Eval("taskName") %></span></b></font>
                                                                <p><%# Eval("description") %></p>
                                                                <input id="taskId" runat="server" type="hidden" value='<%# Eval("taskId") %>' />
                                                            </div>
                                                            <div class="past-statistic-graph">
                                                               
                                                            <div class="past-statistic-graph">
                                                                <table>


                                                                    <tr>
                                                                        <td>
                                                                            <asp:LinkButton Style="border-radius: 50%; float: right; padding-top: 26%; padding-bottom: 19%; margin-bottom: 0px;" ID="deletebutton" runat="server" CommandArgument='<%# Eval("taskId") %>' class="btn btn-default btn-icon-notika waves-effect" CommandName="delete"><i class="notika-icon notika-close"></i></asp:LinkButton>

                                                                        </td>

                                                                    </tr>
                                                                    <tr>
                                                                        <td>

                                                                            <div class="form-ic-cmp"><i class="notika-icon notika-search"></i></div>
                                                                        </td>
                                                                        
                                                                    </tr>
                                                                    <tr>
                                                                        <td><div class="form-ic-cmp" style="width: 100%; padding: 0px; display: flex;">
                                                                            <asp:LinkButton ID="openbutton" runat="server"  class="btn btn-reco-mg btn-button-mg waves-effect" style="padding:0px; width:100%; font-weight:bold;" CommandArgument='<%# Eval("taskId") %>' CommandName="open">...</asp:LinkButton>
                                                                        </div>
                                                                            </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </ul>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </div>
                                    <div id="inprogress-form">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12 col-sm-12 col-xs-12 todo-inputbar">
                                                <div class="form-group todo-flex">
                                                    <div class="todo-send">
                                                        <asp:LinkButton class="btn-primary btn-md btn-block btn notika-add-todo" id="inprogressbutton" runat="server" OnClick="inprogressbutton_Click" >Add</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-6 col-xs-12">
                        <div class="add-todo-list notika-shadow mg-t-30">
                            <div class="realtime-ctn">
                                <div class="realtime-title">
                                    <h2>Revision</h2>
                                </div>
                            </div>
                            <div class="card-box">
                                <div class="todoapp">
                                    <div class="notika-todo-scrollbar">
                                        <asp:Repeater ID="revisionlistrepeater" runat="server" OnItemCommand="revisionlistrepeater_ItemCommand">
                                            <HeaderTemplate>
                                                <ul class="list-group no-margn todo-list connectedSortable" style="height: 100%; background-color: #82d9c0; border-radius: 5px;" id="revisionlist">
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <li class="ui-state-default">
                                                                <input id="taskId" runat="server" type="hidden" value='<%# Eval("taskId") %>' />
                                                    <div style="background-color: #a1f2de; border-radius: 5px;">
                                                        <div class="past-statistic-an">
                                                            <div class="past-statistic-ctn\">
                                                                <font size="1" style="color:gray;"><%# Eval("taskDate").ToString().Substring(0,10) %>-<%# Eval("name") %></font><br />
                                                                <font size="2"><b><span> <%# Eval("taskName") %></span></b></font>
                                                                <p><%# Eval("description") %></p>
                                                            </div>
                                                            <div class="past-statistic-graph">
                                                                
                                                            <div class="past-statistic-graph">
                                                                <table>


                                                                    <tr>
                                                                        <td>
                                                                            <asp:LinkButton Style="border-radius: 50%; float: right; padding-top: 26%; padding-bottom: 19%; margin-bottom: 0px;" ID="deletebutton" runat="server" CommandArgument='<%# Eval("taskId") %>' class="btn btn-default btn-icon-notika waves-effect" CommandName="delete"><i class="notika-icon notika-close"></i></asp:LinkButton>

                                                                        </td>

                                                                    </tr>
                                                                    <tr>
                                                                        <td>

                                                                            <div class="form-ic-cmp"><i class="notika-icon notika-refresh"></i></div>
                                                                        </td>
                                                                        
                                                                    </tr>
                                                                    <tr>
                                                                        <td><div class="form-ic-cmp" style="width: 100%; padding: 0px; display: flex;">
                                                                            <asp:LinkButton ID="openbutton" runat="server"  class="btn btn-reco-mg btn-button-mg waves-effect" style="padding:0px; width:100%; font-weight:bold;" CommandArgument='<%# Eval("taskId") %>' CommandName="open">...</asp:LinkButton>
                                                                        </div>
                                                                            </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </ul>
                                            </FooterTemplate>
                                        </asp:Repeater>

                                    </div>
                                    <div id="revision-form">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12 col-sm-12 col-xs-12 todo-inputbar">
                                                <div class="form-group todo-flex">
                                                    <div class="todo-send">
                                                       <asp:LinkButton class="btn-primary btn-md btn-block btn notika-add-todo" id="revisionbutton" runat="server" OnClick="revisionbutton_Click"  >Add</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-6 col-xs-12">
                        <div class="add-todo-list notika-shadow mg-t-30">
                            <div class="realtime-ctn">
                                <div class="realtime-title">
                                    <h2>Check</h2>
                                </div>
                            </div>
                            <div class="card-box">
                                <div class="todoapp">
                                    <div class="notika-todo-scrollbar">
                                        <asp:Repeater ID="checklistrepeater" runat="server" OnItemCommand="checklistrepeater_ItemCommand">
                                            <HeaderTemplate>
                                                <ul class="list-group no-margn todo-list connectedSortable" style="height: 100%; background-color: #82d9c0; border-radius: 5px;" id="checklist">
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <li class="ui-state-default">
                                                                <input id="taskId" runat="server" type="hidden" value='<%# Eval("taskId") %>' />
                                                    <div style="background-color: #a1f2de; border-radius: 5px;">
                                                        <div class="past-statistic-an">
                                                            <div class="past-statistic-ctn\">
                                                                <font size="1" style="color:gray;"><%# Eval("taskDate").ToString().Substring(0,10) %>-<%# Eval("name") %></font><br />
                                                                <font size="2"><b><span> <%# Eval("taskName") %></span></b></font>
                                                                <p><%# Eval("description") %></p>
                                                            </div>
                                                               
                                                            <div class="past-statistic-graph">
                                                                <table>


                                                                    <tr>
                                                                        <td>
                                                                            <asp:LinkButton Style="border-radius: 50%; float: right; padding-top: 26%; padding-bottom: 19%; margin-bottom: 0px;" ID="deletebutton" runat="server" CommandArgument='<%# Eval("taskId") %>' class="btn btn-default btn-icon-notika waves-effect" CommandName="delete"><i class="notika-icon notika-close"></i></asp:LinkButton>

                                                                        </td>

                                                                    </tr>
                                                                    <tr>
                                                                        <td>

                                                                            <div class="form-ic-cmp"><i class="notika-icon notika-star"></i></div>
                                                                        </td>
                                                                        
                                                                    </tr>
                                                                    <tr>
                                                                        <td><div class="form-ic-cmp" style="width: 100%; padding: 0px; display: flex;">
                                                                            <asp:LinkButton ID="openbutton" runat="server"  class="btn  btn-reco-mg btn-button-mg waves-effect" style="padding:0px; width:100%; font-weight:bold;" CommandArgument='<%# Eval("taskId") %>' CommandName="open">...</asp:LinkButton>
                                                                        </div>
                                                                            </td>
                                                                    </tr>
                                                                </table>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </ul>
                                            </FooterTemplate>
                                        </asp:Repeater>

                                    </div>
                                    <div id="check-form">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12 col-sm-12 col-xs-12 todo-inputbar">
                                                <div class="form-group todo-flex">
                                                    <div class="todo-send">
                                                        <asp:LinkButton class="btn-primary btn-md btn-block btn notika-add-todo" id="checkbutton" runat="server" OnClick="checkbutton_Click" >Add</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-6 col-xs-12">
                        <div class="add-todo-list notika-shadow mg-t-30">
                            <div class="realtime-ctn">
                                <div class="realtime-title">
                                    <h2>Done</h2>
                                </div>
                            </div>
                            <div class="card-box">
                                <div class="todoapp">
                                    <div class="notika-todo-scrollbar">
                                        <asp:Repeater ID="donelistrepeater" runat="server" OnItemCommand="donelistrepeater_ItemCommand">
                                            <HeaderTemplate>
                                                <ul class="list-group no-margn todo-list connectedSortable" style="border-radius: 5px; height: 100%; background-color: #82d9c0;" id="donelist">
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <li class="ui-state-default">
                                                                <input id="taskId" runat="server" type="hidden" value='<%# Eval("taskId") %>' />
                                                    <div style="background-color: #a1f2de; border-radius: 5px;">
                                                        <div class="past-statistic-an">
                                                            <div class="past-statistic-ctn\">
                                                                <font size="1" style="color:gray;"><%# Eval("taskDate").ToString().Substring(0,10) %>-<%# Eval("name") %></font><br />
                                                                <font size="2"><b><span> <%# Eval("taskName") %></span></b></font>
                                                                <p><%# Eval("description") %></p>
                                                            </div>
                                                            <div class="past-statistic-graph">
                                                                
                                                            <div class="past-statistic-graph">
                                                                <table>


                                                                    <tr>
                                                                        <td>
                                                                            <asp:LinkButton Style="border-radius: 50%; float: right; padding-top: 26%; padding-bottom: 19%; margin-bottom: 0px;" ID="deletebutton" runat="server" CommandArgument='<%# Eval("taskId") %>' class="btn btn-default btn-icon-notika waves-effect" CommandName="delete"><i class="notika-icon notika-close"></i></asp:LinkButton>

                                                                        </td>

                                                                    </tr>
                                                                    <tr>
                                                                        <td>

                                                                            <div class="form-ic-cmp"><i class="notika-icon notika-checked"></i></div>
                                                                        </td>
                                                                        
                                                                    </tr>
                                                                    <tr>
                                                                        <td><div class="form-ic-cmp" style="width: 100%; padding: 0px; display: flex;">
                                                                            <asp:LinkButton ID="openbutton" runat="server"  class="btn btn-reco-mg btn-button-mg waves-effect" style="padding:0px; width:100%; font-weight:bold;" CommandArgument='<%# Eval("taskId") %>' CommandName="open">...</asp:LinkButton>
                                                                        </div>
                                                                            </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </ul>
                                            </FooterTemplate>
                                        </asp:Repeater>

                                    </div>
                                    <div id="done-form">
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12 col-sm-12 col-xs-12 todo-inputbar">
                                                <div class="form-group todo-flex">
                                                    <div class="todo-send">
                                                       <asp:LinkButton class="btn-primary btn-md btn-block btn notika-add-todo" id="donebutton" runat="server" OnClick="donebutton_Click"  >Add</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div class="footer-copyright-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="footer-copy-right">
                        <p>Copyright © 2021 <a href="http://sezeryildirim.online">sezeryildirim.online</a>.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/wow.min.js"></script>
    <script src="js/jquery-price-slider.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
    <script src="js/meanmenu/jquery.meanmenu.js"></script>
    <script src="js/counterup/jquery.counterup.min.js"></script>
    <script src="js/counterup/waypoints.min.js"></script>
    <script src="js/counterup/counterup-active.js"></script>
    <script src="js/scrollbar/jquery.mCustomScrollbar.concat.min.js"></script>
    <script src="js/jvectormap/jquery-jvectormap-2.0.2.min.js"></script>
    <script src="js/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
    <script src="js/jvectormap/jvectormap-active.js"></script>
    <script src="js/sparkline/jquery.sparkline.min.js"></script>
    <script src="js/sparkline/sparkline-active.js"></script>
    <script src="js/flot/jquery.flot.js"></script>
    <script src="js/flot/jquery.flot.resize.js"></script>
    <script src="js/flot/curvedLines.js"></script>
    <script src="js/flot/flot-active.js"></script>
    <script src="js/knob/jquery.knob.js"></script>
    <script src="js/knob/jquery.appear.js"></script>
    <script src="js/knob/knob-active.js"></script>
    <script src="js/wave/waves.min.js"></script>
    <script src="js/wave/wave-active.js"></script>
    <script src="js/plugins.js"></script>
    <script src="js/chat/moment.min.js"></script>
    <script src="js/chat/jquery.chat.js"></script>
    <script src="js/main2.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
    <script src="update.js"></script>
    <script>
        $(function () {
            $("#todolist, #inprogresslist, #revisionlist, #checklist, #donelist").sortable({
                connectWith: ".connectedSortable"
            }).disableSelection();
        });
    </script>
</body>

</html>
