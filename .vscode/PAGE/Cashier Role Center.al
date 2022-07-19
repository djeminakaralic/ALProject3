page 50107 "Cashier Role Center"
{
    Caption = 'Cashier', Comment = '{Dependency=Match,"ProfileDescription_Payroll"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control139; "Payrollgreeting")
            {
                ApplicationArea = all;
                Visible = true;

            }
            part("Payroll Activities"; "Payroll Activities")
            {
                ApplicationArea = all;
            }

        }
    }

    actions
    {
        area(processing)
        {                       
                  
    
            /*group("Pay Lists2")
            {
                Caption = 'Pay Lists';
                Image = Statistics;
                action("Pay Lists")
                {
                    ApplicationArea = all;
                    Caption = 'Pay Lists';
                    Image = Recalculate;
                    RunObject = Report "Pay List Final";
                }
                


            }*/          
                    
                    }
        area(reporting)
        {

            group(Summary)
            {
                Caption = 'Summary';
                Image = CashFlow;
                action("Sumarry per Payment Order")
                {
                    ApplicationArea = all;
                    Caption = 'Sumarry per Payment Orders';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Summary per Payment Orders";
                }
                action("Reduction per Banks")
                {
                    ApplicationArea = all;
                    Caption = 'Reduction per Banks';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Reduction per Banks";
                }
                /*  action("LAst Installment")
                  {
                      ApplicationArea = all;
                      Caption = 'Last Installment';
                      Image = "Report";
                      Promoted = false;
                      //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                      //PromotedIsBig = false;
                      RunObject = Report "TS_knjizenja 3";
                  }*/
                action("Payment List")
                {
                    ApplicationArea = all;
                    Caption = 'Payment List';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Payment List";
                }
                /* action("Pay List")
                 {
                     Caption = 'Pay List';
                     Image = "Report";
                     Promoted = false;
                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                     //PromotedIsBig = false;
                     RunObject = Report 60032;
                 }*/
                action("Sumarry per Employee")
                {

                    ApplicationArea = all;
                    Caption = 'Sumarry per Employee';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Summarry Per Employee";
                }
                action("Summary per Payment Type")
                {
                    ApplicationArea = all;
                    Caption = 'Summary per Payment Type';
                    Image = "Report";
                    RunObject = Report "Summary per Payment Type";
                }
                action("Summary per Payment hours")
                {
                    ApplicationArea = all;
                    Caption = 'Summary per Payment hours';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Summary per Payment Hours";
                }
                action("Summary per Payment Amounts")
                {
                    ApplicationArea = all;
                    Caption = 'Summary per Payment Amounts';
                    Image = "Report";
                    RunObject = Report "Summary per Payment Amounts";
                }
                action("Summary per years")
                {
                    ApplicationArea = all;
                    Caption = 'Summary per years';
                    Image = "Report";
                    RunObject = Report "Summary per years";
                }
                action("Employee Disability")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Disability';
                    Image = "Report";
                    RunObject = Report "Izvjestaj invalidet";
                }

            }


            action("Nalog knjiženja gotovinskih uplata")
            {
                ApplicationArea = all;
                Caption = 'Nalog knjiženja gotovinskih uplata';
                Image = Report;
                RunObject = Page "Cash Receipt Journal";
                //Cash Receipt Journal (255, Worksheet)
            }



            group(Forms)
            {
                Caption = 'Forms';
                Image = Transactions;
                action("Salary specification")
                {
                    ApplicationArea = all;
                    Caption = 'Form 2001-Salary specification';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Salary specification";
                }
                action("MIP - 1023")
                {
                    ApplicationArea = all;
                    Caption = 'MIP - 1023';
                    Image = Document;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "MIP - 1023";
                }
                action("MIP - 1023 Brčko distrikt")
                {
                    ApplicationArea = all;
                    Caption = 'MIP - 1023 Brčko distrikt';
                    Image = "Report";
                    Promoted = false;
                    Visible = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "MIP - 1023 Brčko distrikt";
                }
                action("MIP - 1023 BDPIOFBIH")
                {
                    ApplicationArea = all;
                    Caption = 'MIP - 1023 BDPIOFBIH';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "MIP - 1023 BDPIOFBIH";
                }
                action("GIP - 1022")

                {
                    ApplicationArea = all;
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;""
                    RunObject = Report "GIP-1022 ";
                    Visible = false;

                }
                action("GIP - 1022 Cumulative")
                {
                    ApplicationArea = all;
                    Caption = 'GIP - 1022 Cumulative';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "GIP-1022 Cumulative ";
                    Visible = false;
                }
                action("GIP - 1022 Brčko")
                {
                    ApplicationArea = all;
                    Caption = 'GIP-1022 Brčko';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "GIP-1022 Brcko";
                    Visible = false;
                }
                action("GIP-1022 New")
                {
                    ApplicationArea = all;
                    Caption = 'GIP-1022';
                    Image = "Report";
                    RunObject = Report "GIP-1022 New";
                }
                action("Rad-1")
                {
                    ApplicationArea = all;
                    Caption = 'Rad-1';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Rad-1";
                }
                action("Rad-1G")
                {
                    ApplicationArea = all;
                    Caption = 'Rad-1G';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Rad-1G";
                }
                action("Obrazac 1002")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac 1002';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Obrazac 1002-OL";
                    Visible = false;
                }
                action("Obrazac 1002 OL")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac 1002';
                    Image = "Report";
                    RunObject = Report "Obrazac 1002-DL1";
                }
                action("Obrazac 1002-OL Brcko")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac 1002-OL Brcko';
                    Image = "Report";
                    RunObject = Report "Obrazac 1002-OL Brcko";
                    Visible = false;
                }
                action("OLP-1021")
                {
                    ApplicationArea = all;
                    Caption = 'OLP-1021';
                    Image = "Report";
                    RunObject = Report "OLP-1021";
                }

                action("Obrazac DL-2")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac DL-2';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Obrazac DL-2";
                    Visible = false;
                }

                action("Obrazac 2001-A")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac 2001-A';
                    Image = "Report";
                    RunObject = Report "Obrazac 2001-A";
                    Visible = false;
                }
                action("Obrazac 2001-A Brcko")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac 2001-A Brcko';
                    Image = "Report";
                    RunObject = Report "Obrazac 2001-A Brcko";
                    Visible = false;
                }
                action("Obrazac DL-1")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac DL-1';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "DL1";
                }

            }

            group("Forms For Temporary Agreements")
            {
                Caption = 'Forms For Temporary Agreements';
                Image = Transactions;
                action("Temporary Work Form AUG-1031")
                {
                    Caption = 'Temporary Work Form AUG-1031';
                    ApplicationArea = all;
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Temporary Work Form AUG-1031";
                }

                action("Temporary Work Form ASD-1032")
                {
                    Caption = 'Temporary Work Form ASD-1032';
                    ApplicationArea = all;
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Temporary Work Form ASD-1032";
                }

                //
                action("Temporary Work Form PDN-1033")
                {
                    ApplicationArea = all;
                    Caption = 'Temporary Work Form PDN-1033';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Temporary Work Form PDN-1033";
                }
                action("Form AUG-1031-Author Contracts")
                {
                    ApplicationArea = all;
                    Caption = 'Form AUG-1031-Author Contracts';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Form AUG-1031-Author Contracts";
                }
                action("GIP - 1022 TC")
                {
                    ApplicationArea = all;
                    Caption = 'GIP - 1022 Temporary Contracts';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "GIP-1022 TC";
                }

            }

            group("Forms export")
            {
                Caption = 'Forms export';
                Image = SNInfo;
                action("Export MIP-1023")
                {
                    ApplicationArea = all;
                    Image = Export;
                    RunObject = XMLport "MIP 1023";
                }
                action("Export GIP-1022")
                {
                    ApplicationArea = all;
                    Caption = 'Export GIP-1022';
                    Image = Export1099;
                    RunObject = XMLport "GIP 1022";
                }
                //EmployeeData



            }

        }
    }
}


