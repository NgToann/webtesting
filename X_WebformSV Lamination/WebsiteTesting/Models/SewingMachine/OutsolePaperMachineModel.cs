﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.SewingMachine
{
    [Serializable]
    public class OutsolePaperMachineModel
    {
        public int OutsolePaperImageId { get; set; }
        public string SectionName { get; set; }
        public string LineName { get; set; }
        public string ProductNo { get; set; }
        public string StyleName { get; set; }
        public string OutsoleCode { get; set; }
        public string MachineType { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedDateString { get; set; }
        public string CreatedBy { get; set; }
        public string LeftImagePath { get; set; }
        public string LeftImageContent { get; set; }
        public string RightImagePath { get; set; }
        public string RightImageContent { get; set; }
        public string LeftImageDisplay { get; set; }
        public string RightImageDisplay { get; set; }
    }
}