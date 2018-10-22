<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmployeeRevenue_V4.aspx.cs" Inherits="Finance_OrderBook_EmployeeRevenue_V4" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>View All Orders</title> 
   
    <style type="text/css">
    .saveBtn
    {
        float: right !important;
        
    }
</style>

    <style type="text/css">
        .ImageButton
        {
            margin-left: 7px;
        }
        body
        {
            margin: 0px;
            padding: 0px;
            color: #333333; /*font-family: Verdana;*/
            font-family: "Segoe UI" ,Arial,Helvetica,sans-serif;
            font-size: 11px;
        }
         .blink_me
        {
        -webkit-animation-name: blinker;
        -webkit-animation-duration: 1s;
        -webkit-animation-timing-function: linear;
        -webkit-animation-iteration-count: infinite;

        -moz-animation-name: blinker;
        -moz-animation-duration: 1s;
        -moz-animation-timing-function: linear;
        -moz-animation-iteration-count: infinite;

        animation-name: blinker;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        
        color:Red !important;
        }

        @-moz-keyframes blinker 
        {
        0% { opacity: 1.0; }
        50% { opacity: 0.0; }
        100% { opacity: 1.0; }
        }

        @-webkit-keyframes blinker
        {
        0% { opacity: 1.0; }
        50% { opacity: 0.0; }
        100% { opacity: 1.0; }
        }

        @keyframes blinker
        {
        0% { opacity: 1.0; }
        50% { opacity: 0.0; }
        100% { opacity: 1.0; }
        }
    </style>
</head>
<body style=" font-family:Helvetica,Arial,sans-serif; font-size:small">
    <form id="form1" runat="server">
    <div style="margin: 0px 10px 0px 10px">
        <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" Skin="Metro" DecoratedControls="All" />
        <telerik:RadSkinManager ID="QsfSkinManager" runat="server" ShowChooser="false" Skin="Office2007">
        </telerik:RadSkinManager>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" CdnSettings-TelerikCdn="Disabled">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </telerik:RadScriptManager>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">

                function GridCreated(sender, args) {
                    var scrollArea = sender.GridDataDiv;
                    var dataHeight = sender.get_masterTableView().get_element().clientHeight; if (dataHeight < 450) {
                        scrollArea.style.height = dataHeight + 20 + "px";
                    }
                }


                function ShowEditForm(id, rowIndex) {
                    //alert('id =');
                    //ID = 'Ord_GES2017_1';
                    var grid = $find("<%= RadGridaccount.ClientID %>");

                    var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                    grid.get_masterTableView().selectItem(rowControl, true);

                    window.radopen("OrderForm.aspx?id=" + id, "UserListDialog");
                    return false;
                }
                function Clicking(sender, args) {
                    window.radopen("OrderForm.aspx", "UserListDialog");
                    return false;
                }
               

            </script>
        </telerik:RadCodeBlock>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
             <telerik:AjaxSetting AjaxControlID="RadGrid1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Metro">
        </telerik:RadAjaxLoadingPanel>
        <telerik:RadNotification ID="RadNotificationmsg" runat="server" Position="Center"
            OffsetY="0" OffsetX="-20" Width="100%" Height="60" Animation="Fade" EnableRoundedCorners="true"
            EnableShadow="true" Style="z-index: 100000" AutoCloseDelay="1000" ShowTitleMenu="false"
            VisibleTitlebar="false" EnableEmbeddedSkins="true">
        </telerik:RadNotification>
        <telerik:RadToolTip ID="tooltipcatch" runat="server" Animation="FlyIn" Position="BottomCenter"
            IsClientID="true" ShowCallout="false" Skin="Sunset" Text="The application has encountered an unknown error.
                              It doesn't appear to have affected your data, but our technical staff have been 
                              automatically notified and will be looking into this with the utmost urgency."
            AutoCloseDelay="10000" Width="100%">
        </telerik:RadToolTip>
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow ID="UserListDialog" runat="server" Modal="true" CenterIfModal="true"
                    Behaviors="Close,Maximize" Left="77px" Top="32px" Title="Order Form  Add/Edit"
                    Width="100%" Height="600px" Animation="FlyIn" AnimationDuration="200" ReloadOnShow="true"
                    ShowContentDuringLoad="true" VisibleStatusbar="false" ShowOnTopWhenMaximized="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
        <div class="paraHead">
            <center>
                <h3 style="color: #0067a9">
                    Staffing (T & M) - Update PO/SOW/MSA Details
                </h3>
            </center>
        </div>

<%--            <telerik:RadGrid RenderMode="Lightweight" ID="RadGridaccount" runat="server" DataSourceID="SqlDataSource1"
            AutoGenerateColumns="false" Font-Names="Helvetica,Arial,sans-serif" Font-Size="Small"
            AllowFilteringByColumn="true" ShowStatusBar="true" ShowFooter="true"  CommandItemStyle-CssClass="saveBtn"
            CellSpacing="0" EnableLinqExpressions="false" GridLines="None" FilterType="Combined"
            OnItemUpdated="RadGridaccount_ItemUpdated" OnFilterCheckListItemsRequested="RadGridaccount_FilterCheckListItemsRequested">--%>
            <telerik:RadGrid RenderMode="Lightweight" ID="RadGridaccount" runat="server" AllowSorting="true" AutoGenerateColumns="False"
                        OnItemUpdated="RadGrid1_ItemUpdated" OnFilterCheckListItemsRequested="RadGridaccount_FilterCheckListItemsRequested"
                        Width="100%" AllowFilteringByColumn="true" ShowStatusBar="true" ShowFooter="true"  CommandItemStyle-CssClass="saveBtn"
                        CellSpacing="0" EnableLinqExpressions="false" GridLines="None" FilterType="Combined"
                        DataSourceID="SqlDataSource1" AllowAutomaticUpdates="True">
             <%--<ClientSettings>
                <ClientEvents OnGridCreated="GridCreated"  />
                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="4"></Scrolling>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>--%>
            <ClientSettings AllowColumnsReorder="true" ReorderColumnsOnClient="true">
                            <ClientEvents OnGridCreated="GridCreated"  />
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" ></Scrolling>
                <Selecting AllowRowSelect="true" />
                        </ClientSettings>
            <%--<MasterTableView TableLayout="Fixed" EnableHeaderContextMenu="true" CommandItemDisplay="TopAndBottom" EditMode="Batch" DataKeyNames="Emp_Id">--%>
            <MasterTableView TableLayout="Fixed" EnableHeaderContextMenu="true" CommandItemDisplay="TopAndBottom" EditMode="Batch" DataKeyNames="Emp_Id">
            <BatchEditingSettings EditType="Cell" />
            <%--<CommandItemSettings ShowCancelChangesButton="false" ShowAddNewRecordButton="false" SaveChangesText="Save Changes" />--%>
                <CommandItemSettings ShowCancelChangesButton="false" ShowAddNewRecordButton="false" SaveChangesText="Save Changes" />
            <Columns>
                                                                <telerik:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="##" AllowFiltering="false"
                                    Groupable="false" Reorderable="false" ReadOnly="true">
                                    <ItemTemplate>
                                        <%# Container.DataSetIndex+1 %>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                                    <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn UniqueName="Emp_Id" HeaderText="EMP ID" AllowFiltering="false"
                                    DataField="Emp_Id" Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    ReadOnly="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                    <FooterStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn UniqueName="Employee_name" HeaderText="EMPLOYEE NAME" ReadOnly="true"
                                    DataField="Employee Name" Groupable="true" Reorderable="true" AllowSorting="true"
                                    DataType="System.String" FilterCheckListEnableLoadOnDemand="true" FilterControlWidth="80px"
                                    FilterListOptions="VaryByDataType">
                                    <HeaderStyle HorizontalAlign="left" VerticalAlign="Middle" Width="115px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" Width="115px" />
                                    <FooterStyle HorizontalAlign="left" VerticalAlign="Middle" Width="115px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn UniqueName="Client_name" HeaderText="CLIENT NAME" DataField="Client Name"
                                    ReadOnly="true" Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    FilterCheckListEnableLoadOnDemand="true" FilterControlWidth="80px" FilterListOptions="VaryByDataType">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    <FooterStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn UniqueName="Project_Name" HeaderText="PROJECT NAME" ReadOnly="true"
                                    DataField="Project Name" Groupable="true" Reorderable="true" AllowSorting="true"
                                    DataType="System.String" FilterCheckListEnableLoadOnDemand="true" FilterControlWidth="80px"
                                    FilterListOptions="VaryByDataType">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    <FooterStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn UniqueName="Delivery_Model" HeaderText="DELIVERY MODEL"  Display=false
                                    DataField="Delivery Model" Groupable="true" Reorderable="true" AllowSorting="true"
                                    DataType="System.String" ReadOnly="true" FilterCheckListEnableLoadOnDemand="true"
                                    FilterControlWidth="80px" FilterListOptions="VaryByDataType">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    <FooterStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn UniqueName="Sub_Classification" HeaderText="SUB CLASSIFICATION"  Display=false
                                    DataField="Sub Classification" Groupable="true" Reorderable="true" AllowSorting="true"
                                    DataType="System.String" ReadOnly="true" FilterCheckListEnableLoadOnDemand="true"
                                    FilterControlWidth="80px" FilterListOptions="VaryByDataType">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    <FooterStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn UniqueName="Currency" HeaderText="CURRENCY" DataField="RevenueCurrency" AllowFiltering="false"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    ReadOnly="true" FilterCheckListEnableLoadOnDemand="true" FilterControlWidth="50px"
                                    FilterListOptions="VaryByDataType">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="90px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="90px" />
                                    <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="90px" />
                                </telerik:GridBoundColumn>


                                <telerik:GridBoundColumn UniqueName="Revenue" HeaderText="REVENUE" DataField="Revenue" AllowFiltering="false"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    DataFormatString="{0:N}" FooterAggregateFormatString="{0:N}" ReadOnly="true"
                                    FilterCheckListEnableLoadOnDemand="true" FilterControlWidth="50px" FilterListOptions="VaryByDataType">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                    <FooterStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn UniqueName="RevenueINR" HeaderText="REVENUE INR" DataField="Revenue INR" Display="false"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    Aggregate="Sum" DataFormatString="{0:N}" FooterAggregateFormatString="{0:N}"
                                    ReadOnly="true" FilterCheckListEnableLoadOnDemand="true" FilterControlWidth="50px"
                                    FilterListOptions="VaryByDataType">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                    <FooterStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn UniqueName="RevenueUSD" HeaderText="REVENUE USD" DataField="Revenue USD"  Display="false"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    Aggregate="Sum" DataFormatString="{0:N}" FooterAggregateFormatString="{0:N}"
                                    ReadOnly="true" FilterCheckListEnableLoadOnDemand="true" FilterControlWidth="50px"
                                    FilterListOptions="VaryByDataType">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                    <FooterStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                </telerik:GridBoundColumn>

                                <telerik:GridTemplateColumn HeaderText="PONO" UniqueName="PoNOSOWMSA" DataField="PONO"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                    <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                    <ItemTemplate>
                                        <%# Eval("PONO")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtPONO" runat="server" Text="100px">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="PO_StartDate" UniqueName="PO_StartDate" DataField="PO_StartDate"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" />
                                    <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" />
                                    <ItemTemplate>
                                        <%# Eval("PO_StartDate")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDatePicker ID="txtStartDate" runat="server" Skin="Metro" Width="110px">
                                            <Calendar runat="server" ID="Calendar2" runat="server" EnableKeyboardNavigation="false">
                                            </Calendar>
                                            <DateInput ID="DateInput1" runat="server" ToolTip="Click Calender Image" ReadOnly="true"
                                                DateFormat="dd/MMM/yyyy">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="PO_EndDate" UniqueName="PO_EndDate" DataField="PO_EndDate"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" />
                                    <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" />
                                    <ItemTemplate>
                                        <%# Eval("PO_EndDate")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDatePicker ID="txtEndDate" runat="server" Skin="Metro" Width="110px">
                                            <Calendar runat="server" ID="Calendar2" runat="server" EnableKeyboardNavigation="false">
                                            </Calendar>
                                            <DateInput ID="DateInput1" runat="server" ToolTip="Click Calender Image" ReadOnly="true"
                                                DateFormat="dd/MMM/yyyy">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="SOW" UniqueName="SOW" DataField="SOW"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                    <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                    <ItemTemplate>
                                        <%# Eval("SOW")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtsow" runat="server" Text="100px">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="SOW_StartDate" UniqueName="SOW_StartDate" DataField="SOW_StartDate"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" />
                                    <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" />
                                    <ItemTemplate>
                                        <%# Eval("SOW_StartDate")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDatePicker ID="SOW_txtStartDate" runat="server" Skin="Metro" Width="110px">
                                            <Calendar runat="server" ID="Calendar2" runat="server" EnableKeyboardNavigation="false">
                                            </Calendar>
                                            <DateInput ID="DateInput1" runat="server" ToolTip="Click Calender Image" ReadOnly="true"
                                                DateFormat="dd/MMM/yyyy">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="SOW_EndDate" UniqueName="SOW_EndDate" DataField="SOW_EndDate"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" />
                                    <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" />
                                    <ItemTemplate>
                                        <%# Eval("SOW_StartDate")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDatePicker ID="SOW_txtEndDate" runat="server" Skin="Metro" Width="110px">
                                            <Calendar runat="server" ID="Calendar2" runat="server" EnableKeyboardNavigation="false">
                                            </Calendar>
                                            <DateInput ID="DateInput2" runat="server" ToolTip="Click Calender Image" ReadOnly="true"
                                                DateFormat="dd/MMM/yyyy">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="MSA" UniqueName="MSA" DataField="MSA"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                    <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                    <ItemTemplate>
                                        <%# Eval("MSA")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtMSA" runat="server" Text="100px">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="MSA_StartDate" UniqueName="MSA_StartDate" DataField="MSA_StartDate"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" />
                                    <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" />
                                    <ItemTemplate>
                                        <%# Eval("MSA_StartDate")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDatePicker ID="MSA_txtStartDate" runat="server" Skin="Metro" Width="110px">
                                            <Calendar runat="server" ID="Calendar2" runat="server" EnableKeyboardNavigation="false">
                                            </Calendar>
                                            <DateInput ID="DateInput1" runat="server" ToolTip="Click Calender Image" ReadOnly="true"
                                                DateFormat="dd/MMM/yyyy">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="MSA_EndDate" UniqueName="MSA_EndDate" DataField="MSA_EndDate"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" />
                                    <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="111px" />
                                    <ItemTemplate>
                                        <%# Eval("MSA_StartDate")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDatePicker ID="MSA_txtEndDate" runat="server" Skin="Metro" Width="110px">
                                            <Calendar runat="server" ID="Calendar2" runat="server" EnableKeyboardNavigation="false">
                                            </Calendar>
                                            <DateInput ID="DateInput2" runat="server" ToolTip="Click Calender Image" ReadOnly="true"
                                                DateFormat="dd/MMM/yyyy">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                               
                                    <telerik:GridTemplateColumn HeaderText="Status" UniqueName="UN_Status" DataField="Status"
                                    Groupable="true" Reorderable="true" AllowSorting="true" DataType="System.String"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                    <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                    <ItemTemplate>
                                        <%# Eval("Status")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlStatus" DataSourceID="SqlStatus" DataTextField="Status"
                                            DataValueField="Status" AppendDataBoundItems="true" runat="server" DropDownAutoWidth="Enabled"
                                            MaxHeight="100px" Skin="Office2010Blue" EmptyMessage="-- Select Status --">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                
                            </Columns>
            </MasterTableView>
            <HeaderStyle Width="200px" />
            <PagerStyle Mode="NextPrevAndNumeric" />
        </telerik:RadGrid>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:connect %>"

            SelectCommand="select cl.emp_id,(select empname from employee where emp_id=cl.emp_id)[Employee Name],
(select company_name from company where company_id=cl.client)[Client Name],--cl.client,
(select ProjectName from empprojects where projid=cl.project)[Project Name],--cl.project,
(select DeliveryModel from Delivery_Model where deliverymodelid=cl.DeliveryModel)[Delivery Model],--cl.DeliveryModel,
(select SC_NAME from Delivery_Model_SubCla where sc_id=cl.SubClass)[Sub Classification],--cl.SubClass,
Case when ((select TOP 1 Revenue_Currency from RM_CtcRevMaster where emp_id=cl.EMP_ID order by EDateRev desc)=0) THEN 'INR'
ELSE (Case when ((select TOP 1 Revenue_Currency from RM_CtcRevMaster where emp_id=cl.EMP_ID order by EDateRev desc)=1) THEN 'USD' ELSE 'NULL' end) END as
RevenueCurrency,
(select TOP 1 Revenue from RM_CtcRevMaster where emp_id=cl.EMP_ID order by EDateRev desc)Revenue,
CASE WHEN (select TOP 1 Revenue_Currency from RM_CtcRevMaster where emp_id=cl.EMP_ID order by EDateRev desc)=0 then 
((select TOP 1 Revenue from RM_CtcRevMaster where emp_id=cl.EMP_ID order by EDateRev desc)) else 
((select TOP 1 Revenue from RM_CtcRevMaster where emp_id=cl.EMP_ID order by EDateRev desc)*65) end as [Revenue INR],
CASE WHEN (select TOP 1 Revenue_Currency from RM_CtcRevMaster where emp_id=cl.EMP_ID order by EDateRev desc)=1 then 
((select TOP 1 Revenue from RM_CtcRevMaster where emp_id=cl.EMP_ID order by EDateRev desc)) 
else ((select TOP 1 Revenue from RM_CtcRevMaster where emp_id=cl.EMP_ID order by EDateRev desc)/65) end as [Revenue USD], 
(select o.PONO from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [PONO],(select Convert(nvarchar, o.PO_StartDate,106)PO_StartDate from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [PO_StartDate], (select Convert(nvarchar,o.PO_EndDate,106)PO_EndDate from OB_POSOWMSA o where o.emp_id=cl.EMP_ID)  [PO_EndDate],
(select o.SOW from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [SOW],(select Convert(nvarchar, o.SOW_StartDate,106)SOW_StartDate from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [SOW_StartDate], (select Convert(nvarchar,o.SOW_EndDate,106)SOW_EndDate from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [SOW_EndDate],
(select o.MSA from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [MSA],(select Convert(nvarchar, o.MSA_StartDate,106)MSA_StartDate from OB_POSOWMSA o where o.emp_id=cl.EMP_ID)  [MSA_StartDate],(select Convert(nvarchar,o.MSA_EndDate,106)MSA_EndDate from OB_POSOWMSA o where o.emp_id=cl.EMP_ID)  [MSA_EndDate],
(select o.Status from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [Status]
from clntass cl where cl.RtnFrmClnt is null and cl.status in (0,1) and cl.FinanceStatus=1 and cl.SubClass<>4 order by [Employee Name]"
            UpdateCommand="UPDATE [OB_POSOWMSA] SET [PONO] = @PONO, [PO_StartDate] = @PO_StartDate, [PO_EndDate] = @PO_EndDate,[SOW] = @SOW, [SOW_StartDate] = @SOW_StartDate, [SOW_EndDate] = @SOW_EndDate,[MSA] = @MSA, [MSA_StartDate] = @MSA_StartDate, [MSA_EndDate] = @MSA_EndDate,[Status]=@Status WHERE [Emp_Id] = @Emp_Id">
           <updateparameters>
                <%--<asp:Parameter Name="RevenueCurrency" Type="Int32"></asp:Parameter>--%>
                <asp:Parameter Name="PONO" Type="String"></asp:Parameter>
                <asp:Parameter Name="PO_StartDate" Type="DateTime"></asp:Parameter>
                <asp:Parameter Name="PO_EndDate" Type="DateTime"></asp:Parameter>
                <asp:Parameter Name="SOW" Type="String"></asp:Parameter>
                <asp:Parameter Name="SOW_StartDate" Type="DateTime"></asp:Parameter>
                <asp:Parameter Name="SOW_EndDate" Type="DateTime"></asp:Parameter>
                <asp:Parameter Name="MSA" Type="String"></asp:Parameter>
                <asp:Parameter Name="MSA_StartDate" Type="DateTime"></asp:Parameter>
                <asp:Parameter Name="MSA_EndDate" Type="DateTime"></asp:Parameter>
                <asp:Parameter Name="Emp_Id" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="Status" Type="String"></asp:Parameter>
            </updateparameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlStatus" ConnectionString="<%$ ConnectionStrings:connect %>"
        ProviderName="System.Data.SqlClient" SelectCommand="select 'Active' Status union select 'In-Active' status"
        runat="server"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlRevenueCurrency" ConnectionString="<%$ ConnectionStrings:connect %>"
        ProviderName="System.Data.SqlClient" SelectCommand="select Distinct  RevenueCurrency from OB_POSOWMSA where RevenueCurrency is NOT NULL"
        runat="server"></asp:SqlDataSource>
    </form>

    <%--cl where cl.ClntAssDtFrom<=getdate() and ((cl.RtnFrmClnt is null) or (cl.RtnFrmClnt >='4/1/2018' and cl.RtnFrmClnt<=getdate()) or (cl.RtnFrmClnt>=Getdate()))--%>
</body>
</html>
