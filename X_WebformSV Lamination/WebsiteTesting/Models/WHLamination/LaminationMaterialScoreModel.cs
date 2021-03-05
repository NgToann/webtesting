using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteTesting.Models.WHLamination
{
    [Serializable]
    public class LaminationMaterialScoreModel
    {
        public int LaminationMaterialScoreId { get; set; }
        public string OrderNoId { get; set; }
        public int RoundCheck { get; set; }
        public int POQuantity { get; set; }
        public int LabelQuantity { get; set; }
        public int ActualQuantity { get; set; }
        public int LabelWidth { get; set; }
        public int ActualWidth { get; set; }
        public int DefectType1 { get; set; }
        public int DefectType2 { get; set; }
        public int DefectType3 { get; set; }
        public int DefectType4 { get; set; }
        public int HoleType2 { get; set; }
        public int HoleType4 { get; set; }
        public int NoOfDefects { get; set; }
        public int TotalScore { get; set; }
        public string Reviser { get; set; }
        public int MaxRound { get; set; }
        public string Remarks { get; set; }
    }
}