using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;
using System.Text;
using System.IO;
using Telerik.Web.UI;
using System.Drawing;
using System.Web.Mail;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Telerik.Web.UI.Calendar;
using System.Threading;
using System.Globalization;
using System.Configuration;


public partial class Finance_OrderBook_EmployeeRevenue_V4 : System.Web.UI.Page
{
    SqlDatabaseConnection sqlDB = new SqlDatabaseConnection();
    string query = "", result = "";
    bool queryResult = true;
    List<SqlParameter> _sqlParameter = null;

    public void BindOrders()
    {



        string query = @" select cl.emp_id,(select empname from employee where emp_id=cl.emp_id)[Employee Name],
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
(select o.PONO from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [PONO],(select o.PO_StartDate from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [PO_StartDate], (select o.PO_EndDate from OB_POSOWMSA o where o.emp_id=cl.EMP_ID)  [PO_EndDate],
(select o.SOW from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [SOW],(select o.SOW_StartDate from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [SOW_StartDate], (select o.SOW_EndDate from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [SOW_EndDate],
(select o.MSA from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [MSA],(select o.MSA_StartDate from OB_POSOWMSA o where o.emp_id=cl.EMP_ID)  [MSA_StartDate],(select o.MSA_EndDate from OB_POSOWMSA o where o.emp_id=cl.EMP_ID)  [MSA_EndDate],
(select o.Status from OB_POSOWMSA o where o.emp_id=cl.EMP_ID) [Status]
from clntass cl where cl.RtnFrmClnt is null and cl.status in (0,1) and cl.FinanceStatus=1 and cl.SubClass<>4 order by [Employee Name]";

        DataTable dt = sqlDB.AdapterGetData(query, CommandType.Text, _sqlParameter);
        _sqlParameter = null;
        RadGridaccount.DataSource = dt;
    }

    protected void RadGridaccount_ItemCreated(object sender, GridItemEventArgs e)
    {

        if (e.Item is GridDataItem)
        {
            LinkButton savebutton = e.Item.FindControl("Save") as LinkButton;
            savebutton.CssClass = "savebtn";
        }
    }

    protected void RadGridaccount_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {

        BindOrders();
    }

    protected void Radrefresh_Click1(object sender, EventArgs e)
    {
        RadGridaccount.MasterTableView.FilterExpression = string.Empty;

        foreach (GridColumn column in RadGridaccount.MasterTableView.RenderColumns)
        {
            if (column is GridBoundColumn)
            {
                GridBoundColumn boundColumn = column as GridBoundColumn;
                boundColumn.CurrentFilterValue = string.Empty;
            }
        }
        RadGridaccount.MasterTableView.Rebind();
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        RadGridaccount.ExportSettings.Excel.Format = (GridExcelExportFormat)Enum.Parse(typeof(GridExcelExportFormat), "ExcelML");
        RadGridaccount.ExportSettings.IgnorePaging = false;
        RadGridaccount.ExportSettings.ExportOnlyData = true;
        RadGridaccount.ExportSettings.OpenInNewWindow = true;
        RadGridaccount.ExportSettings.FileName = "Orders Details";
        RadGridaccount.MasterTableView.ExportToExcel();
    }

    protected void RadGridaccount_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;


            Label lbl = (Label)item.FindControl("lblView");
            //string ordno = lbl.Text;

        }
    }

    protected void RadGridaccount_FilterCheckListItemsRequested(object sender, GridFilterCheckListItemsRequestedEventArgs e)
    {
        string DataField = (e.Column as IGridDataColumn).GetActiveDataField();

        switch (DataField)
        {
            case "Client Name":
                query = "select company_name as [Client Name] from Company where Status in('Active') and company_id in (select distinct client from clntass where FinanceStatus=1) order by [Client Name]";
                BindFilterData(query, "Client Name", e);
                break;

            case "Employee Name":
                query = "select empname as [Employee Name] from Employee where grp<>'ex-employee' and emp_id>1 and dept in (4,1,10) order by empname";
                BindFilterData(query, "Employee Name", e);
                break;

            case "Project Name":
                query = "select ProjectName as [Project Name] from Empprojects where projstatus='S' order by projectname";
                BindFilterData(query, "Project Name", e);
                break;

            case "PracName":
                query = "select P.PracName as PracName from Group_Practice_Mapping p where p.TA=1 and p.PracName not in ('Enabling') and PracticeId in (select distinct PracticeId from OTR_Proposal) ORDER BY PracName";
                BindFilterData(query, "PracName", e);
                break;


            case "SalesManager":
                query = "select empname from Employee where Dept in (5,6) and Grp<>'ex-employee' and EMP_iD in (select distinct salesmanager from OTR_Proposal) order by empname";
                BindFilterData(query, "SalesManager", e);
                break;

            case "fk_opplocat_customer":
                query = "select  location_name  from  OpportunityTracker_Location where location_type in('Customer','Both') order by location_name";
                BindFilterData(query, "location_name", e);
                break;

            case "DeliveryModel":
                query = "select DeliveryModel from Delivery_Model Where DeliveryModelId in (select distinct BusinessModel from OTR_Proposal) order by DeliveryModel";
                BindFilterData(query, "DeliveryModel", e);
                break;

            case "fk_oppcategory_id":
                query = "select  category  from  OpportunityTracker_Category";
                BindFilterData(query, "category", e);
                break;

            case "Currency":
                query = "select Distinct RevenueCurrency as RevenueCurrency from OB_POSOWMSA";
                BindFilterData(query, "Currency", e);
                break;

        }

    }

    private void BindFilterData(string query, string dataTextValue, GridFilterCheckListItemsRequestedEventArgs e)
    {
        e.ListBox.DataSource = sqlDB.AdapterGetData(query, CommandType.Text, _sqlParameter);
        e.ListBox.DataKeyField = dataTextValue;
        e.ListBox.DataTextField = dataTextValue;
        e.ListBox.DataValueField = dataTextValue;
        e.ListBox.DataBind();
        _sqlParameter = null;
    }

    protected void RadGridaccount_ItemUpdated(object source, Telerik.Web.UI.GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        String id = item.GetDataKeyValue("Emp_Id").ToString();
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            Response.Write("Product with ID " + id + " cannot be updated. Reason: " + e.Exception.Message);
        }
        else
        {
            Response.Write("Product with ID " + id + " is updated!");
        }
    }

    protected void RadGrid1_ItemUpdated(object source, Telerik.Web.UI.GridUpdatedEventArgs e)
    {
        GridEditableItem item = (GridEditableItem)e.Item;
        String id = item.GetDataKeyValue("Emp_Id").ToString();
        if (e.Exception != null)
        {
            e.KeepInEditMode = true;
            e.ExceptionHandled = true;
            //   Response.Write("Product with ID " + id + " cannot be updated. Reason: " + e.Exception.Message);
        }
        else
        {
            // Response.Write("Product with ID " + id + " is updated!");
        }
    }

}