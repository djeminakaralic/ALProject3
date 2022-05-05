page 50094 "Payroll Role Center"
{
    Caption = 'Payroll', Comment = '{Dependency=Match,"ProfileDescription_Payroll"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)

        {
            part(Part4; 50086)
            {
                ApplicationArea = all;
            }

            group(rolegroup)
            {
                part(Part1; 50092)
                {
                    ApplicationArea = all;
                }
                part(Employees2; 5201)
                {


                    Caption = 'Employees for Calculation';
                    ApplicationArea = all;
                    SubPageView = WHERE("For Calculation" = filter(true));
                    // RunPageView = WHERE("For Calculation" = filter(true));


                }

                //  }
                // group(parts)
                // {
                /* part(Employees; 5201)
                 {
                     Caption = 'Active Employees';
                     ApplicationArea = all;
                     SubPageLink = Status = filter('Active');

                 }
                 part(Employees2; 5201)
                 {
                     Caption = 'Employees for Calculation';
                     ApplicationArea = all;
                     SubPageLink = "For Calculation" = filter(true);

                 }
                 part(Employees3; 5201)
                 {
                     Caption = 'Employees with meal calculation';
                     ApplicationArea = all;
                     SubPageLink = Meal = filter(true);

                 }

                 part(absence; 5212)
                 {

                     ApplicationArea = all;
                     //  }


                 }*/
                group(rolegroup2)
                {
                    part(Part3; 675)
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }


                }
            }
        }
    }
    actions
    {
        area(Processing)
        {


            group("Contribution")

            {
                Caption = 'Contribution Setup list';
                action("Contribution Setup")
                {
                    ApplicationArea = all;
                    Caption = 'Contribution Category List';
                    Image = ListPage;
                    RunObject = Page "Contribution Category List";
                    // ToolTip = 'View information to the customs and tax authorities for sales to other EU countries/regions. If the information must be printed to a file, you can use the VAT- VIES Declaration Disk report.';
                }
                action("Contribution Setup2")
                {
                    ApplicationArea = all;
                    Caption = 'Contribution Connections';
                    Image = ListPage;
                    RunObject = Page "Contribution Connections";
                    // ToolTip = 'View information to the customs and tax authorities for sales to other EU countries/regions. If the information must be printed to a file, you can use the VAT- VIES Declaration Disk report.';
                }
                action("Contribution Setup3")
                {
                    ApplicationArea = all;
                    Caption = 'Contribution List';
                    Image = ListPage;
                    RunObject = Page "Contribution List";
                    // ToolTip = 'View information to the customs and tax authorities for sales to other EU countries/regions. If the information must be printed to a file, you can use the VAT- VIES Declaration Disk report.';
                }
                action("Contribution Setup4")
                {
                    ApplicationArea = all;
                    Caption = 'Contribution Payment List';
                    Image = ListPage;
                    RunObject = Page "Contribution Payment Setup";
                    // ToolTip = 'View information to the customs and tax authorities for sales to other EU countries/regions. If the information must be printed to a file, you can use the VAT- VIES Declaration Disk report.';
                }





            }

            action("Calculation")
            {

                ApplicationArea = all;
                Caption = 'Čarobnjak za plate korak 1-Postavke obračuna';
                Image = ListPage;
                RunObject = Page "Wage Wizard Step 1";
            }
            group(Additions)

            {
                Caption = 'Additions';
                action("Aditions Type")
                {

                    ApplicationArea = all;
                    Caption = 'Wage Addition';
                    Image = ListPage;
                    RunObject = Page "Wage Addition";
                }
                action("Wage Aditions Type")
                {

                    ApplicationArea = all;
                    Caption = 'Wage Addition Type';
                    Image = ListPage;
                    RunObject = Page "Wage Addition Types";
                }
                action("Indirect Wage Addition Types")
                {

                    ApplicationArea = all;
                    Caption = 'Indirect Wage Addition Types';
                    Image = ListPage;
                    RunObject = page "Indirect Wage Addition Types";
                }



            }


            group(Reductions)
            {
                Caption = 'Reduction group';
                action("Reductions Type")
                {

                    ApplicationArea = all;
                    Caption = 'Reductions Type';
                    Image = ListPage;
                    RunObject = Page "Reduction types";
                }
                action("Wage Reduction Types")
                {

                    ApplicationArea = all;
                    Caption = 'Wage Reduction Types';
                    Image = ListPage;
                    RunObject = Page "Wage/Reduction Banks";
                }

                action("Wage Reduction Wage/Reduction bank accounts ")
                {

                    ApplicationArea = all;
                    Caption = 'Wage/Reduction bank accounts ';
                    Image = ListPage;
                    RunObject = Page "Wage/Reduction bank accounts";
                }

                action("Reduction LIst")
                {

                    ApplicationArea = all;
                    Caption = 'Reduction List';
                    Image = ListPage;
                    RunObject = Page "Reduction List";
                }


            }
            group(Reports)
            {
                Caption = 'Reports';
                action("Pay List")
                {

                    ApplicationArea = all;
                    Caption = 'Pay List';
                    Image = ListPage;
                    RunObject = report "Pay List";
                }
                action("Salary Specifications")
                {

                    ApplicationArea = all;
                    Caption = 'Salary Specification';
                    Image = ListPage;
                    RunObject = report "Salary specification";
                }

                action("MIP-1023")
                {

                    ApplicationArea = all;
                    Caption = 'MIP-1023';
                    Image = ListPage;
                    RunObject = report "MIP - 1023";
                }

                action("GIP-1022")
                {

                    ApplicationArea = all;
                    Caption = 'GIP-1022';
                    Image = ListPage;
                    RunObject = report "GIP-1022 ";
                }



            }
            group(Export)

            {
                Caption = 'Export';
                action("MIP")
                {

                    ApplicationArea = all;
                    Caption = 'Export MIP';
                    Image = ListPage;
                    RunObject = xmlport "MIP 1023";
                }

                action("GIP")
                {

                    ApplicationArea = all;
                    Caption = 'Export GIP';
                    Image = ListPage;
                    RunObject = xmlport "GIP 1022";
                }


            }

            action("Wage History")
            {

                ApplicationArea = all;
                Caption = 'Wage History';
                Image = ListPage;
                RunObject = page "Wage Header Card";
            }
            group(WageSetup)
            {
                Caption = 'Postings';

                action("Wage Setups")
                {

                    ApplicationArea = all;
                    Caption = 'Wage Setups';
                    Image = ListPage;
                    RunObject = page "Contribution Posting Setup";
                }
                action("Wage Setups Posting")
                {

                    ApplicationArea = all;
                    Caption = 'Wage Setups Posting';
                    Image = ListPage;
                    RunObject = page "Wage Posting Groups";
                }

            }
            group(AdditionsSetups)
            {

                Caption = 'Setup for Addition';
                action("Wage Types")
                {

                    ApplicationArea = all;
                    Caption = 'Wage Types';
                    Image = ListPage;
                    RunObject = page "Wage Types";
                }

                action("Causes of Absence")
                {

                    ApplicationArea = all;
                    Caption = 'Causes of Absence';
                    Image = ListPage;
                    RunObject = page "Causes of Absence";
                }
                action("Tax Classes")
                {

                    ApplicationArea = all;
                    Caption = 'Tax Classes';
                    Image = ListPage;
                    RunObject = page "Tax Classes";
                }
                action("Post Codes")
                {

                    ApplicationArea = all;
                    Caption = 'Post Codes';
                    Image = ListPage;
                    RunObject = page "Post Codes";
                }
                action("Municipality")
                {

                    ApplicationArea = all;
                    Caption = 'Municipality';
                    Image = ListPage;
                    RunObject = page Municipalities;
                }
                action("Cantons")
                {

                    ApplicationArea = all;
                    Caption = 'Cantons';
                    Image = ListPage;
                    RunObject = page Cantons;
                }




            }

            action("WageSetups")
            {

                ApplicationArea = all;
                Caption = 'Setup for wages';
                Image = ListPage;
                RunObject = page "Wage Setup";
            }
            action(Sheets)
            {

                ApplicationArea = all;
                Caption = 'TimeSheets';
                Image = ListPage;
                RunObject = page "Absence Registration";
            }

            action(CreateSheet)
            {

                ApplicationArea = all;
                Caption = 'Create TimeSheets';
                Image = ListPage;
                RunObject = report TimeSheet2;
            }

        }


    }

    var
        EmployeeList: Record Employee;

}

