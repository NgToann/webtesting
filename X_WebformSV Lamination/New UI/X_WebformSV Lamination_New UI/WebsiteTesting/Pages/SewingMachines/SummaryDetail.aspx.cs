using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebsiteTesting.Controllers.SewingMachineController;
using WebsiteTesting.Models.SewingMachine;

namespace WebsiteTesting.Pages.SewingMachines
{
    public partial class SummaryDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;

            var par = Request.Params["par"];
            if (!String.IsNullOrEmpty(par))
            {
                try
                {
                    string machineIdPar = par.Split('[')[0].ToString();
                    var fromToString = par.Split('[')[1].ToString();
                    int machineId = 0;
                    Int32.TryParse(machineIdPar, out machineId);

                    var fd = fromToString.Split('-')[0].ToString();
                    var td = fromToString.Split('-')[1].ToString();
                    double fdDouble = 0, tdDouble = 0;
                    Double.TryParse(fd, out fdDouble);
                    Double.TryParse(td, out tdDouble);
                    var fromDate = DateTime.FromOADate(fdDouble);
                    var toDate = DateTime.FromOADate(tdDouble);

                    var scheduleInTimeList = CommonController.GetScheduleFromTo(fromDate, toDate).Where(w => w.MachineId == machineId).ToList();
                    // Create DataTable
                    var regex = new Regex(@"\D");
                    tblReportDetail.Rows.Clear();

                    if (scheduleInTimeList.Count() > 0)
                        lblTitleReport.Text = String.Format("Schedule of {0}-{1} from {2:MM/dd} to {3:MM/dd}",
                                                            scheduleInTimeList.FirstOrDefault().MachineType,
                                                            scheduleInTimeList.FirstOrDefault().MachineName,
                                                            fromDate, toDate);

                    TableRow trHeader = new TableRow();

                    TableCell tchNo = new TableCell();
                    tchNo.Text = "<b><center>No</center></b>";

                    TableCell tchLineName = new TableCell();
                    tchLineName.Text = "<b><center>Line</center></b>";

                    TableCell tchStyle = new TableCell();
                    tchStyle.Text = "<b><center>Style</center></b>";

                    TableCell tchPM = new TableCell();
                    tchPM.Text = "<b><center>PM</center></b>";

                    TableCell tchFromDate = new TableCell();
                    tchFromDate.Text = "<b><center>Start</center></b>";

                    TableCell tchToDate = new TableCell();
                    tchToDate.Text = "<b><center>Finish</center></b>";

                    TableCell tchEdit = new TableCell();
                    tchEdit.Text = "<b><center>Edit</center></b>";

                    trHeader.Cells.Add(tchNo);
                    trHeader.Cells.Add(tchLineName);
                    trHeader.Cells.Add(tchStyle);
                    trHeader.Cells.Add(tchPM);
                    trHeader.Cells.Add(tchFromDate);
                    trHeader.Cells.Add(tchToDate);
                    trHeader.Cells.Add(tchEdit);

                    tblReportDetail.Rows.Add(trHeader);

                    int noOfRow = 1;
                    var scheduleIdList = scheduleInTimeList.Select(s => s.ScheduleId).Distinct().ToList();
                    foreach (var scheduleId in scheduleIdList)
                    {
                        var schedule = scheduleInTimeList.FirstOrDefault(f => f.ScheduleId == scheduleId);
                        TableRow trContent = new TableRow();

                        TableCell trcNo = new TableCell();
                        trcNo.Text = String.Format("<center>{0}</center>",noOfRow);

                        TableCell trcLineName = new TableCell();
                        trcLineName.Text = String.Format("{0}", schedule.LineName);

                        TableCell trcStyle = new TableCell();
                        trcStyle.Text = String.Format("{0}", schedule.Style);

                        TableCell trcPM = new TableCell();
                        trcPM.Text = String.Format("{0}", schedule.PatternNo);

                        TableCell trcFromDate = new TableCell();
                        trcFromDate.Text = String.Format("{0:MM/dd}", schedule.FromDate);

                        TableCell trcToDate = new TableCell();
                        trcToDate.Text = String.Format("{0:MM/dd}", schedule.ToDate);

                        TableCell trcLinkEdit = new TableCell();
                        var linkSchedule = new HyperLink
                        {
                            Text = "Edit",
                            NavigateUrl = String.Format("UpdateSchedule.aspx?par={0}[{1}-{2}[BckRp", schedule.ScheduleId, fromDate.ToOADate(), toDate.ToOADate()),
                            CssClass = "btn btn-outline-danger btn-sm"
                        };
                        trcLinkEdit.Controls.Add(linkSchedule);

                        trContent.Cells.Add(trcNo);
                        trContent.Cells.Add(trcLineName);
                        trContent.Cells.Add(trcStyle);
                        trContent.Cells.Add(trcPM);
                        trContent.Cells.Add(trcFromDate);
                        trContent.Cells.Add(trcToDate);
                        trContent.Cells.Add(trcLinkEdit);

                        tblReportDetail.Rows.Add(trContent);

                        noOfRow++;
                    }
                }
                catch
                {
                    return;
                }
            }
        }
    }
}