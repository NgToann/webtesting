using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebsiteTesting.Controllers.SewingMachineController;
using WebsiteTesting.Models.SewingMachine;

namespace WebsiteTesting.Pages.SewingMachines
{
    public partial class MachineDatabase : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;
            var allMachineList = CommonController.GetMachines();
            ViewState["allMachineList"] = allMachineList;

            var machineTypeList = new List<String>();
            machineTypeList.Add("None");
            machineTypeList.AddRange(allMachineList.Select(s => s.MachineType).Distinct().ToList());
            cboMachineType.DataSource = machineTypeList;
            cboMachineType.DataBind();
        }
        protected void cboMachineType_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearTextboxValue();
            var machineTypeSelected = cboMachineType.SelectedItem.Value as String;
            if (machineTypeSelected == null)
                return;
            ViewState["machineTypeSelected"] = machineTypeSelected;
        }
        protected void btnMachineNumberOK_Click(object sender, EventArgs e)
        {
            txtMachineBarcode.Text = "";
            var allMachineList = ViewState["allMachineList"] as List<MachineModel>;
            var machineTypeSelected = ViewState["machineTypeSelected"] as String;

            if (allMachineList == null || allMachineList.Count() == 0 || String.IsNullOrEmpty(machineTypeSelected))
            {
                ShowAlert(String.Format("Can not get machine list !"));
                return;
            }

            var allMachineByType = allMachineList.Where(w => w.MachineType == machineTypeSelected).ToList();

            var machineNumberInputted = txtMachineNumber.Text.ToString();
            var machineByMachineNumber = allMachineByType.FirstOrDefault(f => f.Number.ToString().Equals(machineNumberInputted));
            if (machineByMachineNumber == null)
            {
                ShowAlert(String.Format("MachineNumber: {0} does not exist in MachineType: {1}", machineNumberInputted, allMachineByType.FirstOrDefault().MachineType));
                return;
            }

            ViewState["machineByMachineNumber"] = machineByMachineNumber;
            txtMachineCode.Text     = machineByMachineNumber.Code.ToUpper().ToString();
            txtMachineBarcode.Text  = machineByMachineNumber.Barcode != null ? machineByMachineNumber.Barcode : "";
            btnSave.Enabled = true;
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            var barcodeInputted = txtMachineBarcode.Text.Trim().ToString();
            if(String.IsNullOrEmpty(barcodeInputted))
            {
                ShowAlert("Barcode is empty !");
                    return;
            }
            var machineUpdate = ViewState["machineByMachineNumber"] as MachineModel;
            machineUpdate.Barcode = barcodeInputted;

            // Update DB
            try
            {
                // Confirm update
                string confirmValue = Request.Form["confirm_value"];
                if (confirmValue.Equals("Yes"))
                {
                    CommonController.UpdateMachineBarcode(machineUpdate.MachineId, machineUpdate.Barcode);

                    var allMachineBeforeUpdate = ViewState["allMachineList"] as List<MachineModel>;
                    allMachineBeforeUpdate.RemoveAll(r => r.MachineId == machineUpdate.MachineId);
                    var machineListUpdated = allMachineBeforeUpdate.ToList();
                    machineListUpdated.Add(machineUpdate);
                    ViewState["allMachineList"] = machineListUpdated;
                    ShowAlert("Updated !");
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Barcode incorrect format (max lenght: 10)");
            }
        }
        private void ShowAlert(string msg)
        {
            string script = string.Format("alert('{0}');", msg);
            if (Page != null && !Page.ClientScript.IsClientScriptBlockRegistered("alert"))
            {
                Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "alert", script, true);
            }
        }
        private void ClearTextboxValue()
        {
            txtMachineCode.Text = "";
            txtMachineNumber.Text = "";
            txtMachineBarcode.Text = "";
            btnSave.Enabled = false;
        }
    }
}