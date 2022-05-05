page 50016 "Wage Setup"
{
    Caption = 'Wage Setup';
    CardPageID = "Wage Setup";
    // DelayedInsert = true;
    // DeleteAllowed = false;
    //InsertAllowed = false;
    PageType = Card;
    // Permissions = TableData 50016 = rimd;
    //RefreshOnActivate = true;
    //SaveValues = false;
    SourceTable = "Wage Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Average Yearly Hour Pool"; "Average Yearly Hour Pool")
                {
                }
                field("Wage Base"; "Wage Base")
                {
                }
                field("Work Experience Basis"; "Work Experience Basis")
                {
                }
                field("Base Personal Deduction"; "Base Personal Deduction")
                {
                }
                field("General Coefficient"; "General Coefficient")
                {
                }
                field("Type Of Work Percentage Calc."; "Type Of Work Percentage Calc.")
                {
                }
                field("Work Percentage"; "Work Percentage")
                {
                }
                field(Meal; Meal)
                {
                }
                field("Export Report Path"; "Export Report Path")
                {
                }
                field("RS Municipality Code"; "RS Municipality Code")
                {
                }
            }
            group("Payment Orders")
            {
                Caption = 'Payment Orders';
                field("Unemployment Federation"; "Unemployment Federation")
                {
                }
                field("Unemployment Canton"; "Unemployment Canton")
                {
                }
                field("Health Federation"; "Health Federation")
                {
                }
                field("Health Canton"; "Health Canton")
                {
                }
            }
            group("Chamber Fee")
            {
                Caption = 'Chamber fee';
                field("Brutto Rate"; "Brutto Rate")
                {
                }
                field("Chamber Rate(%)"; "Chamber Rate(%)")
                {
                }
                field("Chamber Fee Contribution Code"; "Chamber Fee Contribution Code")
                {
                }
            }
            group("Invalid Fund")
            {
                Caption = 'Invalid Fund';
                field("Invalid Fund Contribution Code"; "Invalid Fund Contribution Code")
                {
                }
                field("No. Of Employees"; "No. Of Employees")
                {
                }
                field("Invaalid Fund %"; "Invaalid Fund %")
                {
                }
            }
            group(Dates)
            {
                Caption = 'Codes';
                field("Day Unit of Measure"; "Day Unit of Measure")
                {
                }
                field("Hour Unit of Measure"; "Hour Unit of Measure")
                {
                }
                field("Holiday Code"; "Holiday Code")
                {
                }
                field("Holiday Description"; "Holiday Description")
                {
                }
                field("Workday Code"; "Workday Code")
                {
                }
                field("Workday Description"; "Workday Description")
                {
                }
                field("Hours in Day"; "Hours in Day")
                {
                }
                field("Wage Calendar Code"; "Wage Calendar Code")
                {
                }
                field("Wage Amount Code"; "Wage Amount Code")
                {
                }
                field("Brutto Calculation Code"; "Brutto Calculation Code")
                {
                }
                field("Transport No. Series"; "Transport No. Series")
                {
                }
                field("Reduction No. Series"; "Reduction No. Series")
                {
                }
                field("Meal No. Series"; "Meal No. Series")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        //INT1.0 start
        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        //INT1.0 end
    end;

    var
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

